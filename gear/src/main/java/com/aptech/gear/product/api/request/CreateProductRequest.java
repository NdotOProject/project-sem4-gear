package com.aptech.gear.product.api.request;

import com.aptech.gear.brand.data.BrandRepository;
import com.aptech.gear.product.data.ProductCategoryRepository;
import com.aptech.gear.product.domain.Product;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.math.BigInteger;
import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class CreateProductRequest {

	private String code;

	private Long brand;

	private Long category;

	private String name;

	private String description;

	private BigInteger price;

	private Set<Long> sizes;

	private Set<Long> colors;

	public static class Mapper
			extends com.aptech.gear.util.Mapper<CreateProductRequest, Product> {

		private final BrandRepository brandRepository;
		private final ProductCategoryRepository categoryRepository;

		public Mapper(
				BrandRepository brandRepository,
				ProductCategoryRepository categoryRepository
		) {
			super(CreateProductRequest.class, Product::new);

			this.brandRepository = brandRepository;
			this.categoryRepository = categoryRepository;
		}

		@Override
		protected void handle(CreateProductRequest src, Product dest) {
			dest.setCode(src.getCode());

			var brand = brandRepository.findById(src.getBrand());

			if (brand.isEmpty()) {
				throw new RuntimeException();
			}

			dest.setBrand(brand.get());

			var category = categoryRepository.findById(src.getCategory());

			if (category.isEmpty()) {
				throw new RuntimeException();
			}

			dest.setCategory(category.get());

			dest.setName(src.getName());

			dest.setDescription(src.getDescription());

			dest.setPrice(src.getPrice());
		}
	}
}
