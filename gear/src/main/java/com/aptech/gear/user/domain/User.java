package com.aptech.gear.user.domain;

import com.aptech.gear.feedback.domain.Feedback;
import com.aptech.gear.order.domain.Order;
import com.aptech.gear.voucher.domain.DiscountVoucher;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
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
@Table(name = "users")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(
			unique = true,
			nullable = false,
			updatable = false
	)
	private String email;

	@Column(nullable = false)
	private String password;

	private String avatar;

	@Column(nullable = false)
	private Boolean employee;

	@Column(nullable = false)
	private Boolean status;

	@ManyToMany(
			targetEntity = DiscountVoucher.class,
			mappedBy = "users"
	)
	private Set<DiscountVoucher> vouchers;

	@OneToMany(
			targetEntity = Feedback.class,
			mappedBy = "user"
	)
	private Set<Feedback> feedbacks;

	@OneToMany(
			targetEntity = Order.class,
			mappedBy = "user"
	)
	private Set<Order> orders;
}
