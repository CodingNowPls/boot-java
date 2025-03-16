package com.boot.system.service;

import cn.dev33.satoken.stp.StpUtil;
import com.boot.common.core.cache.BootCache;
import com.boot.common.core.constant.CacheConstants;
import com.boot.common.core.constant.Constants;
import com.boot.common.core.constant.UserConstants;
import com.boot.common.core.domain.entity.SysUser;
import com.boot.common.core.exception.user.*;
import com.boot.common.core.exception.ServiceException;
import com.boot.common.log.manager.AsyncManager;
import com.boot.common.log.manager.factory.AsyncFactory;
import com.boot.common.security.core.domain.model.LoginUser;
import com.boot.common.security.service.SysLoginService;
import com.boot.common.security.service.TokenService;
import com.boot.common.core.utils.DateUtils;
import com.boot.common.core.utils.MessageUtils;
import com.boot.common.core.utils.StringUtils;
import com.boot.common.core.utils.ip.IpUtils;
import com.boot.common.core.utils.sign.RsaUtils;
import com.boot.system.service.impl.UserSaServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Component;

/**
 * 登录校验方法
 *
 * @author boot
 */
@Component
public class SysLoginServiceImpl implements SysLoginService {
    @Autowired
    private TokenService tokenService;


    @Autowired
    private BootCache bootCache;

    @Autowired
    private ISysUserService userService;

    @Autowired
    private ISysConfigService configService;

    @Autowired
    private UserSaServiceImpl userSaService;


    /**
     * 登录验证
     *
     * @param username 用户名
     * @param password 密码
     * @param code     验证码
     * @param uuid     唯一标识
     * @return 结果
     */
    @Override
    public String login(String username, String password, String code, String uuid) throws Exception {
        // 验证码校验
        validateCaptcha(username, code, uuid);
        // 登录前置校验
        //loginPreCheck(username, password);
        // 集成jsencrypt实现密码加密传输方式
        String decryptedPassword = RsaUtils.decryptByPrivateKey(password);
        loginPreCheck(username, decryptedPassword);
        // 用户验证
        LoginUser loginUser;
        try {
            loginUser = userSaService.loadUserName(username, decryptedPassword);
            StpUtil.login(loginUser.getUserId());
        } catch (Exception e) {
            if (e instanceof UserPasswordNotMatchException) {
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.password.not.match")));
                throw new UserPasswordNotMatchException();
            } else {
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, e.getMessage()));
                throw new ServiceException(e.getMessage());
            }
        }
        AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_SUCCESS, MessageUtils.message("user.login.success")));

        recordLoginInfo(loginUser.getUserId());
        // 生成token
        return tokenService.createToken(loginUser);
    }

    /**
     * 校验验证码
     *
     * @param username 用户名
     * @param code     验证码
     * @param uuid     唯一标识
     * @return 结果
     */
    @Override
    public void validateCaptcha(String username, String code, String uuid) {
        if (StringUtils.isNotEmpty(code) && SysLoginService.NOT_NEED_CHECK_CODE.equalsIgnoreCase(code)) {
           //如果是magicApi登陆就直接放过
            return;
        }
        boolean captchaEnabled = configService.selectCaptchaEnabled();
        if (captchaEnabled) {
            String verifyKey = CacheConstants.CAPTCHA_CODE_KEY + StringUtils.nvl(uuid, "");
            String captcha = bootCache.getCacheObject(verifyKey);
            bootCache.deleteObject(verifyKey);
            if (captcha == null) {
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.jcaptcha.expire")));
                throw new CaptchaExpireException();
            }
            if (!code.equalsIgnoreCase(captcha)) {
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.jcaptcha.error")));
                throw new CaptchaException();
            }
        }
    }

    /**
     * 登录前置校验
     *
     * @param username 用户名
     * @param password 用户密码
     */
    @Override
    public void loginPreCheck(String username, String password) {
        // 用户名或密码为空 错误
        if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("not.null")));
            throw new UserNotExistsException();
        }
        // 密码如果不在指定范围内 错误
        if (password.length() < UserConstants.PASSWORD_MIN_LENGTH
                || password.length() > UserConstants.PASSWORD_MAX_LENGTH) {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.password.not.match")));
            throw new UserPasswordNotMatchException();
        }
        // 用户名不在指定范围内 错误
        if (username.length() < UserConstants.USERNAME_MIN_LENGTH
                || username.length() > UserConstants.USERNAME_MAX_LENGTH) {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.password.not.match")));
            throw new UserPasswordNotMatchException();
        }
        // IP黑名单校验
        String blackStr = configService.selectConfigByKey("sys.login.blackIPList");
        if (IpUtils.isMatchedIp(blackStr, IpUtils.getIpAddr())) {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("login.blocked")));
            throw new BlackListException();
        }
    }

    /**
     * 记录登录信息
     *
     * @param userId 用户ID
     */
    @Override
    public void recordLoginInfo(Long userId) {
        SysUser sysUser = new SysUser();
        sysUser.setUserId(userId);
        sysUser.setLoginIp(IpUtils.getIpAddr());
        sysUser.setLoginDate(DateUtils.getNowDate());
        userService.updateUserProfile(sysUser);
    }
}
