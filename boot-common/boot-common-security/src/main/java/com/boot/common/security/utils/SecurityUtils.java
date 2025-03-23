package com.boot.common.security.utils;

import cn.hutool.core.util.StrUtil;
import com.boot.common.core.cache.BootCache;
import com.boot.common.core.constant.CacheConstants;
import com.boot.common.core.constant.HttpStatus;
import com.boot.common.core.enums.EnumUserRoleType;
import com.boot.common.core.exception.CustomException;
import com.boot.common.core.exception.ServiceException;
import com.boot.common.core.utils.StringUtils;
import com.boot.common.security.core.domain.model.LoginUser;
import com.boot.common.core.utils.spring.SpringUtils;
import com.boot.common.security.service.TokenService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.Arrays;
import java.util.Objects;

/**
 * 安全服务工具类
 *
 * @author boot
 */
public class SecurityUtils {
    /**
     * 用户ID
     **/
    public static Long getUserId() {
        try {
            return getLoginUser().getUserId();
        } catch (Exception e) {
            throw new ServiceException("获取用户ID异常", HttpStatus.UNAUTHORIZED);
        }
    }

    public static Long getCurrentTenantId() {
        try {
            return getLoginUser().getUserId();
        } catch (Exception e) {
            throw new ServiceException("获取租户ID异常", HttpStatus.UNAUTHORIZED);
        }
    }


    /**
     * 获取部门ID
     **/
    public static Long getDeptId() {
        try {
            return getLoginUser().getDeptId();
        } catch (Exception e) {
            throw new ServiceException("获取部门ID异常", HttpStatus.UNAUTHORIZED);
        }
    }

    /**
     * 获取用户账户
     **/
    public static String getUsername() {
        try {
            return getLoginUser().getUser().getUserName();
        } catch (Exception e) {
            throw new ServiceException("获取用户账户异常", HttpStatus.UNAUTHORIZED);
        }
    }

    /**
     * 获取用户
     **/
    public static LoginUser getLoginUser() {
        TokenService tokenService = SpringUtils.getBean(TokenService.class);
        try {
            return tokenService.getLoginUser();
        } catch (Exception e) {
            throw new CustomException("获取用户信息异常", HttpStatus.UNAUTHORIZED);
        }
    }


    /**
     * 生成BCryptPasswordEncoder密码
     *
     * @param password 密码
     * @return 加密字符串
     */
    public static String encryptPassword(String password) {
        BCryptPasswordEncoder passwordEncoder = SpringUtils.getBean(BCryptPasswordEncoder.class);
        return passwordEncoder.encode(password);
    }

    /**
     * 判断密码是否相同
     *
     * @param rawPassword     真实密码
     * @param encodedPassword 加密后字符
     * @return 结果
     */
    public static boolean matchesPassword(String rawPassword, String encodedPassword) {
        BCryptPasswordEncoder passwordEncoder = SpringUtils.getBean(BCryptPasswordEncoder.class);
        return passwordEncoder.matches(rawPassword, encodedPassword);
    }

    /**
     * 是否为管理员
     *
     * @param userId 用户ID
     * @return 结果
     */
    public static boolean isAdmin(Long userId) {
        return userId != null && 1L == userId;
    }


    public static void logout(Long userId) {
        if (Objects.nonNull(userId)) {
            BootCache bootCache = SpringUtils.getBean(BootCache.class);
            bootCache.keys(CacheConstants.LOGIN_TOKEN_KEY + "*").forEach(key -> {
                LoginUser loginUser = bootCache.getCacheObject(key);
                if (loginUser.getUserId().equals(userId)) {
                    bootCache.deleteObject(key);
                }
            });
        }

    }

    public static void logout(String tokenId) {
        if (StrUtil.isNotEmpty(tokenId)) {
            BootCache bootCache = SpringUtils.getBean(BootCache.class);
            bootCache.deleteObject(CacheConstants.LOGIN_TOKEN_KEY + tokenId);
        }
    }

}
