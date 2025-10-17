package com.boot.common.core.utils.json;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.CollectionType;
import com.fasterxml.jackson.databind.type.MapType;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

/**
 * 基于Jackson的JSON工具类
 */
public class BootJsonUtil {

    private static final ObjectMapper objectMapper = new ObjectMapper();

    static {
        // 注册Java 8时间模块，处理LocalDateTime等类型
        JavaTimeModule javaTimeModule = new JavaTimeModule();
        javaTimeModule.addSerializer(LocalDateTime.class, new LocalDateTimeSerializer(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        javaTimeModule.addDeserializer(LocalDateTime.class, new LocalDateTimeDeserializer(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        objectMapper.registerModule(javaTimeModule);

        // 禁用遇到未知属性时抛出异常
        objectMapper.configure(com.fasterxml.jackson.databind.DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    }

    private BootJsonUtil() {
        // 工具类，私有构造函数
    }

    /**
     * 对象转JSON字符串
     *
     * @param obj 待转换的对象
     * @return JSON字符串
     */
    public static String toJson(Object obj) {
        if (obj == null) {
            return null;
        }
        try {
            return objectMapper.writeValueAsString(obj);
        } catch (JsonProcessingException e) {
            throw new RuntimeException("JSON序列化失败", e);
        }
    }

    /**
     * JSON字符串转对象
     *
     * @param json  JSON字符串
     * @param clazz 目标类型Class
     * @param <T>   目标类型
     * @return 转换后的对象
     */
    public static <T> T fromJson(String json, Class<T> clazz) {
        if (json == null || json.trim().isEmpty()) {
            return null;
        }
        try {
            return objectMapper.readValue(json, clazz);
        } catch (JsonProcessingException e) {
            throw new RuntimeException("JSON反序列化失败", e);
        }
    }

    /**
     * JSON字符串转List
     *
     * @param json  JSON字符串
     * @param clazz List中元素的类型
     * @param <T>   List中元素的类型
     * @return 转换后的List
     */
    public static <T> List<T> fromJsonAsList(String json, Class<T> clazz) {
        if (json == null || json.trim().isEmpty()) {
            return null;
        }
        try {
            CollectionType collectionType = objectMapper.getTypeFactory().constructCollectionType(List.class, clazz);
            return objectMapper.readValue(json, collectionType);
        } catch (JsonProcessingException e) {
            throw new RuntimeException("JSON反序列化失败", e);
        }
    }

    /**
     * JSON字符串转Map
     *
     * @param json JSON字符串
     * @return 转换后的Map
     */
    public static Map<String, Object> fromJsonAsMap(String json) {
        if (json == null || json.trim().isEmpty()) {
            return null;
        }
        try {
            MapType mapType = objectMapper.getTypeFactory().constructMapType(Map.class, String.class, Object.class);
            return objectMapper.readValue(json, mapType);
        } catch (JsonProcessingException e) {
            throw new RuntimeException("JSON反序列化失败", e);
        }
    }

    /**
     * JSON字符串转Map（指定value类型）
     *
     * @param json      JSON字符串
     * @param keyType   key的类型
     * @param valueType value的类型
     * @param <K>       key类型
     * @param <V>       value类型
     * @return 转换后的Map
     */
    public static <K, V> Map<K, V> fromJsonAsMap(String json, Class<K> keyType, Class<V> valueType) {
        if (json == null || json.trim().isEmpty()) {
            return null;
        }
        try {
            MapType mapType = objectMapper.getTypeFactory().constructMapType(Map.class, keyType, valueType);
            return objectMapper.readValue(json, mapType);
        } catch (JsonProcessingException e) {
            throw new RuntimeException("JSON反序列化失败", e);
        }
    }

    /**
     * JSON字符串转复杂类型（如嵌套泛型）
     *
     * @param json          JSON字符串
     * @param typeReference 类型引用
     * @param <T>           目标类型
     * @return 转换后的对象
     */
    public static <T> T fromJson(String json, TypeReference<T> typeReference) {
        if (json == null || json.trim().isEmpty()) {
            return null;
        }
        try {
            return objectMapper.readValue(json, typeReference);
        } catch (JsonProcessingException e) {
            throw new RuntimeException("JSON反序列化失败", e);
        }
    }

    /**
     * 验证JSON字符串格式是否正确
     *
     * @param json 待验证的JSON字符串
     * @return true: 格式正确, false: 格式错误
     */
    public static boolean isValidJson(String json) {
        if (json == null || json.trim().isEmpty()) {
            return false;
        }
        try {
            objectMapper.readTree(json);
            return true;
        } catch (JsonProcessingException e) {
            return false;
        }
    }

    /**
     * 从JSON字符串中获取指定路径的值
     *
     * @param json JSON字符串
     * @param path 路径，如 "user.name"
     * @return 指定路径的值
     */
    public static Object getValueByPath(String json, String path) {
        if (json == null || json.trim().isEmpty() || path == null) {
            return null;
        }
        try {
            Object obj = objectMapper.readValue(json, Object.class);
            String[] paths = path.split("\\.");
            Object current = obj;

            for (String p : paths) {
                if (current instanceof Map) {
                    current = ((Map<?, ?>) current).get(p);
                } else {
                    return null; // 路径不存在或类型不匹配
                }
                if (current == null) {
                    return null;
                }
            }
            return current;
        } catch (JsonProcessingException e) {
            throw new RuntimeException("JSON解析失败", e);
        }
    }

    /**
     * 对象转Map
     *
     * @param obj 待转换的对象
     * @return 转换后的Map
     */
    public static Map<String, Object> toMap(Object obj) {
        if (obj == null) {
            return null;
        }
        try {
            // 先序列化为JSON字符串，再反序列化为Map
            String json = objectMapper.writeValueAsString(obj);
            MapType mapType = objectMapper.getTypeFactory().constructMapType(Map.class, String.class, Object.class);
            return objectMapper.readValue(json, mapType);
        } catch (JsonProcessingException e) {
            throw new RuntimeException("对象转Map失败", e);
        }
    }

    /**
     * 对象转Map（指定类型）
     *
     * @param obj       待转换的对象
     * @param valueType Map中value的类型
     * @param <V>       value类型
     * @return 转换后的Map
     */
    public static <V> Map<String, V> toMap(Object obj, Class<V> valueType) {
        if (obj == null) {
            return null;
        }
        try {
            // 先序列化为JSON字符串，再反序列化为指定类型的Map
            String json = objectMapper.writeValueAsString(obj);
            MapType mapType = objectMapper.getTypeFactory().constructMapType(Map.class, String.class, valueType);
            return objectMapper.readValue(json, mapType);
        } catch (JsonProcessingException e) {
            throw new RuntimeException("对象转Map失败", e);
        }
    }

    /**
     * 获取ObjectMapper实例，用于自定义配置
     *
     * @return ObjectMapper实例
     */
    public static ObjectMapper getObjectMapper() {
        return objectMapper;
    }
}