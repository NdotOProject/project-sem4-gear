package com.aptech.gear.exception;

public class NotFoundException
        extends RuntimeException {

    public NotFoundException() {
        this("Record does not exist.");
    }

    public NotFoundException(String msg) {
        super(msg);
    }
}
