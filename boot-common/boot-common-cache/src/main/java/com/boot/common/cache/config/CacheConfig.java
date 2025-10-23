package com.boot.common.cache.config;

import com.boot.common.core.enums.EnumCacheType;
import com.boot.common.cache.local.LocalBootCache;
import com.boot.common.cache.redis.RedisBootCache;
import com.boot.common.core.cache.BootCache;
import com.boot.common.core.utils.spring.SpringUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;

/**
 * 缓存配置
 * @author gao
 */
@Slf4j
@Configuration
public class CacheConfig {

    // 本地缓存 Bean
    @Bean
    @ConditionalOnProperty(name = "boot.cacheType", havingValue = EnumCacheType.CACHE_TYPE_LOCAL, matchIfMissing = true)
    public BootCache localCache() {
        log.info("使用本地缓存 LocalCache");
        return new LocalBootCache();
    }

    // Redis 缓存 Bean
    @Bean
    @ConditionalOnProperty(name = "boot.cacheType", havingValue = EnumCacheType.CACHE_TYPE_REDIS)
    public BootCache redisCache() {
        log.info("使用redis缓存");
        RedisTemplate redisTemplate = SpringUtils.getBean(RedisTemplate.class);
        return new RedisBootCache(redisTemplate);
    }
}
