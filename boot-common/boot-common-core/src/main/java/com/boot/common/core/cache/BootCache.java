package com.boot.common.core.cache;

import java.util.*;
import java.util.concurrent.TimeUnit;

/**
 * @author : gao
 * @date 2024年12月18日
 * -------------------------------------------<br>
 * <br>
 * <br>
 */
public interface BootCache {

    /**
     * 缓存基本的对象，Integer、String、实体类等
     *
     * @param key   缓存的键值
     * @param value 缓存的值
     */
    <T> void setCacheObject(String key, T value);

    /**
     * 缓存基本的对象，Integer、String、实体类等
     *
     * @param key      缓存的键值
     * @param value    缓存的值
     * @param timeout  时间
     * @param timeUnit 时间颗粒度
     */
    <T> void setCacheObject(String key, T value, Integer timeout, TimeUnit timeUnit);

    /**
     * 设置有效时间
     *
     * @param key     Redis键
     * @param timeout 超时时间
     * @return true=设置成功；false=设置失败
     */
    boolean expire(String key, long timeout);

    /**
     * 设置有效时间
     *
     * @param key     Redis键
     * @param timeout 超时时间
     * @param unit    时间单位
     * @return true=设置成功；false=设置失败
     */
    boolean expire(String key, long timeout, TimeUnit unit);

    /**
     * 获取有效时间
     *
     * @param key Redis键
     * @return 有效时间
     */
    long getExpire(String key);

    /**
     * 判断 key是否存在
     *
     * @param key 键
     * @return true 存在 false不存在
     */
    Boolean hasKey(String key);

    /**
     * 获得缓存的基本对象。
     *
     * @param key 缓存键值
     * @return 缓存键值对应的数据
     */
    <T> T getCacheObject(String key);

    /**
     * 删除单个对象
     *
     * @param key
     */
    boolean deleteObject(String key);

    /**
     * 删除集合对象
     *
     * @param collection 多个对象
     * @return
     */
    boolean deleteObject(Collection collection);

    /**
     * 缓存List数据
     *
     * @param key      缓存的键值
     * @param dataList 待缓存的List数据
     * @return 缓存的对象
     */
    <T> long setCacheList(String key, List<T> dataList);

    /**
     * 获得缓存的list对象
     *
     * @param key 缓存的键值
     * @return 缓存键值对应的数据
     */
    <T> List<T> getCacheList(String key);


    /**
     * 获得缓存的set
     *
     * @param key
     * @return
     */
    <T> Set<T> getCacheSet(String key);

    /**
     * 缓存Map
     *
     * @param key
     * @param dataMap
     */
    <T> void setCacheMap(String key, Map<String, T> dataMap);

    /**
     * 获得缓存的Map
     *
     * @param key
     * @return
     */
    <T> Map<String, T> getCacheMap(String key);

    /**
     * 往Hash中存入数据
     *
     * @param key   Redis键
     * @param hKey  Hash键
     * @param value 值
     */
    <T> void setCacheMapValue(String key, String hKey, T value);

    /**
     * 获取Hash中的数据
     *
     * @param key  Redis键
     * @param hKey Hash键
     * @return Hash中的对象
     */
    <T> T getCacheMapValue(String key, String hKey);

    /**
     * 获取多个Hash中的数据
     *
     * @param key   Redis键
     * @param hKeys Hash键集合
     * @return Hash对象集合
     */
    <T> List<T> getMultiCacheMapValue(String key, Collection<Object> hKeys);

    /**
     * 删除Hash中的某条数据
     *
     * @param key  Redis键
     * @param hKey Hash键
     * @return 是否成功
     */
    boolean deleteCacheMapValue(String key, String hKey);

    /**
     * 获得缓存的基本对象列表
     *
     * @param pattern 字符串前缀
     * @return 对象列表
     */
    Collection<String> keys(String pattern);

}
