package com.aptech.gear.service;

public interface RemovalService<T, ID> {

    Boolean delete(T entity);

    Boolean deleteById(ID id);
}