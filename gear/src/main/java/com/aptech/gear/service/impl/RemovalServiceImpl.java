package com.aptech.gear.service.impl;

import com.aptech.gear.exception.BadRequestException;
import com.aptech.gear.exception.InternalServerErrorException;
import com.aptech.gear.service.RemovalService;
import org.springframework.dao.OptimisticLockingFailureException;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Objects;

public class RemovalServiceImpl<E, ID>
        implements RemovalService<E, ID> {

    private final JpaRepository<E, ID> repository;

    public RemovalServiceImpl(JpaRepository<E, ID> repository) {
        this.repository = repository;
    }

    @Override
    public Boolean delete(E entity) {

        if (Objects.isNull(entity)) {
            throw new BadRequestException();
        }

        try {
            repository.delete(entity);
            return true;
        } catch (OptimisticLockingFailureException e) {
            throw new InternalServerErrorException();
        }
    }

    @Override
    public Boolean deleteById(ID id) {

        if (Objects.isNull(id)) {
            throw new BadRequestException();
        }

        try {
            repository.deleteById(id);
            return true;
        } catch (OptimisticLockingFailureException e) {
            throw new InternalServerErrorException();
        }
    }
}
