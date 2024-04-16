package com.aptech.gear.order.data;

import com.aptech.gear.order.domain.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderStatusRepository
        extends JpaRepository<OrderStatus, Long> {
}
