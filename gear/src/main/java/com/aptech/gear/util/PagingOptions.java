package com.aptech.gear.util;


import java.util.function.Consumer;

public final class PagingOptions {

	private static final PagingOptions DEFAULT = new PagingOptions();

	public static final int MIN_PAGE_SIZE = 1;

	public static final long DEFAULT_EXPIRED_TIME
			= timeCalculator(0, 0, 30, 0);

	/**
	 * number of elements per page.
	 */
	private int pageSize;

	private long expiredTime;

	public PagingOptions() {
		this.pageSize = MIN_PAGE_SIZE;
		this.expiredTime = DEFAULT_EXPIRED_TIME;
	}

	static PagingOptions makeSafety(PagingOptions options) {
		return options != null ? options : DEFAULT;
	}

	static PagingOptions build(Consumer<PagingOptions> builder) {
		final PagingOptions options = new PagingOptions();

		if (builder != null) {
			builder.accept(options);
		}

		return options;
	}

	public PagingOptions pageSize(int size) {
		this.pageSize = Math.max(size, MIN_PAGE_SIZE);
		return this;
	}

	int getPageSize() {
		return pageSize;
	}

	long getExpiredTime() {
		return expiredTime;
	}

	public PagingOptions expiredTime(
			int days, int hours, int minutes, int seconds) {
		assert days >= 0 : "";
		assert hours >= 0 : "";
		assert minutes >= 0 : "";
		assert seconds >= 0 : "";

		this.expiredTime = timeCalculator(days, hours, minutes, seconds);

		return this;
	}

	private static long timeCalculator(
			int days, int hours, int minutes, int seconds) {
		final int hourInDay = 24;
		final int minuteInHour = 60;
		final int secondInMinute = 60;
		final int millisecondInSecond = 1000;

		hours = hours + (days * hourInDay);
		minutes = minutes + (hours * minuteInHour);
		seconds = seconds + (minutes * secondInMinute);

		return (long) seconds * millisecondInSecond;
	}
}
