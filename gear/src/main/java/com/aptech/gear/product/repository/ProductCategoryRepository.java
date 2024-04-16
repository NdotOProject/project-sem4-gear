package com.aptech.gear.product.repository;

import com.aptech.gear.product.domain.ProductCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductCategoryRepository
		extends JpaRepository<ProductCategory, Long> {
}
