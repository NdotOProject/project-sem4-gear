package com.aptech.gear.brand.api;

import com.aptech.gear.brand.api.request.ModifyBrandRequest;
import com.aptech.gear.brand.api.response.BrandInformation;
import com.aptech.gear.brand.data.BrandService;
import com.aptech.gear.brand.domain.Brand;
import com.aptech.gear.util.PaginatedList;
import com.aptech.gear.util.PaginationParameter;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.net.URI;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

@RestController
@AllArgsConstructor
public class BrandRestController {

	private static final String ENDPOINT_CREATE = "/v1/brands";
	private static final String ENDPOINT_GET_LIST = "/v1/brands";
	private static final String ENDPOINT_GET_ONE = "/v1/brands/{id}";
	private static final String ENDPOINT_UPDATE = "/v1/brands/{id}";
	private static final String ENDPOINT_DELETE = "/v1/brands/{id}";

	private final BrandService service;
	private final BrandInformation.Mapper brandInformationMapper;
	private final ModifyBrandRequest.Mapper modifyBrandmapper;

	@PostMapping(ENDPOINT_CREATE)
	public ResponseEntity<Object> create(
			@RequestBody ModifyBrandRequest request) {
		if (Objects.isNull(request)) {
			return ResponseEntity.badRequest().build();
		}

		boolean result = service.create(
				request.getName(), request.getDescription());

		if (result) {
			return ResponseEntity.created(URI.create(ENDPOINT_CREATE)).build();
		}

		return ResponseEntity.badRequest().build();
	}

	@GetMapping(ENDPOINT_GET_LIST)
	public ResponseEntity<Map<String, Object>> getAll(
			@RequestParam(defaultValue = "1") Integer page,
			@RequestParam(defaultValue = "10") Integer size) {

		PaginatedList<Brand> brands = service.getList(
				new PaginationParameter(page, size));

		return ResponseEntity.ok(
				brands.map(brandInformationMapper::map).toJson()
		);
	}

	@GetMapping(ENDPOINT_GET_ONE)
	public ResponseEntity<BrandInformation> getOne(
			@PathVariable("id") long id) {

		final Optional<Brand> optional = service.getByKey(id);

		return optional.map(brand -> ResponseEntity.ok(brandInformationMapper.map(brand)))
				       .orElseGet(() -> ResponseEntity.notFound().build());
	}

	@PutMapping(ENDPOINT_UPDATE)
	public ResponseEntity<Object> update(
			@PathVariable("id") long id,
			@RequestBody ModifyBrandRequest request) {

		Optional<Brand> oldInfo = service.getByKey(id);

		if (oldInfo.isEmpty()) {
			return ResponseEntity.badRequest().build();
		}

		boolean result = service.update(
				oldInfo.get(), modifyBrandmapper.map(request));

		return (result
				        ? ResponseEntity.noContent()
				        : ResponseEntity.badRequest()
		).build();
	}

	@DeleteMapping(ENDPOINT_DELETE)
	public ResponseEntity<Object> delete(
			@PathVariable long id) {
		boolean result = service.delete(id);

		return (result
				        ? ResponseEntity.noContent()
				        : ResponseEntity.badRequest()
		).build();
	}
}
