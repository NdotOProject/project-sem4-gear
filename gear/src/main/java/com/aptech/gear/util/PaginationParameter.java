package com.aptech.gear.util;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

public record PaginationParameter(int pageNumber, int pageSize) {

	public PaginationParameter {
		if (pageNumber < 1) {
			throw new IllegalArgumentException();
		}

		if (pageSize < 1) {
			throw new IllegalArgumentException();
		}
	}

	public Pageable getPageable() {
		return PageRequest.of(pageNumber - 1, pageSize);
	}
}
