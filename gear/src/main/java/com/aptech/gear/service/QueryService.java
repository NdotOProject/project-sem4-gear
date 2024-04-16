package com.aptech.gear.service;

import java.util.List;
import java.util.Optional;

public interface QueryService<E, ID> {
    List<E> findAll();

    Optional<E> findById(ID id);
}
