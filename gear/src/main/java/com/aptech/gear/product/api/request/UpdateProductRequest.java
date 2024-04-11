package com.aptech.gear.product.api.request;

import com.aptech.gear.util.FieldMapping;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigInteger;
import java.util.Set;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class UpdateProductRequest {

	@FieldMapping
	private String name;

	@FieldMapping
	private String description;

	@FieldMapping
	private BigInteger price;

	@FieldMapping
	private Double rating;

	private Set<Long> sizes;

	private Set<Long> colors;
}
