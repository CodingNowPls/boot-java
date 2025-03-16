package com.boot.common.magicapi.interceptor;

import cn.hutool.core.util.StrUtil;
import com.boot.common.core.cache.BootCache;
import com.boot.common.core.constant.CacheConstants;
import com.boot.common.core.constant.Constants;
import com.boot.common.core.domain.entity.SysUser;
import com.boot.common.core.utils.DateUtils;
import com.boot.common.core.utils.MessageUtils;
import com.boot.common.core.utils.ServletUtils;
import com.boot.common.core.utils.ip.IpUtils;
import com.boot.common.core.utils.sign.RsaUtils;
import com.boot.common.log.manager.AsyncManager;
import com.boot.common.log.manager.factory.AsyncFactory;
import com.boot.common.security.core.domain.model.LoginUser;
import com.boot.common.security.service.PermissionService;
import com.boot.common.security.service.SysLoginService;
import com.boot.common.security.service.SysPermissionService;
import com.boot.common.security.service.TokenService;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.ssssssss.magicapi.core.context.MagicUser;
import org.ssssssss.magicapi.core.exception.MagicLoginException;
import org.ssssssss.magicapi.core.interceptor.AuthorizationInterceptor;

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
    private SysPermissionService sysPermissionService;

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
    public MagicUser getUserByToken(String token) throws MagicLoginException {
        // 从token中获取MagicUser对象
        LoginUser user = tokenService.magicApiLoginUser();
        try {
            //获取到用户之后，封装成magic-api的用户类
            if (user != null) {
                return new MagicUser(user.getUserId().toString(), user.getUserName(), token, expireTime);
            }
        } catch (Exception e) {
            //ruoyi的框架里边，如果token无效的话，会抛出异常，如果不做处理的话，会被magic-api捕获导致无法进入登录页面
        }

        throw new MagicLoginException("token无效");
    }

    @Override
    public MagicUser login(String username, String password) throws MagicLoginException {
        String token;
        try {
            String encryptPassword = RsaUtils.encryptByPublicKey(RsaUtils.publicKey, password);
            token = sysLoginService.login(username, encryptPassword, SysLoginService.NOT_NEED_CHECK_CODE, null);
        } catch (Exception e) {
            throw new MagicLoginException("登陆失败");
        }
//        //需要校验权限
//        boolean permi = permissionService.hasPermi("magic:api:code");
//        if (!permi) {
//            throw new MagicLoginException("无权限");
//        }
        AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_SUCCESS, MessageUtils.message("user.login.success")));
        MagicUser user = getUserByToken(token);

        // 返回登录信息  登录成功后将用户信息封装成magic-api的用户信息
        return new MagicUser(user.getId().toString(), username, token, expireTime);
    }

    @Override
    public void logout(String token) {

    }



    private String getTokenKey(String uuid) {
        return CacheConstants.LOGIN_TOKEN_KEY + uuid;
    }

    /**
     * 从令牌中获取数据声明
     *
     * @param token 令牌
     * @return 数据声明
     */
    private Claims parseToken(String token) {
        return Jwts.parser()
                .setSigningKey(secret)
                .parseClaimsJws(token)
                .getBody();
    }

}

