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

	private final Supplier<D> destinationProvider;
	private final List<MappedField> mappedFields;

	protected Mapper(
			Class<S> sourceClass,
			Supplier<D> destinationInstanceProvider) {
		assert sourceClass != null;
		assert destinationInstanceProvider != null;
		assert destinationInstanceProvider.get() != null;

		this.destinationProvider = destinationInstanceProvider;

//		noinspection unchecked
		this.mappedFields = readMappedFields(sourceClass,
				(Class<D>) destinationProvider.get().getClass());
	}

	private List<MappedField> readMappedFields(
			Class<S> sourceClass, Class<D> destClass) {
		final List<MappedField> result = new ArrayList<>();

		Stream.of(destClass.getDeclaredFields()).parallel()
				.forEach(destField -> {
					final FieldMapping requireAnnotation =
							destField.getDeclaredAnnotation(
									FieldMapping.class);

					if (Objects.nonNull(requireAnnotation)) {
						try {
							final Field srcField
									= sourceClass.getDeclaredField(
									!requireAnnotation.name().isEmpty()
											? requireAnnotation.name()
											: destField.getName()
							);

							Method transformer = null;

							if (!requireAnnotation.transformer().isEmpty()) {
								transformer = destClass.getDeclaredMethod(
										requireAnnotation.transformer(),
										srcField.getType()
								);

								transformer = transformer.trySetAccessible()
										              ? transformer
										              : null;
							}

							if (srcField.trySetAccessible()
									    && destField.trySetAccessible()) {
								result.add(new MappedField(
										srcField, destField, transformer
								));
							}
						} catch (NoSuchFieldException |
						         NoSuchMethodException e) {
							throw new RuntimeException(e);
						}
					}
				});

		return result;
	}

	protected void handle(S src, D dest) {
	}

	public final D map(S src) {
		final D dest = destinationProvider.get();

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
				Method transformer) {

			this.providerField = Objects.requireNonNull(providerField);
			this.consumerField = Objects.requireNonNull(consumerField);

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
