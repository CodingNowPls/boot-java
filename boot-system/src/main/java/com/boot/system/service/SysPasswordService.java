package com.boot.system.service;

import com.boot.common.core.cache.BootCache;
import com.boot.common.core.constant.CacheConstants;

import com.boot.common.core.constant.Constants;
import com.boot.common.core.domain.entity.SysUser;
import com.boot.common.core.enums.UserStatus;
import com.boot.common.core.exception.ServiceException;
import com.boot.common.core.exception.user.UserPasswordNotMatchException;
import com.boot.common.core.exception.user.UserPasswordRetryLimitExceedException;
import com.boot.common.core.utils.MessageUtils;
import com.boot.common.core.utils.StringUtils;
import com.boot.common.core.utils.sign.RsaUtils;
import com.boot.common.log.manager.AsyncManager;
import com.boot.common.log.manager.factory.AsyncFactory;
import com.boot.common.security.utils.SecurityUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;

/**
 * 登录密码方法
 *
 * @author boot
 */
@Slf4j
@Component
public class SysPasswordService {
    @Autowired
    private BootCache bootCache;

    @Value(value = "${user.password.maxRetryCount}")
    private int maxRetryCount;

    @Value(value = "${user.password.lockTime}")
    private int lockTime;


    /**
     * 登录账户密码错误次数缓存键名
     *
     * @param username 用户名
     * @return 缓存键key
     */
    private String getCacheKey(String username) {
        return CacheConstants.PWD_ERR_CNT_KEY + username;
    }

    /**
     * 密码校验
     * @param user
     * @param username
     * @param password
     */
    public void validate(SysUser user, String username,String password) {
        if (StringUtils.isNull(user)) {
            log.info("登录用户：{} 不存在.", username);
            throw new ServiceException("登录用户不存在");
        }

        Integer retryCount = bootCache.getCacheObject(getCacheKey(username));

        if (retryCount == null) {
            retryCount = 0;
        }

        if (retryCount >= Integer.valueOf(maxRetryCount).intValue()) {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL,
                    MessageUtils.message("user.password.retry.limit.exceed", maxRetryCount, lockTime)));
            throw new UserPasswordRetryLimitExceedException(maxRetryCount, lockTime);
        }


        if (UserStatus.DELETED.getCode().equals(user.getDelFlag())) {
            log.info("登录用户：{} 已被删除.", username);
            throw new ServiceException("对不起，您的账号：" + username + " 已被删除");
        } else if (UserStatus.DISABLE.getCode().equals(user.getStatus())) {
            log.info("登录用户：{} 已被停用.", username);
            throw new ServiceException("对不起，您的账号：" + username + " 已停用");
        }

        if (!matches(user, password)) {
            retryCount = retryCount + 1;
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL,
                    MessageUtils.message("user.password.retry.limit.count", retryCount)));
            bootCache.setCacheObject(getCacheKey(username), retryCount, lockTime, TimeUnit.MINUTES);
            throw new UserPasswordNotMatchException();
        } else {
            clearLoginRecordCache(username);
        }
    }

    public boolean matches(SysUser user, String rawPassword) {
        return SecurityUtils.matchesPassword(rawPassword, user.getPassword());
    }

    public void clearLoginRecordCache(String loginName) {
        if (bootCache.hasKey(getCacheKey(loginName))) {
            bootCache.deleteObject(getCacheKey(loginName));
        }
    }
}
