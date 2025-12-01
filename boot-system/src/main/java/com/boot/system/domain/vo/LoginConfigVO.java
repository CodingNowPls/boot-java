package com.boot.system.domain.vo;

import lombok.Data;

import java.util.List;

/**
 * 登录配置响应
 */
@Data
public class LoginConfigVO {
    /**
     * 是否开启验证码
     */
    private boolean captchaEnabled;

    /**
     * 是否显示租户下拉
     */
    private boolean showTenantSelect;

    /**
     * 系统租户模式：single/multi/auto
     */
    private String tenantMode;

    /**
     * 默认租户ID
     */
    private String defaultTenantId;

    /**
     * 平台租户ID
     */
    private String platformTenantId;

    /**
     * 可用租户数量
     */
    private long tenantCount;

    /**
     * 租户列表
     */
    private List<TenantVO> tenantList;
}

