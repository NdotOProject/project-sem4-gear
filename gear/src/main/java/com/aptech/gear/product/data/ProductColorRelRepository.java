package com.aptech.gear.product.data;

import com.aptech.gear.product.domain.ProductColorRelationship;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductColorRelRepository
extends JpaRepository<ProductColorRelationship, Long> {
}
