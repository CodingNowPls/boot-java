package com.boot.common.magicapi.interceptor;

import cn.dev33.satoken.exception.NotLoginException;
import com.boot.common.core.cache.BootCache;
import com.boot.common.core.constant.Constants;
import com.boot.common.core.utils.MessageUtils;
import com.boot.common.core.utils.ServletUtils;
import com.boot.common.core.utils.sign.RsaUtils;
import com.boot.common.log.manager.AsyncManager;
import com.boot.common.log.manager.factory.AsyncFactory;
import com.boot.common.security.core.domain.model.LoginUser;
import com.boot.common.security.service.PermissionService;
import com.boot.common.security.service.SysLoginService;
import com.boot.common.security.service.TokenService;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.ssssssss.magicapi.core.context.MagicUser;
import org.ssssssss.magicapi.core.exception.MagicLoginException;
import org.ssssssss.magicapi.core.interceptor.AuthorizationInterceptor;

import java.util.Objects;

@Component
public class MagicLoginAuthorizationInterceptor implements AuthorizationInterceptor {

    // 令牌秘钥
    @Value("${token.secret}")
    private String secret;

    // 令牌有效期（默认30分钟）
    @Value("${token.expireTime}")
    private int expireTime;

    @Autowired
    private SysLoginService sysLoginService;

    @Autowired
    private BootCache bootCache;

    @Value("${magic-api.needLogin}")
    private Boolean needLogin;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private PermissionService permissionService;

    /**
     * 配置是否需要登录
     */
    @Override
    public boolean requireLogin() {
        return needLogin;
    }

    /**
     * 根据Token获取User
     */
    @Override
    public MagicUser getUserByToken(String token) {
        try {
            LoginUser user = tokenService.getLoginUserFromToken(token);
            if (Objects.isNull(user)) {
                throw new MagicLoginException("请从网站登录页登陆");
            }
            HttpServletRequest request = ServletUtils.getRequest();
            request.setAttribute("token", token);
            return new MagicUser(
                    user.getUserId().toString(),
                    user.getUserName(),
                    token,
                    expireTime
            );
        } catch (Exception e) {
            throw new NotLoginException(NotLoginException.TOKEN_TIMEOUT_MESSAGE, "", NotLoginException.TOKEN_TIMEOUT);
        }
    }

    @Override
    public MagicUser login(String username, String password) {
        try {
            String token;
            try {
                String encryptPassword = RsaUtils.encryptByPublicKey(RsaUtils.publicKey, password);
                token = sysLoginService.login(username, encryptPassword, SysLoginService.NOT_NEED_CHECK_CODE, null);
            } catch (Exception e) {
                throw new MagicLoginException("登陆失败");
            }
            //需要校验权限
            boolean permi = permissionService.hasPermi("magic:api:code", token);
            if (!permi) {
                throw new MagicLoginException("无权限");
            }
            MagicUser user = getUserByToken(token);
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_SUCCESS, MessageUtils.message("user.login.success")));
            // 返回登录信息  登录成功后将用户信息封装成magic-api的用户信息
            return new MagicUser(user.getId().toString(), username, token, expireTime);
        } catch (Exception e) {
            throw new NotLoginException(NotLoginException.TOKEN_TIMEOUT_MESSAGE, "", NotLoginException.TOKEN_TIMEOUT);
        }
    }

    @Override
    public void refreshToken(MagicUser user) {
        try {
            String token = user.getToken();
            tokenService.verifyToken(token);
        } catch (Exception e) {
            throw new NotLoginException(NotLoginException.TOKEN_TIMEOUT_MESSAGE, "", NotLoginException.TOKEN_TIMEOUT);
        }
    }

    @Override
    public void logout(String token) {
       //tokenService.loginOut();
    }
}

