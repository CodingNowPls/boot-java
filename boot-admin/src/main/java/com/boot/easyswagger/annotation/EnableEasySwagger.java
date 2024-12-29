package com.boot.easyswagger.annotation;

import com.boot.easyswagger.EasySwaggerConfig;
import org.springframework.context.annotation.Import;

import java.lang.annotation.*;

@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE})
@Import({EasySwaggerConfig.class})
@Documented
public @interface EnableEasySwagger {
}
