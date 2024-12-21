package com.boot.common.security.context;

import com.boot.common.log.context.UserContextProvider;
import com.boot.common.security.core.domain.model.LoginUser;
import com.boot.common.security.utils.SecurityUtils;

/**
 * 用户上下文实现类
 * @author gao
 */
public class SecurityUserContextProvider implements UserContextProvider {
    @Override
    public String getCurrentUserName() {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        return (loginUser != null) ? loginUser.getUserName() : null;
    }
}
