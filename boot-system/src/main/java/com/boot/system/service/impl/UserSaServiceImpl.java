package com.boot.system.service.impl;


import com.boot.common.core.domain.entity.SysUser;
import com.boot.common.core.enums.UserStatus;
import com.boot.common.core.exception.CustomException;
import com.boot.common.core.exception.ServiceException;
import com.boot.common.core.exception.base.BaseException;
import com.boot.common.core.exception.user.UserPasswordNotMatchException;
import com.boot.common.core.utils.StringUtils;
import com.boot.common.core.utils.sign.RsaUtils;
import com.boot.common.security.core.domain.model.LoginUser;
import com.boot.common.security.utils.SecurityUtils;
import com.boot.system.service.ISysUserService;
import com.boot.system.service.SysPasswordService;
import com.boot.system.service.SysPermissionService;
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
    private SysPermissionService permissionService;

    @Autowired
    private SysPasswordService passwordService;

    public LoginUser loadUserName(String username, String password){
        SysUser user = userService.selectUserByUserName(username);
        passwordService.validate(user,username, password);
        return createLoginUser(user);
    }


    private LoginUser createLoginUser(SysUser user) {
        return new LoginUser(user, permissionService.getMenuPermission(user));
    }
}
