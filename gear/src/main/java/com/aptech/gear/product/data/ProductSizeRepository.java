package com.aptech.gear.product.data;

import com.aptech.gear.product.domain.ProductSize;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductSizeRepository
	extends JpaRepository<ProductSize, Long> {
}
