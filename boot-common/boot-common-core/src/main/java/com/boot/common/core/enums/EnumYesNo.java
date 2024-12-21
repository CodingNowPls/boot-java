package com.boot.common.core.enums;

import lombok.Getter;

/**
 * @author :
 * @date 2024年07月12日
 * -------------------------------------------<br>
 * <br>
 * <br>
 */
public enum EnumYesNo {

    YES(1, "是"),
    NO(2, "否");

    @Getter
    private final int code;
    @Getter
    private final String info;

    EnumYesNo(int code, String info) {
        this.code = code;
        this.info = info;
    }

    public int getCode() {
        return code;
    }

    public String getInfo() {
        return info;
    }
}
