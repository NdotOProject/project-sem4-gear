package com.aptech.gear.product.data;

import com.aptech.gear.product.domain.ProductColor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductColorRepository
	extends JpaRepository<ProductColor, Long> {
}
