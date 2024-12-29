package com.boot.easyswagger;

import com.boot.easyswagger.core.Swagger2Hook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.context.WebApplicationContext;
import springfox.documentation.spring.web.DocumentationCache;

@Configuration
public class EasySwaggerConfig {
    @Autowired
    private DocumentationCache documentationCache;
    @Autowired
    private WebApplicationContext applicationContext;


    @Bean
    public Swagger2Hook provideInit() {
        return new Swagger2Hook(documentationCache, applicationContext);
    }
}
