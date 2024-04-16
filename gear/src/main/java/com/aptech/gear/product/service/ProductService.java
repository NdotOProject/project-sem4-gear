package com.aptech.gear.product.service;

import com.aptech.gear.product.domain.Product;
import com.aptech.gear.product.repository.ProductRepository;
import com.aptech.gear.util.PaginatedList;
import com.aptech.gear.util.PaginationMetadata;
import com.aptech.gear.util.PaginationParameter;
import com.aptech.gear.util.PagingStorage;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Objects;
import java.util.Optional;

@Service
@AllArgsConstructor
public class ProductService {

	private static final int PAGE_SIZE = 10;

	private static final PagingStorage<Product> cachedProducts;

	static {
		cachedProducts = new PagingStorage<>(null,
				options -> options.expiredTime(0, 0, 1, 0)
						           .pageSize(PAGE_SIZE)
		);
	}

	private final ProductRepository repository;

	public boolean create(Product product) {
		if (Objects.isNull(product)) {
			throw new IllegalArgumentException();
		}

		Product savedProduct = repository.save(product);

		return cachedProducts.add(savedProduct);
	}

	public boolean update(Product oldInfo, Product newInfo) {
		assert (oldInfo != null) : "Old product info is null";
		assert (oldInfo.getId() != null)
				: "Cannot read product info because id is null";
		assert (newInfo != null) : "New product info is null";

		var example = Example.of(oldInfo);

		if (!repository.exists(example)) {
			throw new NullPointerException("Product does not exist.");
		}

		if (newInfo.getId() != null
				    && !newInfo.getId().equals(oldInfo.getId())) {
			throw new UnsupportedOperationException();
		}

		Optional<Product> queryResult = repository.findOne(example);

		if (queryResult.isPresent()) {
			Product product = queryResult.get();

			product.setName(newInfo.getName());
			product.setDescription(newInfo.getDescription());
			product.setPrice(newInfo.getPrice());
			product.setRating(newInfo.getRating());

			var saved = repository.save(product);

			if (cachedProducts.contains(p -> Objects.equals(p, oldInfo))) {
				return cachedProducts.update(oldInfo, saved);
			} else {
				return cachedProducts.add(saved);
			}
		}

		return false;
	}

	public boolean delete(long id) {
		var optional = getByKey(id);

		if (optional.isPresent()) {
			repository.deleteById(id);

			return cachedProducts.delete(optional.get());
		}

		return false;
	}

	public PaginatedList<Product> getList(PaginationParameter pageParam) {
		if (Objects.isNull(pageParam)) {
			throw new NullPointerException();
		}

		int pageNumber = pageParam.pageNumber();
		int size = pageParam.pageSize();

		if (!cachedProducts.isEmpty()
				    && cachedProducts.containsPage(pageNumber)) {

			if (size > PAGE_SIZE) {
				int countPages = (int) Math.ceil((double) size / PAGE_SIZE);
				final var result = new ArrayList<Product>();

				for (int i = 0; i < countPages; i++) {
					var page = cachedProducts.getPage(pageNumber + i);

					result.addAll(page.getItems());
				}

				return new PaginatedList<>(
						result.subList(0, size),
						PaginationMetadata.builder()
								.currentPage(pageNumber + countPages)
								.totalPages(cachedProducts.getTotalPages())
								.totalRecords(cachedProducts.getTotalRecords())
				);
			} else {
				var page = cachedProducts.getPage(pageNumber);

				return page.limit(size);
			}
		}

		final var page = repository.findAll(pageParam.getPageable());

		var result = new PaginatedList<>(page);

		cachedProducts.addAll(result.getItems());

		return result;
	}

	public Optional<Product> getByKey(long id) {
		var list = cachedProducts.where(p -> Objects.equals(p.getId(), id));

		if (list.isEmpty()) {
			var optional = repository.findById(id);

			optional.ifPresent(cachedProducts::add);

			return optional;
		}

		return Optional.of(list.get(0));
	}
}
