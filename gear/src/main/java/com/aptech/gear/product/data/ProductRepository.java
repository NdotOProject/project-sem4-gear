package com.aptech.gear.product.data;

import com.aptech.gear.product.domain.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository
		extends JpaRepository<Product, Long> {
}