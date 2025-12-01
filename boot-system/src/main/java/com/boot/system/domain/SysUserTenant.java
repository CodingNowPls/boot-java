package com.boot.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.boot.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 用户租户关系
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_user_tenant")
public class SysUserTenant extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField("user_id")
    private Long userId;

    @TableField("tenant_id")
    private String tenantId;

    /**
     * 是否禁用（0正常 1禁用）
     */
    @TableField("disabled")
    private String disabled;
}

