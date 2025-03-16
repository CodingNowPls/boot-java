package com.boot.common.security.service;

import com.boot.common.core.domain.entity.SysUser;

import java.util.Set;

public interface SysPermissionService {

      Set<String> getRolePermission(SysUser user);

    Set<String> getMenuPermission(SysUser user);
}
