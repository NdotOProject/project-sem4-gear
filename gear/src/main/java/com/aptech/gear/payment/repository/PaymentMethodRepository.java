package com.aptech.gear.payment.repository;

import com.aptech.gear.payment.domain.PaymentMethod;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PaymentMethodRepository
        extends JpaRepository<PaymentMethod, Long> {
}
