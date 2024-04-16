package com.aptech.gear.order.domain;

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
@Table(name = "order_statuses")
public class OrderStatus {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(
			nullable = false,
			unique = true
	)
	private String name;

	private String description;

	@OneToMany(
			targetEntity = Order.class,
			mappedBy = "status"
	)
	private Set<Order> orders;
}
