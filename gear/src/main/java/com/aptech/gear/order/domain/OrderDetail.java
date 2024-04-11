package com.aptech.gear.order.domain;

import com.aptech.gear.product.domain.Product;
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
import java.math.BigInteger;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "order_details")
public class OrderDetail {
	@EmbeddedId
	private Id id;

	@ManyToOne(targetEntity = Order.class)
	@MapsId("orderId")
	@JoinColumn(
			name = "order_id",
			nullable = false,
			updatable = false
	)
	private Order order;

	@ManyToOne(targetEntity = Product.class)
	@MapsId("productId")
	@JoinColumn(
			name = "product_id",
			nullable = false,
			updatable = false
	)
	private Product product;

	@Column(nullable = false)
	private Integer quantity;

	@Column(
			name = "total_amount",
			nullable = false
	)
	private BigInteger totalAmount;

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	@Embeddable
	public static class Id implements Serializable {
		@Column(
				name = "order_id",
				nullable = false,
				updatable = false
		)
		private Long orderId;

		@Column(
				name = "product_id",
				nullable = false,
				updatable = false
		)
		private Long productId;
	}
}
