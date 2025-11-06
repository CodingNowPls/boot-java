package com.boot.common.security.core.domain.model;

import cn.hutool.core.util.StrUtil;
import com.boot.common.core.domain.entity.SysRole;
import com.boot.common.core.domain.entity.SysUser;
import com.boot.common.core.enums.EnumUserRoleType;
import lombok.Data;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;
import java.util.Set;

/**
 * 登录用户身份权限
 *
 * @author boot
 */
@Data
public class LoginUser  implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 部门ID
     */
    private Long deptId;

    /**
     * 用户唯一标识
     */
    private String token;

    /**
     * 登录时间
     */
    private Long loginTime;

    /**
     * 过期时间
     */
    private Long expireTime;

    /**
     * 登录IP地址
     */
    private String ipaddr;

    /**
     * 登录地点
     */
    private String loginLocation;

    /**
     * 浏览器类型
     */
    private String browser;

    /**
     * 操作系统
     */
    private String os;

    /**
     * 权限列表
     */
    private Set<String> permissions;

    /**
     * 用户信息
     */
    private SysUser user;



    private String userName;


    private String password;


    private Long tenantId;




    public LoginUser() {
    }

    public LoginUser(SysUser user, Set<String> permissions) {
        this.user = user;
        this.userName = user.getUserName();
        this.password = user.getPassword();

        this.userId = user.getUserId();
        this.deptId = user.getDeptId();
        this.userName = user.getUserName();
        this.permissions = permissions;
    }

    public LoginUser(Long userId, Long deptId, SysUser user, Set<String> permissions) {
        this.password = user.getPassword();
        this.userId = userId;
        this.deptId = deptId;
        this.user = user;
        this.userName = user.getUserName();
        this.permissions = permissions;
    }


    public boolean isAdmin() {
        return this.user.getUserId() != null && 1L == this.user.getUserId();
    }

    /**
     * 是否是管理组
     *
     * @return
     */
    public boolean isAdminGroup() {
        return isAdmin() || isContainRole(null,EnumUserRoleType.ADMIN_GROUP.getRoleKey(),null);
    }


    /**
     * 是否包含角色
     *
     * @param
     * @return
     */
    public boolean isContainRole(String roleName,String roleKey,Long roleId) {
        List<SysRole> roles = this.user.getRoles();
        if (roles == null) {
            return false;
        }

        if (roleId != null) {
            return roles.stream().anyMatch(role -> roleId.equals(role.getRoleId()));
        }
        if (StrUtil.isNotEmpty(roleKey) && StrUtil.isNotEmpty(roleName)) {
            return roles.stream().anyMatch(role -> roleName.equals(role.getRoleKey()));
        }
        if (StrUtil.isNotEmpty(roleName)) {
            return roles.stream().anyMatch(role -> roleName.equals(role.getRoleName()));
        }
        return false;
    }
}
