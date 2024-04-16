package com.aptech.gear.util;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.std.StdSerializer;

import java.io.IOException;

public class PaginatedListSerializer
        extends StdSerializer<PaginatedList<?>> {

    public PaginatedListSerializer() {
        this(null);
    }

    public PaginatedListSerializer(Class<PaginatedList<?>> t) {
        super(t);
    }

    @Override
    public void serialize(
            PaginatedList<?> paginatedList,
            JsonGenerator jsonGenerator,
            SerializerProvider serializerProvider)
            throws IOException {

        jsonGenerator.writeObject(paginatedList.toJson());
    }
}
