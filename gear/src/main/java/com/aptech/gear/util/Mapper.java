package com.aptech.gear.util;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.function.Supplier;
import java.util.stream.Stream;

public class Mapper<S, D> {

    private final Supplier<D> consumer;
    private final List<MappedField> mappedFields;

    protected Mapper(Class<S> providerClass, Supplier<D> consumerInstanceProvider) {
        assert providerClass != null;
        assert consumerInstanceProvider != null;
        assert consumerInstanceProvider.get() != null;

        this.consumer = consumerInstanceProvider;

        this.mappedFields = readMappedFields(providerClass, consumer.get().getClass());
    }

/*
    !reverse -> field has been annotated is consumer;
 */
    private static List<MappedField> readMappedFields(Class<?> providerClass, Class<?> consumerClass) {
        final List<MappedField> result = new ArrayList<>();

        Stream.of(consumerClass.getDeclaredFields()).parallel()
                .forEach(destField -> {
                    final FieldMapping fieldMapping = destField.getDeclaredAnnotation(FieldMapping.class);

                    if (Objects.nonNull(fieldMapping)) {
                        try {
                            final Field providerField = providerClass.getDeclaredField(
                                    !fieldMapping.name().isEmpty()
                                            ? fieldMapping.name()
                                            : destField.getName()
                            );

                            Method transformer = getTranfomerMethod(fieldMapping.transformer());

                            if (providerField.trySetAccessible()
                                    && destField.trySetAccessible()) {
                                result.add(new MappedField(
                                        providerField, destField, transformer, fieldMapping.reverse()
                                ));
                            }
                        } catch (NoSuchFieldException e) {
                            throw new RuntimeException(e);
                        }
                    }
                });

        return result;
    }

    private static Method getTranfomerMethod(FieldTransformer transformer) {
        if (!transformer.name().isEmpty()) {
            try {
                final Method method = transformer.provider()
                        .getDeclaredMethod(transformer.name(), transformer.paramTypes());
                return method.trySetAccessible() ? method : null;
            } catch (NoSuchMethodException e) {
                return null;
            }
        }
        return null;
    }

    protected void handle(S src, D dest) {
    }

    public final D map(S src) {
        final D dest = consumer.get();

        if (!mappedFields.isEmpty()) {
            mappedFields.stream().parallel()
                    .forEach(mappedField -> mappedField.passValue(src, dest));
        }

        handle(src, dest);

        return dest;
    }

    private static class MappedField {

        enum PassValueTypes {
            // set value for field in transformer method.
            IN_METHOD,
            // use result return by transformer method to set value for field.
            USE_RESULT,
            // don't use transformer.
            NONE,
        }

        private final Field providerField, consumerField;
        private final boolean useTransformer;
        private final PassValueTypes passValueType;
        private final Method transformer;

        private MappedField(
                Field providerField,
                Field consumerField,
                Method transformer,
                boolean reverse) {

            Objects.requireNonNull(providerField);
            Objects.requireNonNull(consumerField);

            if (reverse) {
                this.providerField = consumerField;
                this.consumerField = providerField;
            } else {
                this.providerField = providerField;
                this.consumerField = consumerField;
            }

            // use transformer
            if (Objects.nonNull(transformer)) {

                //
                if (Objects.equals(void.class, transformer.getReturnType())) {
                    this.passValueType = PassValueTypes.IN_METHOD;
                }
                //
                else if (Objects.equals(
                        transformer.getReturnType(), consumerField.getType())) {
                    this.passValueType = PassValueTypes.USE_RESULT;
                }
                // invalid type will set to field
                else {
                    this.passValueType = PassValueTypes.NONE;
                }

                this.transformer = passValueType != PassValueTypes.NONE
                        ? transformer
                        : null;

                useTransformer = Objects.nonNull(this.transformer);
            }
            // don't use transformer
            else {
                this.transformer = null;
                this.useTransformer = false;
                this.passValueType = PassValueTypes.NONE;
            }
        }

        void passValue(Object provider, Object consumer) {
            try {
                final Object value = providerField.get(provider);

                // pass with transformer
                if (useTransformer) {
                    switch (passValueType) {
                        case IN_METHOD -> transformer.invoke(consumer, value);
                        case USE_RESULT -> consumerField.set(
                                consumer, transformer.invoke(consumer, value)
                        );
                        case NONE -> {
                        }
                    }
                }
                // pass without transformer
                else {
                    consumerField.set(consumer, value);
                }

            } catch (IllegalAccessException | InvocationTargetException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
