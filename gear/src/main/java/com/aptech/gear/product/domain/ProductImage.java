package com.aptech.gear.product.domain;

import jakarta.persistence.*;
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
	@GeneratedValue(strategy = GenerationType.IDENTITY)
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
