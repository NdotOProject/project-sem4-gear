package com.aptech.gear.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.function.Consumer;
import java.util.function.Predicate;
import java.util.stream.Collectors;

public class PagingStorage<T> {

	private static final int FIRST_INDEX = 1;

	private static final int FIRST_PAGE = 1;

	private int lastPage;

	private final PagingOptions options;

	private final List<PageItem<T>> items;

	public PagingStorage(
			List<T> initData,
			Consumer<PagingOptions> optionsBuilder) {
		this(initData, PagingOptions.build(optionsBuilder));
	}

	public PagingStorage(List<T> initData, PagingOptions options) {

		items = new LinkedList<>();
		this.options = PagingOptions.makeSafety(options);
		lastPage = FIRST_PAGE;

		if (Objects.nonNull(initData) && !initData.isEmpty()) {
			initData.forEach(this::add);
		}
	}

	public int getTotalPages() {
		return lastPage;
	}

	public int getTotalRecords() {
		return items.size();
	}

	public void clean() {
		List.copyOf(items).stream().parallel()
				.filter(PageItem::isExpired)
				.forEach(items::remove);
	}

	public boolean isEmpty() {
		return items.isEmpty();
	}

	public boolean containsPage(int pageNumber) {
		return lastPage >= pageNumber && pageNumber >= FIRST_PAGE;
	}

	public boolean contains(Predicate<T> predicate) {
		return items.stream().parallel().anyMatch(i -> predicate.test(i.get()));
	}

	public List<T> where(Predicate<T> predicate) {
		return items.stream().parallel()
				       .filter(i -> predicate.test(i.get()))
				       .map(PageItem::get)
				       .collect(Collectors.toList());
	}

	public PaginatedList<T> getRange(int offset, int limit) {
		assert offset > 0 : "offset cannot less than 1";
		assert limit > 0 : "limit cannot less thn 1";

		int pageNumber = (int) Math.ceil(
				(double) offset / options.getPageSize()
		);

		final List<PageItem<T>> result = new ArrayList<>();

		while (result.size() < limit) {
			final List<PageItem<T>> pageItems = getPageItems(pageNumber);

			if (limit >= pageItems.size()) {
				result.addAll(pageItems);
				pageNumber++;
			} else {
				int missing = limit - result.size();

				result.addAll(pageItems.subList(0, missing));
			}
		}

		return toPaginatedList(result, pageNumber);
	}

	public PaginatedList<T> getPage(int pageNumber) {
		return toPaginatedList(
				getPageItems(pageNumber), pageNumber
		);
	}

	public Map<Integer, PaginatedList<T>> getPages(int... pageNumbers) {
		final Map<Integer, PaginatedList<T>> result = new HashMap<>();

		for (int page : pageNumbers) {
			result.put(page, getPage(page));
		}

		return result;
	}

	public PaginatedList<T> getFirstPage() {
		return getPage(FIRST_PAGE);
	}

	public PaginatedList<T> getLastPage() {
		return getPage(lastPage);
	}

	public void addAll(Collection<T> c) {
		c.stream().parallel()
				.forEach(this::add);
	}

	public boolean add(T value) {
		clean();

		// validate input
		requireNonNullParameter(value, "value");
		if (contains(t -> Objects.equals(t, value))) {
			throw new UnsupportedOperationException("value has been stored.");
		}

		final List<PageItem<T>> lastPageItems = getPageItems(lastPage);

		int index;
		if (!lastPageItems.isEmpty()) {
			final PageItem<T> lastItem = lastPageItems.get(
					lastPageItems.size() - 1);

			if (lastPageItems.size() >= options.getPageSize()) {
				lastPage++;
				index = FIRST_INDEX;
			} else {
				index = lastItem.indexInPage() + 1;
			}
		} else {
			index = FIRST_INDEX;
		}

		final PageItem<T> newItem = new PageItem<>(
				value, lastPage, index,
				options.getExpiredTime()
		);

		return items.add(newItem);
	}

	public boolean delete(T value) {
		clean();

		// validate input
		requireNonNullParameter(value, "value");

		final Optional<PageItem<T>> optional
				= items.stream().parallel()
						  .filter(i -> i.hasData(value))
						  .findFirst();

		if (optional.isEmpty()) {
			throw new UnsupportedOperationException(
					"value has not been stored."
			);
		}

		return items.remove(optional.get());
	}

	public boolean update(T oldValue, T newValue) {
		clean();

		// validate input
		requireNonNullParameter(oldValue, "oldValue");
		requireNonNullParameter(newValue, "newValue");

		final Optional<PageItem<T>> optional
				= items.stream().parallel()
						  .filter(i -> i.hasData(oldValue))
						  .findFirst();

		if (optional.isEmpty()) {
			throw new UnsupportedOperationException(
					"oldValue has not been stored."
			);
		}

		final PageItem<T> item = optional.get();

		item.data(newValue);

		return contains(data -> Objects.equals(data, newValue));
	}

	private List<PageItem<T>> getPageItems(int page) {
		if (page >= FIRST_PAGE && page <= lastPage) {
			final List<PageItem<T>> result
					= items.stream().parallel()
							  .filter(i -> i.belongsToPage(page))
							  .limit(options.getPageSize())
							  .sorted(Comparator.comparing(PageItem::indexInPage))
							  .collect(Collectors.toList());

			if (result.isEmpty()) {
				return result;
			}

			if (page != lastPage &&
					    (result.size() < options.getPageSize())) {
				PageItem<T> lastItemInResult = result.get(result.size() - 1);

				int index = items.indexOf(lastItemInResult);

				while (result.size() < options.getPageSize()) {
					index++;
					PageItem<T> item = items.get(index);
					item.moveTo(
							page,
							lastItemInResult.indexInPage() + 1
					);
					lastItemInResult = item;
					result.add(item);
				}
			}

			return result;
		}

		return new ArrayList<>();
	}

	private PaginatedList<T> toPaginatedList(List<PageItem<T>> records, int page) {
		final List<T> items = new ArrayList<>();

		Objects.requireNonNull(records).stream().parallel()
				.forEach(r -> items.add(r.resetStoredTime().get()));

		return new PaginatedList<>(
				items,
				PaginationMetadata.builder().currentPage(page)
						.totalPages(getTotalPages())
						.totalRecords(getTotalRecords())
		);
	}

	private void requireNonNullParameter(Object param, String paramName) {
		if (Objects.isNull(param)) {
			throw new IllegalArgumentException(
					paramName + " cannot be null.");
		}
	}

	@Override
	public String toString() {
		final StringBuilder sb = new StringBuilder();

		sb.append(getClass().getSimpleName().concat(" { "));

		for (int page = 1; page <= lastPage; page++) {
			List<PageItem<T>> list = getPageItems(page);

			sb.append(page).append(":").append(list);

			if (page < lastPage) {
				sb.append(", ");
			}
		}

		sb.append(" }");

		return sb.toString();
	}
}
