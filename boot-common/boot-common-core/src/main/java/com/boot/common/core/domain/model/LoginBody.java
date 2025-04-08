package com.boot.common.core.domain.model;

import lombok.Data;

/**
 * 用户登录对象
 *
 * @author boot
 */
@Data
public class LoginBody {
    /**
     * 用户名
     */
    private String userName;

    /**
     * 用户密码
     */
    private String password;

    /**
     * 验证码
     */
    private String code;

    /**
     * 唯一标识
     */
    private String uuid;

    /**
     * 租户id
     */
    private Long tenantId;
    /**
     * 是否是管理员登录
     */
    private Boolean isAdminLogin;



}
