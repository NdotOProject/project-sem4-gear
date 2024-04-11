package com.aptech.gear.util;

import java.util.Objects;

final class PageItem<T> {

	private T data;
	private int pageNumber;
	private int indexInPage;
	private long storedTime;
	private final long age;

	public PageItem(T data, int pageNumber, int indexInPage, long age) {
		data(data);
		this.pageNumber = pageNumber;
		this.indexInPage = indexInPage;
		this.storedTime = System.currentTimeMillis();
		this.age = age;
	}

	public void data(T value) {
		data = Objects.requireNonNull(value);
	}

	public boolean belongsToPage(int page) {
		return Objects.equals(pageNumber, page);
	}

	public boolean hasData(T otherData) {
		return Objects.equals(data, otherData);
	}

	public int pageNumber() {
		return pageNumber;
	}

	public int indexInPage() {
		return indexInPage;
	}

	public static boolean isExpired(PageItem<?> item) {
		long now = System.currentTimeMillis();

		return (now - item.storedTime) > item.age;
	}

	PageItem<T> resetStoredTime() {
		storedTime = System.currentTimeMillis();
		return this;
	}

	public T get() {
		return data;
	}

	public void moveTo(int newPage, int newIndex) {
		this.pageNumber = newPage;
		this.indexInPage = newIndex;
		this.storedTime = System.currentTimeMillis();
	}

	@Override
	public String toString() {
		return data.toString();
	}

	@Override
	public boolean equals(Object o) {
		if (o == null) {
			return false;
		}

		if (this == o) {
			return true;
		}

		if (!(o instanceof PageItem<?> other)) {
			return false;
		}

		return Objects.equals(data, other.data);
	}

	@Override
	public int hashCode() {
		int result = data != null ? data.hashCode() : 0;
		result = 31 * result + pageNumber;
		result = 31 * result + indexInPage;
		result = 31 * result + (int) (storedTime ^ (storedTime >>> 32));
		return result;
	}
}
