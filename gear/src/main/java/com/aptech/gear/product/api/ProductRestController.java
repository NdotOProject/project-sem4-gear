package com.aptech.gear.product.api;

import com.aptech.gear.product.api.request.CreateProductRequest;
import com.aptech.gear.product.api.response.ProductInformation;
import com.aptech.gear.product.service.ProductService;
import com.aptech.gear.product.domain.Product;
import com.aptech.gear.util.PaginatedList;
import com.aptech.gear.util.PaginationParameter;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@AllArgsConstructor
public class ProductRestController {

	private static final String ENDPOINT_GET_LIST = "/v1/products";
	private static final String ENDPOINT_GET_ONE = "/v1/products/{id}";
	private static final String ENDPOINT_CREATE = "/v1/products";

	private final ProductService service;
	private final ProductInformation.Mapper mapper;

	@GetMapping(ENDPOINT_GET_LIST)
	public ResponseEntity<PaginatedList<ProductInformation>> getAll(
			@RequestParam(defaultValue = "1") Integer page,
			@RequestParam(defaultValue = "10") Integer size) {

		PaginatedList<Product> products = service.getList(
				new PaginationParameter(page, size)
		);

		return ResponseEntity.ok(
				products.map(mapper::map)
		);
	}

	@GetMapping(ENDPOINT_GET_ONE)
	public ResponseEntity<ProductInformation> getOne(
			@PathVariable("id") long id) {
		Optional<Product> optional = service.getByKey(id);

		return optional.map(p -> ResponseEntity.ok(mapper.map(p)))
				       .orElseGet(() -> ResponseEntity.notFound().build());
	}

	@PostMapping(ENDPOINT_CREATE)
	public void create(
			@RequestBody CreateProductRequest request) {

		System.out.println(request);

	}
}
