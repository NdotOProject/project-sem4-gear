package com.aptech.gear.brand.api.request;

import com.aptech.gear.brand.domain.Brand;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class ModifyBrandRequest {
	private String name;
	private String description;

	public static class Mapper
			extends com.aptech.gear.util.Mapper<ModifyBrandRequest, Brand> {

		public Mapper() {
			super(ModifyBrandRequest.class, Brand::new);
		}

		@Override
		protected void handle(ModifyBrandRequest src, Brand dest) {
			dest.setName(src.getName());
			dest.setDescription(src.getDescription());
		}
	}
}
