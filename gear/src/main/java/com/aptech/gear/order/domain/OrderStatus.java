package com.aptech.gear.order.domain;

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
@Table(name = "order_statuses")
public class OrderStatus {
	@Id
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
