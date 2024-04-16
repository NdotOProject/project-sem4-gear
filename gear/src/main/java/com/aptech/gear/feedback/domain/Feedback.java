package com.aptech.gear.feedback.domain;

import com.aptech.gear.product.domain.Product;
import com.aptech.gear.user.domain.User;
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
@Table(name = "feedbacks")
public class Feedback {
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

	@ManyToOne(targetEntity = Product.class)
	@JoinColumn(
			name = "product_id",
			nullable = false,
			updatable = false
	)
	private Product product;

	private String content;

	private Double rating;

	private Boolean updated;
}
