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
@Table(name = "product_sizes")
public class ProductSize {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(
			length = 10,
			nullable = false,
			unique = true
	)
	private String value;

	private String description;

	@OneToMany(
			targetEntity = ProductSizeRelationship.class,
			mappedBy = "size"
	)
	private Set<ProductSizeRelationship> productSizeRelationships;
}
