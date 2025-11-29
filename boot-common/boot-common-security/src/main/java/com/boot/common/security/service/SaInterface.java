package com.boot.common.security.service;

import cn.dev33.satoken.exception.NotLoginException;
import cn.dev33.satoken.stp.StpInterface;
import com.boot.common.security.core.domain.model.LoginUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;


/**
 * 作为权限处理认证
 *
 * @author gao
 */
@Component
public class SaInterface implements StpInterface {
    @Autowired
    private TokenService tokenService;

    @Override
    public List<String> getPermissionList(Object o, String s) {
        LoginUser loginUser = tokenService.getLoginUser();
        if (Objects.isNull(loginUser)){
            throw new NotLoginException(NotLoginException.TOKEN_TIMEOUT_MESSAGE, "", NotLoginException.TOKEN_TIMEOUT);
        }
        //采用的是用户里自带的权限，实现一次性访问reids,进行判断是否可以访问
        return loginUser.getPermissions().stream().collect(Collectors.toList());
    }

    @Override
    public List<String> getRoleList(Object o, String s) {
        return null;
    }
}
