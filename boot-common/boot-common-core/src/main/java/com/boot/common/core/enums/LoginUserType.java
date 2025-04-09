package com.boot.common.core.enums;

import lombok.Getter;

public enum LoginUserType {


    SYS_USER("sys_user"),


    USER("user");

    @Getter
    private String code;


    LoginUserType(String code) {
        this.code = code;
    }





}
