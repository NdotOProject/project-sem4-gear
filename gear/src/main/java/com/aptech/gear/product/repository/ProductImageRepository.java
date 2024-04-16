package com.aptech.gear.product.repository;

import com.aptech.gear.product.domain.ProductImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductImageRepository
		extends JpaRepository<ProductImage, Long> {
}
