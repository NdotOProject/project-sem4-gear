package com.aptech.gear.service;

public interface CrudService<E, ID>
        extends QueryService<E, ID>, SaveChangesService<E>, RemovalService<E, ID> {
}