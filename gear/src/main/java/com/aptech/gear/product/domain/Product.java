package com.aptech.gear.product.domain;

import com.aptech.gear.brand.domain.Brand;
import com.aptech.gear.feedback.domain.Feedback;
import com.aptech.gear.order.domain.OrderDetail;
import com.aptech.gear.voucher.domain.DiscountVoucher;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigInteger;
import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "products")
public class Product {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(
			length = 20,
			unique = true
	)
	private String code;

	@Column(length = 100)
	private String name;

	private String description;

	@Column(nullable = false)
	private BigInteger price;

	@Column(columnDefinition = "double default 0.0")
	private Double rating;

	@ManyToOne(targetEntity = Brand.class)
	@JoinColumn(
			name = "brand_id",
			nullable = false
	)
	private Brand brand;

	@ManyToOne(targetEntity = ProductCategory.class)
	@JoinColumn(
			name = "category_id",
			nullable = false
	)
	private ProductCategory category;

	@OneToMany(
			targetEntity = ProductSizeRelationship.class,
			mappedBy = "product"
	)
	private Set<ProductSizeRelationship> productSizeRelationships;

	@OneToMany(
			targetEntity = ProductColorRelationship.class,
			mappedBy = "product"
	)
	private Set<ProductColorRelationship> productColorRelationships;

	@ManyToMany(
			targetEntity = DiscountVoucher.class,
			mappedBy = "products"
	)
	private Set<DiscountVoucher> vouchers;

	@OneToMany(
			targetEntity = Feedback.class,
			mappedBy = "product"
	)
	private Set<Feedback> feedbacks;

	@OneToMany(
			targetEntity = OrderDetail.class,
			mappedBy = "product"
	)
	private Set<OrderDetail> orderDetails;

	public Product(
			Long id,
			String code,
			String name,
			String description,
			BigInteger price,
			Double rating,
			Brand brand,
			ProductCategory category
	) {
		this.id = id;
		this.name = name;
		this.code = code;
		this.description = description;
		this.price = price;
		this.rating = rating;
		this.brand = brand;
		this.category = category;
	}
}
