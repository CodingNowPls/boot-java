package com.boot.common.core.enums;

import lombok.Getter;

public enum EnumCacheType {


    REDIS(EnumCacheType.CACHE_TYPE_REDIS),

    LOCAL(EnumCacheType.CACHE_TYPE_LOCAL);
    @Getter
    private String type;

    public static final String CACHE_TYPE_LOCAL = "local";
    public static final String CACHE_TYPE_REDIS = "redis";

    EnumCacheType(String type) {
        this.type = type;
    }


    public static EnumCacheType getEnumCacheType(String type) {
        for (EnumCacheType value : EnumCacheType.values()) {
            if (value.getType().equals(type)) {
                return value;
            }
        }
        return null;
    }
}
