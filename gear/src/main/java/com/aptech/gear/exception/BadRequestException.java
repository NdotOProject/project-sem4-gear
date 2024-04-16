package com.aptech.gear.exception;

public class BadRequestException
        extends RuntimeException {

    public BadRequestException() {
        super("");
    }

    public BadRequestException(String msg) {
        super(msg);
    }
}
