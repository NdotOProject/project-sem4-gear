package com.aptech.gear.service.impl;

import com.aptech.gear.exception.BadRequestException;
import com.aptech.gear.exception.NotFoundException;
import com.aptech.gear.service.QueryService;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

public class QueryServiceImpl<E, ID>
        implements QueryService<E, ID> {

    private final JpaRepository<E, ID> repository;

    public QueryServiceImpl(JpaRepository<E, ID> repository) {
        this.repository = repository;
    }

    @Override
    public List<E> findAll() {
        return repository.findAll();
    }

    @Override
    public Optional<E> findById(ID id) {

        if (Objects.isNull(id)) {
            throw new BadRequestException();
        }

        final Optional<E> queryResult = repository.findById(id);
        if (queryResult.isEmpty()) {
            throw new NotFoundException();
        }

        return queryResult;
    }
}
