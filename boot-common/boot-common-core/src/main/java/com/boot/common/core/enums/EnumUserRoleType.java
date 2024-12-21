package com.boot.common.core.enums;

import lombok.Getter;

/**
 * @author :
 * @date 2024年07月20日
 * -------------------------------------------<br>
 * <br>
 * <br>
 */
public enum EnumUserRoleType {

    NORMAL("normal", "普通用户"),
    SYS_USER("admin", "系统用户"),

    ADMIN_GROUP("admin_group", "管理组成员"),


    ;
    @Getter
    private String roleKey;
    @Getter
    private String desc;

    EnumUserRoleType(String roleKey, String desc) {
        this.roleKey = roleKey;
        this.desc = desc;
    }

}
