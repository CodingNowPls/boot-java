package com.boot.common.tenant.config;

import lombok.Data;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import java.util.List;

/**
 * 多租户配置
 *
 * @author vishun
 */
@Data
@Configuration
@ConfigurationProperties(prefix = "tenant")
@ConditionalOnProperty(prefix = "tenant", name = "enable", havingValue = "true")
public class TenantProperties {

    /**
     * 是否开启多租户
     */
    private Boolean enable;

    /**
     * 租户字段名
     */
    private String column;

    /**
     * 需要忽略的租户表名
     */
    private List<String> excludes;

}

