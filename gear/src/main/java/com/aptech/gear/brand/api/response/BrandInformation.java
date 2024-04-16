package com.aptech.gear.brand.api.response;

import com.aptech.gear.brand.domain.Brand;
import com.aptech.gear.product.domain.Product;
import com.aptech.gear.util.FieldMapping;
import com.aptech.gear.util.FieldTransformer;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class BrandInformation {
	@FieldMapping
	private Long id;

	@FieldMapping
	private String name;

	@FieldMapping
	private String description;

	@FieldMapping(
			transformer = @FieldTransformer(
					name = "transformProduct",
					provider = BrandInfoMapper.class,
					paramTypes = Set.class
			)
	)
	private Set<Long> products;

	public void transformProduct(Set<Product> products) {
		if (Objects.isNull(products)) {
			return;
		}

		var ids = new HashSet<Long>();

		products.stream()
				.map(Product::getId)
				.forEach(ids::add);

		setProducts(ids);
	}

	public static class Mapper
			extends com.aptech.gear.util.Mapper<Brand, BrandInformation> {

		public Mapper() {
			super(Brand.class, BrandInformation::new);
		}
	}
}
