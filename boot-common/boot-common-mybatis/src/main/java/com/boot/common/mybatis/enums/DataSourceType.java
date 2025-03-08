package com.boot.common.mybatis.enums;

import lombok.Getter;

/**
 * 数据源
 *
 * @author boot
 */
public enum DataSourceType {
    /**
     * 主库
     */
    MASTER(DataSourceType.masterDsName),

    /**
     * 从库
     */
    SLAVE(DataSourceType.slaveDsName),
    ;

    @Getter
    private String dsName;

    public final static String masterDsName = "master";

    public final static String slaveDsName = "slave";

    DataSourceType(String dsName) {
        this.dsName = dsName;
    }
}
