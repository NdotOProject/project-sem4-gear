package com.aptech.gear.order.repository;

import com.aptech.gear.order.domain.OrderDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderDetailRepository
        extends JpaRepository<OrderDetail, OrderDetail.Id> {
}
