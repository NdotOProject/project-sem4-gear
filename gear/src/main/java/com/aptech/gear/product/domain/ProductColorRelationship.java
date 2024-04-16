package com.aptech.gear.product.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "product_color_relationship")
public class ProductColorRelationship {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(targetEntity = ProductColor.class)
	@JoinColumn(
			name = "color_id",
			nullable = false
	)
	private ProductColor color;

	@ManyToOne(targetEntity = Product.class)
	@JoinColumn(
			name = "product_id",
			nullable = false
	)
	private Product product;

	@Column(columnDefinition = "integer default 0")
	private Integer quantity;

	@OneToMany(
			targetEntity = ProductImage.class,
			mappedBy = "productColorRelationship"
	)
	private Set<ProductImage> images;
}
