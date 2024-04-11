package com.aptech.gear.util;

import lombok.Getter;
import org.springframework.data.domain.Page;

import java.util.Objects;

public class PaginationMetadata {
	private static final int PAGE_NUMBER_START_AT = 1;

	@Getter
	private long totalRecords;
	@Getter
	private int totalPages;
	private int currentPage;

	private PaginationMetadata(Page<?> page) {
		if (Objects.isNull(page)) {
			totalRecords = 0L;
			totalPages = PAGE_NUMBER_START_AT;
			currentPage = PAGE_NUMBER_START_AT;
		} else {
			totalRecords = page.getTotalElements();
			totalPages = page.getTotalPages();
			// page.getNumber() start at 0.
			currentPage = page.getNumber() + PAGE_NUMBER_START_AT;
		}
	}

	public int getPageNumber() {
		return currentPage;
	}

	public Integer nextPage() {
		int nextPage = currentPage + 1;
		return nextPage <= totalPages ? nextPage : null;
	}

	public Integer previousPage() {
		int prevPage = currentPage - 1;
		return prevPage >= PAGE_NUMBER_START_AT ? prevPage : null;
	}

	public static Builder builder() {
		return new Builder(null);
	}

	static Builder builder(Page<?> page) {
		return new Builder(page);
	}

	public static class Builder {

		private final PaginationMetadata metadata;

		private Builder(Page<?> page) {
			this.metadata = new PaginationMetadata(page);
		}

		public Builder totalRecords(long value) {
			assert value >= 0
					: "totalRecords cannot be negative";

			metadata.totalRecords = value;
			return this;
		}

		public Builder totalPages(int value) {
			assert value >= PAGE_NUMBER_START_AT
					: "totalPages cannot be less than " + PAGE_NUMBER_START_AT;

			metadata.totalPages = value;
			return this;
		}

		public Builder currentPage(int pageNumber) {
			// if (pageNumber >= totalPages) => totalPages
			// else => pageNumber
			pageNumber = Math.min(pageNumber, metadata.totalPages);
			// if (pageNumber <= PAGE_NUMBER_START_AT) => PAGE_NUMBER_START_AT
			// else => pageNumber
			metadata.currentPage = Math.max(pageNumber, PAGE_NUMBER_START_AT);

			return this;
		}

		public PaginationMetadata build() {
			return metadata;
		}
	}
}