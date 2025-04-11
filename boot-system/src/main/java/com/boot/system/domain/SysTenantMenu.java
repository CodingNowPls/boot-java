package com.boot.system.domain;


import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.boot.common.mybatis.page.TableSupport;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@TableName("sys_tenant_menu")
public class SysTenantMenu extends TableSupport {

    @TableId
    private Long tenantMenuId;




}
