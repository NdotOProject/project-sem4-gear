package com.aptech.gear.voucher.domain;

import com.aptech.gear.product.domain.Product;
import com.aptech.gear.user.domain.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;
import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "discount_vouchers")
public class DiscountVoucher {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToMany(
			targetEntity = Product.class
	)
	@JoinTable(
			name = "product_vouchers",
			inverseJoinColumns = @JoinColumn(
					name = "product_id",
					nullable = false
			),
			joinColumns = @JoinColumn(
					name = "voucher_id",
					nullable = false
			)
	)
	private Set<Product> products;

	@ManyToMany(
			targetEntity = User.class
	)
	@JoinTable(
			name = "user_vouchers",
			inverseJoinColumns = @JoinColumn(
					name = "user_id",
					nullable = false
			),
			joinColumns = @JoinColumn(
					name = "voucher_id",
					nullable = false
			)
	)
	private Set<User> users;

	@Column(
			length = 20,
			updatable = false,
			nullable = false,
			unique = true
	)
	private String code;

	@Column(
			name = "by_percentage",
			updatable = false,
			nullable = false
	)
	private Boolean byPercentage;

	@Column(
			name = "effective_date",
			nullable = false,
			updatable = false
	)
	private Timestamp effectiveDate;

	@Column(
			name = "expiration_date",
			nullable = false,
			updatable = false
	)
	private Timestamp expirationDate;

	@OneToMany(
			targetEntity = VoucherBanner.class,
			mappedBy = "voucher"
	)
	private Set<VoucherBanner> banners;
}
