package com.aptech.gear.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.function.BiFunction;
import java.util.function.BiPredicate;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Storage<K, V> {

    private final Map<K, V> data;

    public Storage() {
        this(null);
    }

    public Storage(Map<K, V> initial) {
        if (initial == null) {
            initial = new LinkedHashMap<>();
        }

        data = initial;
    }

    public boolean add(K key, V value) {
        data.putIfAbsent(key, value);
        return data.containsKey(key) && data.containsValue(value);
    }

    public boolean update(K key, V oldValue, V newValue) {
        if (key == null || oldValue == null) {
            throw new NullPointerException();
        }

        if (newValue == null) {
            return delete(key, oldValue);
        }

        StoredData<K, V> stored = get(key);

        if (stored.isEmpty()) {
            throw new UnsupportedOperationException("");
        }

        if (!Objects.equals(stored.value(null), oldValue)) {
            throw new UnsupportedOperationException("");
        }

        return data.replace(key, oldValue, newValue);
    }

    public boolean delete(K key) {
        return delete(key, null);
    }

    public boolean delete(K key, V value) {
        if (key == null) {
            throw new NullPointerException();
        }

        if (value == null) {
            value = data.get(key);
            V removed = data.remove(key);
            return Objects.equals(value, removed);
        }

        return data.remove(key, value);
    }

    public List<V> getRange(int start, int end) {
        return new ArrayList<>(data.values())
                .subList(start, end);
    }

    public void merge(Storage<K, V> other) {
        if (other != null) {
            data.putAll(other.data);
        }
    }

    public Stream<StoredData<K, V>> stream() {
        return data.entrySet()
                .stream().parallel()
                .map(StoredData::new);
    }

    public int size() {
        return data.size();
    }

    public StoredData<K, V> last() {
        return stream()
                .reduce((f, s) -> s)
                .orElseGet(StoredData::empty);
    }

    public StoredData<K, V> first() {
        return stream()
                .findFirst()
                .orElseGet(StoredData::empty);
    }

    public StoredData<K, V> get(K key) {
        if (key == null) {
            throw new NullPointerException();
        }

        return new StoredData<>(Map.entry(key, data.get(key)));
    }

    public StoredData<K, V> get() {
        return get((k, v) -> true);
    }

    public StoredData<K, V> get(BiPredicate<K, V> predicate) {
        return get(predicate, 0);
    }

    public StoredData<K, V> get(BiPredicate<K, V> predicate, int limit) {
        if (predicate == null) {
            throw new NullPointerException();
        }

        var query = data.entrySet()
                .stream()
                .filter((entry) -> predicate.test(
                        entry.getKey(),
                        entry.getValue()
                ));

        if (limit > 0) {
            query = query.limit(limit);
        }

        return new StoredData<>(
                query.collect(
                        Collectors.toMap(
                                Map.Entry::getKey, Map.Entry::getValue
                        )
                )
        );
    }

    public static final class StoredData<K, V> {

        private static final StoredData<?, ?> EMPTY
                = new StoredData<>(new HashMap<>());

        private final Map<K, V> data;

        private StoredData(Map<K, V> data) {
            if (data == null) {
                throw new UnsupportedOperationException();
            }

            this.data = data;
        }

        private StoredData(Map.Entry<K, V> data) {
            if (data == null) {
                throw new NullPointerException();
            }

            final Map<K, V> init = new HashMap<>();

            init.put(data.getKey(), data.getValue());

            this.data = init;
        }

        public static <K, V> StoredData<K, V> empty() {
            @SuppressWarnings("unchecked")
            StoredData<K, V> result = (StoredData<K, V>) EMPTY;
            return result;
        }

        public boolean isEmpty() {
            return data.isEmpty();
        }

        public boolean isPresent() {
            return !isEmpty();
        }

        public boolean isSingle() {
            return data.size() == 1;
        }

        public Map.Entry<K, V> entry(K key, V value) {
            if (isSingle()) {
                return entries().get(0);
            }
            return Map.entry(key, value);
        }

        public List<Map.Entry<K, V>> entries() {
            return new ArrayList<>(data.entrySet());
        }

        public K key(K safety) {
            if (isSingle()) {
                return keys().get(0);
            }
            return safety;
        }

        public List<K> keys() {
            return new ArrayList<>(data.keySet());
        }

        public V value(V safety) {
            if (isSingle()) {
                return values().get(0);
            }
            return safety;
        }

        public List<V> values() {
            return new ArrayList<>(data.values());
        }

        public <T> List<T> map(BiFunction<K, V, T> mapper) {
            return entries()
                    .stream()
                    .map(entry -> mapper.apply(
                            entry.getKey(), entry.getValue()
                    ))
                    .collect(Collectors.toList());
        }
    }
}
