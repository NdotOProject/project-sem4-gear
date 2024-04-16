package com.aptech.gear.brand.api.response;

import com.aptech.gear.brand.domain.Brand;
import com.aptech.gear.util.Mapper;

import java.util.function.Supplier;

public class BrandInfoMapper
        extends Mapper<Brand, BrandInformation> {
    protected BrandInfoMapper() {
        super(Brand.class, BrandInformation::new);
    }
}
