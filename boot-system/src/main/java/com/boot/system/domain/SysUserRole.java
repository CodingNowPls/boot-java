package com.boot.system.domain;

import lombok.Data;
import lombok.ToString;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 用户和角色关联 sys_user_role
 *
 * @author boot
 */
@Data
@ToString
public class SysUserRole {
    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 角色ID
     */
    private Long roleId;


}
