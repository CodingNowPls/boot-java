package com.boot.system.domain.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 登录租户下拉VO
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TenantVO {
    private String tenantId;
    private String tenantName;
}

