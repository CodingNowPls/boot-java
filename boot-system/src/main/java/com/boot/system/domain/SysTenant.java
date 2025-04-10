package com.boot.system.domain;


import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.boot.common.core.domain.BaseEntity;
import com.boot.common.mybatis.page.TableSupport;
import lombok.Data;
import lombok.ToString;

import java.util.Date;

@Data
@ToString
@TableName("sys_tenant")
public class SysTenant extends TableSupport {

    @TableId
    private Long tenantId;

    @TableField("tenant_name")
    private String tenantName;

    @TableField("tenant_code")
    private String tenantCode;

    @TableField("contact_name")
    private String contactName;

    @TableField("contact_phone")
    private String contactPhone;

    @TableField("status")
    private Integer status;



}
