package com.aptech.gear.exception;

public class InternalServerErrorException
        extends RuntimeException {
    public InternalServerErrorException() {
        super("");
    }

    public InternalServerErrorException(String msg) {
        super(msg);
    }
}
