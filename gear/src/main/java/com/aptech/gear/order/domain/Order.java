package com.aptech.gear.order.domain;

import com.aptech.gear.payment.domain.PaymentMethod;
import com.aptech.gear.user.domain.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "orders")
public class Order {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(targetEntity = User.class)
	@JoinColumn(
			name = "user_id",
			nullable = false,
			updatable = false
	)
	private User user;

	@ManyToOne(targetEntity = OrderStatus.class)
	@JoinColumn(
			name = "order_status_id",
			nullable = false
	)
	private OrderStatus status;

	@ManyToOne(targetEntity = PaymentMethod.class)
	@JoinColumn(
			name = "payment_method_id",
			nullable = false
	)
	private PaymentMethod paymentMethod;

	@Column(name = "payment_info")
	private String paymentInfo;

	@Column(name = "total_amount")
	private BigInteger totalAmount;

	@Column(name = "received_date")
	private Timestamp receivedDate;

	@Column(name = "delivery_address")
	private String deliveryAddress;

	@OneToMany(
			targetEntity = OrderDetail.class,
			mappedBy = "order"
	)
	private Set<OrderDetail> details;
}
