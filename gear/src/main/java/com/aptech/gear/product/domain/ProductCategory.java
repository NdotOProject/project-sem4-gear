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
@Table(name = "product_categories")
public class ProductCategory {
	@Id
	private Long id;

	@Column(
			length = 100,
			nullable = false
	)
	private String name;

	private String description;

	@OneToMany(
			targetEntity = Product.class,
			mappedBy = "category"
	)
	private Set<Product> products;
}
