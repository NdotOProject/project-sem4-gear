package com.aptech.gear.dependency;

import com.aptech.gear.brand.api.request.ModifyBrandRequest;
import com.aptech.gear.brand.api.response.BrandInformation;
import com.aptech.gear.product.api.response.ProductInformation;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class Mapper {

	@Bean
	public BrandInformation.Mapper brandInformationMapper() {
		return new BrandInformation.Mapper();
	}

	@Bean
	public ModifyBrandRequest.Mapper modifyBrandMapper() {
		return new ModifyBrandRequest.Mapper();
	}

	@Bean
	public ProductInformation.Mapper productInformationMapper() {
		return new ProductInformation.Mapper();
	}
}
