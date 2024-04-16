package com.aptech.gear.product.repository;

import com.aptech.gear.product.domain.ProductSizeRelationship;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductSizeRelRepository
		extends JpaRepository<ProductSizeRelationship, ProductSizeRelationship.Id> {
}
