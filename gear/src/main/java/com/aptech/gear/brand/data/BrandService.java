package com.aptech.gear.brand.data;

import com.aptech.gear.brand.domain.Brand;
import com.aptech.gear.util.PaginatedList;
import com.aptech.gear.util.PaginationMetadata;
import com.aptech.gear.util.PaginationParameter;
import com.aptech.gear.util.PagingStorage;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
@AllArgsConstructor
public class BrandService {

	private static final int PAGE_SIZE = 10;

	private static final PagingStorage<Brand> cachedBrands;

	static {
		cachedBrands = new PagingStorage<>(null,
				options -> options.pageSize(PAGE_SIZE)
						           .expiredTime(0, 0, 1, 0)
		);
	}

	private final BrandRepository repository;

	public boolean create(String name, String description) {
		if (Objects.isNull(name)) {
			throw new NullPointerException();
		}

		var brand = new Brand();
		brand.setName(name);
		brand.setDescription(description);

		var savedBrand = repository.save(brand);

		return cachedBrands.add(savedBrand);
	}

	public boolean update(Brand oldInfo, Brand newInfo) {
		assert (oldInfo != null) : "Old brand info is null";
		assert (oldInfo.getId() != null)
				: "Cannot read brand info because id is null";
		assert (newInfo != null) : "New brand info is null";

		var example = Example.of(oldInfo);

		if (!repository.exists(example)) {
			throw new NullPointerException("Brand does not exist.");
		}

		if (newInfo.getId() != null
				    && !newInfo.getId().equals(oldInfo.getId())) {
			throw new UnsupportedOperationException();
		}

		Optional<Brand> queryResult = repository.findOne(example);

		if (queryResult.isPresent()) {
			Brand existsBrand = queryResult.get();

			existsBrand.setName(newInfo.getName());
			existsBrand.setDescription(newInfo.getDescription());

			var savedBrand = repository.save(existsBrand);

			if (cachedBrands.contains(brand -> Objects.equals(brand, oldInfo))) {
				return cachedBrands.update(oldInfo, savedBrand);
			} else {
				return cachedBrands.add(savedBrand);
			}
		}

		return false;
	}

	public boolean delete(long id) {
		Optional<Brand> optional = getByKey(id);

		if (optional.isPresent()) {
			repository.deleteById(id);
			return cachedBrands.delete(optional.get());
		}

		return false;
	}

	public PaginatedList<Brand> getList(PaginationParameter pageParam) {
		if (pageParam == null) {
			throw new NullPointerException();
		}

		int pageNumber = pageParam.pageNumber();
		int size = pageParam.pageSize();

		// read from cache
		if (!cachedBrands.isEmpty()
				    && cachedBrands.containsPage(pageNumber)) {
			if (size > PAGE_SIZE) {
				final List<Brand> brands = new ArrayList<>();
				int countPages = (int) Math.ceil((double) size / PAGE_SIZE);
				for (int i = 0; i < countPages; i++) {
					var page = cachedBrands.getPage(pageNumber + i);

					brands.addAll(page.getItems());
				}

				return new PaginatedList<>(
						brands.subList(0, size),
						PaginationMetadata.builder()
								.currentPage(pageNumber + countPages)
								.totalRecords(cachedBrands.getTotalRecords())
								.totalPages(cachedBrands.getTotalPages())
				);
			} else {
				var page = cachedBrands.getPage(pageNumber);

				return page.limit(size);
			}
		}

		// call new
		final Page<Brand> page = repository.findAll(pageParam.getPageable());

		var result = new PaginatedList<>(page);

		cachedBrands.addAll(result.getItems());

		return result;
	}

	public Optional<Brand> getByKey(long id) {

		var list = cachedBrands.where(
				brand -> Objects.equals(brand.getId(), id));

		if (list.isEmpty()) {
			Optional<Brand> optional = repository.findById(id);

			optional.ifPresent(cachedBrands::add);

			return optional;
		}

		return Optional.of(list.get(0));
	}
}
