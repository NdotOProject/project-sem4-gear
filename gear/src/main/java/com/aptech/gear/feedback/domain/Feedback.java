package com.aptech.gear.feedback.domain;

import com.aptech.gear.product.domain.Product;
import com.aptech.gear.user.domain.User;
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
@Table(name = "feedbacks")
public class Feedback {
	@Id
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

	private Integer rating;

	private Boolean updated;
}
