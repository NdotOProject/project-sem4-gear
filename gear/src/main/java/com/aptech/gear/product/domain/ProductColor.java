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
@Table(name = "product_colors")
public class ProductColor {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(
			nullable = false,
			unique = true,
			length = 20
	)
	private String name;

	private String description;

	@OneToMany(
			targetEntity = ProductColorRelationship.class,
			mappedBy = "color"
	)
	private Set<ProductColorRelationship> productColorRelationships;
}
