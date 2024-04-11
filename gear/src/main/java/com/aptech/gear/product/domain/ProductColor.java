package com.aptech.gear.product.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
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
