package com.boot.common.security.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Data
@Component
@ConfigurationProperties(prefix = "boot.sa-token")
public class SaTokenExcludeUrlConfig {

    private List<String> excludeUrlPath = new ArrayList<>();


}
