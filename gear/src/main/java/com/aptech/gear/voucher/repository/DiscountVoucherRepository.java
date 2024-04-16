package com.aptech.gear.voucher.data;

import com.aptech.gear.voucher.domain.DiscountVoucher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DiscountVoucherRepository
        extends JpaRepository<DiscountVoucher, Long> {
}
