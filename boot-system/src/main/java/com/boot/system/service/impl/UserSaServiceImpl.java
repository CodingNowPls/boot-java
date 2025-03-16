package com.boot.system.service.impl;


import com.boot.common.core.domain.entity.SysUser;
import com.boot.common.security.core.domain.model.LoginUser;
import com.boot.system.service.ISysUserService;
import com.boot.system.service.SysPasswordServiceImpl;
import com.boot.system.service.SysPermissionServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * @author gao
 */
@Service
public class UserSaServiceImpl {
    private static final Logger log = LoggerFactory.getLogger(UserSaServiceImpl.class);

    @Autowired
    private ISysUserService userService;

    @Autowired
    private SysPermissionServiceImpl permissionService;

    @Autowired
    private SysPasswordServiceImpl passwordService;

    public LoginUser loadUserName(String username, String password){
        SysUser user = userService.selectUserByUserName(username);
        passwordService.validate(user,username, password);
        return createLoginUser(user);
    }


    private LoginUser createLoginUser(SysUser user) {
        return new LoginUser(user, permissionService.getMenuPermission(user));
    }
}
