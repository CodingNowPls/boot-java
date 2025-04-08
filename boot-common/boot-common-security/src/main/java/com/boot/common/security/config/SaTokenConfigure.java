package com.boot.common.security.config;


import cn.dev33.satoken.exception.NotLoginException;
import cn.dev33.satoken.interceptor.SaInterceptor;
import cn.dev33.satoken.stp.StpUtil;

import com.boot.common.core.constant.HttpStatus;
import com.boot.common.core.exception.CustomException;
import com.boot.common.core.utils.ServletUtils;
import com.boot.common.core.utils.StringUtils;
import com.boot.common.log.context.UserContextProvider;
import com.boot.common.security.context.SecurityUserContextProvider;
import com.boot.common.security.core.domain.model.LoginUser;
import com.boot.common.security.service.TokenService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;

/**
 * @author gao
 */
@Configuration
public class SaTokenConfigure implements WebMvcConfigurer {
    @Autowired
    private TokenService tokenService;


    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserContextProvider userContextProvider() {
        return new SecurityUserContextProvider();
    }

    @Value("${magic-api.web}")
    private String magicApiWebUrl;


    /**
     * 注册sa-token的拦截器
     *
     * @param registry
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 注册 Sa-Token 的路由拦截器
        registry.addInterceptor(new SaInterceptor(handle -> {
                    HttpServletRequest request = ServletUtils.getRequest();
                    LoginUser loginUser = tokenService.getLoginUser(request);
                    if (StringUtils.isNotNull(loginUser)) {
                        tokenService.verifyToken(loginUser);
                    } else {
                        throw new CustomException("当前会话未登录", HttpStatus.UNAUTHORIZED);
                    }

                }))
                .addPathPatterns("/**")
                // 排除不需要拦截的路径
                .excludePathPatterns(
                        "/login",
                        "/logout",
                        "/register",
                        "/captchaImage",
                        "/*.html",
                        "/**/*.html",
                        "/**/*.css",
                        "/**/*.js",
                        "/favicon.ico",
                        "/static/**",
                        "/system/config/5",
                        "/profile/**",
                        "/common/download**",
                        "/common/download/resource**",
                        "/swagger-ui.html",
                        "/swagger-resources/**",
                        "/webjars/**",
                         magicApiWebUrl+"/**",
                        "/system/tenant/list**",
                        "/*/api-docs",
                        "/druid/**"
                );
    }


}