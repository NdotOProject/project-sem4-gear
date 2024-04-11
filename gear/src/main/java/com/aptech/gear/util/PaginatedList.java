package com.aptech.gear.util;

import com.fasterxml.jackson.annotation.JsonIgnoreType;
import lombok.Getter;
import org.springframework.data.domain.Page;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.function.Function;
import java.util.stream.Collectors;

@Getter
@JsonIgnoreType
public class PaginatedList<T> {

	private final List<T> items;

	private final PaginationMetadata metadata;

	public PaginatedList(List<T> items, PaginationMetadata metadata) {
		this.metadata = Objects.requireNonNull(metadata, "metadata is null");
		this.items = items != null ? items : new ArrayList<>();
	}

	public PaginatedList(
			List<T> items,
			PaginationMetadata.Builder metadataBuilder) {
		this(items, Objects.requireNonNull(
				metadataBuilder.build(), "metadataBuilder is null"));
	}

	public PaginatedList(Page<T> page) {
		this(
				page.hasContent()
						? page.getContent()
						: new ArrayList<>(),
				PaginationMetadata.builder(page)
		);
	}

	public <E> PaginatedList<E> map(Function<T, E> mapper) {
		return new PaginatedList<>(
				items.stream().parallel()
						.map(mapper)
						.collect(Collectors.toList()),
				metadata
		);
	}

	public PaginatedList<T> limit(int size) {
		if (size > items.size()) {
			size = items.size();
		}

		return new PaginatedList<>(items.subList(0, size), metadata);
	}

	public boolean hasNext() {
		return metadata.nextPage() != null;
	}

	public boolean hasPrevious() {
		return metadata.previousPage() != null;
	}

	public void sort(Comparator<T> c) {
		items.sort(c);
	}

	public int size() {
		return items.size();
	}

	public T get(int index) {
		return items.get(index);
	}

	public T fisrt() {
		return get(0);
	}

	public T last() {
		return get(size() - 1);
	}

	public Map<String, Object> toJson() {
		// metadata
		Map<String, Number> map = new HashMap<>();

		map.put("total_records", this.metadata.getTotalRecords());
		map.put("total_pages", this.metadata.getTotalPages());
		map.put("current_page", this.metadata.getPageNumber());
		map.put("next_page", this.metadata.nextPage());
		map.put("prev_page", this.metadata.previousPage());

		Map<String, Object> json = new HashMap<>();

		// data
		json.put("data", getItems());

		json.put("pagination", map);

		return json;
	}
}
