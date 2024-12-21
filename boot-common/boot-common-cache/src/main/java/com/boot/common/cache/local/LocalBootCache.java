package com.boot.common.cache.local;

import com.boot.common.core.cache.BootCache;
import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;

import java.util.*;
import java.util.concurrent.TimeUnit;


/**
 * @author gao
 */
public class LocalBootCache implements BootCache {

    private final Cache<String, Object> cache;

    public LocalBootCache() {
        // 初始化 Caffeine 缓存
        this.cache = Caffeine.newBuilder()
                // 默认缓存过期时间
                .expireAfterWrite(60, TimeUnit.MINUTES)
                // 最大缓存数量
                .maximumSize(1000)
                .build();
    }

    @Override
    public <T> void setCacheObject(String key, T value) {
        cache.put(key, value);
    }

    /**
     *  若需要动态设置过期时间，可考虑扩展 Caffeine 或管理多个缓存实例
     *    Caffeine 会根据默认策略清理缓存
     * @param key      缓存的键值
     * @param value    缓存的值
     * @param timeout  时间
     * @param timeUnit 时间颗粒度
     * @param <T>
     */
    @Override
    public <T> void setCacheObject(String key, T value, Integer timeout, TimeUnit timeUnit) {
        cache.put(key, value);
    }

    /**
     *   Caffeine 不直接支持动态设置单个键的过期时间
     * @param key     Redis键
     * @param timeout 超时时间
     * @return
     */
    @Override
    public boolean expire(String key, long timeout) {
        return true;
    }

    /**
     *   Caffeine 不直接支持动态设置单个键的过期时间
     * @param key     Redis键
     * @param timeout 超时时间
     * @param unit
     * @return
     */
    @Override
    public boolean expire(String key, long timeout, TimeUnit unit) {
        return true;
    }

    /**
     *   Caffeine 不支持获取单个键的剩余过期时间
     * @param key Redis键
     * @return
     */
    @Override
    public long getExpire(String key) {
        return -1;
    }

    @Override
    public Boolean hasKey(String key) {
        return cache.asMap().containsKey(key);
    }

    @Override
    public <T> T getCacheObject(String key) {
        return (T) cache.getIfPresent(key);
    }

    @Override
    public boolean deleteObject(String key) {
        cache.invalidate(key);
        return true;
    }

    @Override
    public boolean deleteObject(Collection collection) {
        cache.invalidateAll(collection);
        return true;
    }

    @Override
    public <T> long setCacheList(String key, List<T> dataList) {
        cache.put(key, dataList);
        return dataList.size();
    }

    @Override
    public <T> List<T> getCacheList(String key) {
        return (List<T>) cache.getIfPresent(key);
    }

    @Override
    public <T> Set<T> getCacheSet(String key) {
        return (Set<T>) cache.getIfPresent(key);
    }

    @Override
    public <T> void setCacheMap(String key, Map<String, T> dataMap) {
        cache.put(key, dataMap);
    }

    @Override
    public <T> Map<String, T> getCacheMap(String key) {
        return (Map<String, T>) cache.getIfPresent(key);
    }

    @Override
    public <T> void setCacheMapValue(String key, String hKey, T value) {
        Map<String, T> map = (Map<String, T>) cache.getIfPresent(key);
        if (map == null) {
            map = new HashMap<>();
        }
        map.put(hKey, value);
        cache.put(key, map);
    }

    @Override
    public <T> T getCacheMapValue(String key, String hKey) {
        Map<String, T> map = (Map<String, T>) cache.getIfPresent(key);
        return map != null ? map.get(hKey) : null;
    }

    @Override
    public <T> List<T> getMultiCacheMapValue(String key, Collection<Object> hKeys) {
        Map<String, T> map = (Map<String, T>) cache.getIfPresent(key);
        if (map == null) {
            return Collections.emptyList();
        }
        List<T> values = new ArrayList<>();
        for (Object hKey : hKeys) {
            values.add(map.get(hKey));
        }
        return values;
    }

    @Override
    public boolean deleteCacheMapValue(String key, String hKey) {
        Map<String, Object> map = (Map<String, Object>) cache.getIfPresent(key);
        if (map != null) {
            map.remove(hKey);
            cache.put(key, map);
            return true;
        }
        return false;
    }

    /**
     *   Caffeine 不支持模式匹配，仅返回所有键
     * @param pattern 字符串前缀
     * @return
     */
    @Override
    public Collection<String> keys(String pattern) {
        return cache.asMap().keySet();
    }
}
