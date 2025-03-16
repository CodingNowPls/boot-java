package com.boot.common.security.service;

import com.boot.common.core.domain.entity.SysUser;

public interface SysPasswordService {


    /**
     * 密码校验
     *
     * @param user
     * @param username
     * @param password
     */
    void validate(SysUser user, String username, String password);

    boolean matches(SysUser user, String rawPassword);

    void clearLoginRecordCache(String loginName);
}
