package com.aptech.gear.util;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.ANNOTATION_TYPE)
public @interface FieldTransformer {
    String name();

    Class<?> returnType() default Void.class;

    Class<?>[] paramTypes() default {};
    
    Class<?> provider() default Void.class;
}
