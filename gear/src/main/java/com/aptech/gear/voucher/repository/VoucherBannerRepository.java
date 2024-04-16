package com.aptech.gear.voucher.repository;

import com.aptech.gear.voucher.domain.VoucherBanner;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VoucherBannerRepository
        extends JpaRepository<VoucherBanner, Long> {
}
