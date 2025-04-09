package com.boot.system.domain;


import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.ToString;

import java.util.Date;

@Data
@ToString
@TableName("sys_tenant")
public class SysTenant {


    private Long tenantId;

    private String tenantName;

    private String tenantCode;

    private String contactName;

    private String contactPhone;

    private Integer status;

    private Date createTime;






}
