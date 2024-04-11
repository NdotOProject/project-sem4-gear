package com.aptech.gear.product.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "product_images")
public class ProductImage {
	@Id
	private Long id;

	private String url;

	private Boolean avatar;

	@ManyToOne(targetEntity = ProductColorRelationship.class)
	@JoinColumn(
			name = "product_color_relationship_id",
			nullable = false
	)
	private ProductColorRelationship productColorRelationship;
}
