package com.aptech.gear.product.api.response;

import com.aptech.gear.feedback.domain.Feedback;
import com.aptech.gear.product.domain.Product;
import com.aptech.gear.util.FieldMapping;
import com.aptech.gear.voucher.domain.DiscountVoucher;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigInteger;
import java.util.Set;
import java.util.stream.Collectors;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class ProductInformation {
	@FieldMapping
	private Long id;

	@FieldMapping
	private String code;

	@FieldMapping
	private String name;

	@FieldMapping
	private String description;

	@FieldMapping
	private BigInteger price;

	@FieldMapping
	private Double rating;

	private Long brand;

	private Long category;

	private Set<Long> sizes;

	private Set<Long> colors;

	private Set<Long> vouchers;

	private Set<Long> feedbacks;

	public static class Mapper
			extends com.aptech.gear.util.Mapper<Product, ProductInformation> {

		public Mapper() {
			super(Product.class, ProductInformation::new);
		}

		@Override
		protected void handle(Product src, ProductInformation dest) {
			dest.setBrand(src.getBrand().getId());

			dest.setCategory(src.getCategory().getId());

			dest.setSizes(
					src.getProductSizeRelationships()
							.stream().parallel()
							.map(ps -> ps.getSize().getId())
							.collect(Collectors.toSet())
			);

			dest.setColors(
					src.getProductColorRelationships()
							.stream().parallel()
							.map(pc -> pc.getColor().getId())
							.collect(Collectors.toSet())
			);

			dest.setVouchers(
					src.getVouchers().stream()
							.map(DiscountVoucher::getId)
							.collect(Collectors.toSet())
			);

			dest.setFeedbacks(
					src.getFeedbacks().stream()
							.map(Feedback::getId)
							.collect(Collectors.toSet())
			);
		}
	}
}
