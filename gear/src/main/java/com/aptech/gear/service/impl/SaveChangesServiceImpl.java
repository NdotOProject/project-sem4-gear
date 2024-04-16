package com.aptech.gear.service.impl;

import com.aptech.gear.exception.BadRequestException;
import com.aptech.gear.exception.InternalServerErrorException;
import com.aptech.gear.service.SaveChangesService;
import org.springframework.dao.OptimisticLockingFailureException;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Objects;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SaveChangesServiceImpl<E, ID> implements SaveChangesService<E> {

    private final JpaRepository<E, ID> repository;

    public SaveChangesServiceImpl(JpaRepository<E, ID> repository) {
        this.repository = repository;
    }

    @Override
    public Optional<E> save(E entity) {

        if (Objects.isNull(entity)) {
            throw new BadRequestException();
        }

        try {
            return Optional.of(repository.save(entity));
        } catch (OptimisticLockingFailureException e) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, null, e);
            throw new InternalServerErrorException();
        }
    }
}
