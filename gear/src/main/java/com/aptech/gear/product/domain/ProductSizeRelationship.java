package com.aptech.gear.product.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "product_size_relationship")
public class ProductSizeRelationship {
	@EmbeddedId
	private Id id;

	@MapsId("productId")
	@ManyToOne(targetEntity = Product.class)
	@JoinColumn(name = "product_id")
	private Product product;

	@MapsId("sizeId")
	@ManyToOne(targetEntity = ProductSize.class)
	@JoinColumn(name = "size_id")
	private ProductSize size;

	@Column(columnDefinition = "integer default 0")
	private Integer quantity;

	private String description;

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	@Embeddable
	public static class Id implements Serializable {
		@Column(
				name = "size_id",
				nullable = false
		)
		private Long sizeId;

		@Column(
				name = "product_id",
				nullable = false
		)
		private Long productId;
	}
}
