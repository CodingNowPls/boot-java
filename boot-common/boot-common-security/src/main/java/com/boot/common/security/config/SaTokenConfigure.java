package com.boot.common.security.config;


import cn.dev33.satoken.context.SaHolder;
import cn.dev33.satoken.exception.NotLoginException;
import cn.dev33.satoken.interceptor.SaInterceptor;
import cn.dev33.satoken.router.SaRouter;
import cn.dev33.satoken.spring.SpringMVCUtil;
import cn.dev33.satoken.stp.StpUtil;

import cn.dev33.satoken.util.SaFoxUtil;
import com.boot.common.core.config.BootConfig;
import com.boot.common.core.constant.HttpStatus;
import com.boot.common.core.exception.CustomException;
import com.boot.common.core.utils.ServletUtils;
import com.boot.common.core.utils.StringUtils;
import com.boot.common.log.context.UserContextProvider;
import com.boot.common.security.context.SecurityUserContextProvider;
import com.boot.common.security.core.domain.model.LoginUser;
import com.boot.common.security.service.TokenService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.util.List;
import java.util.Objects;

/**
 * @author gao
 */
@Slf4j
@Configuration
public class SaTokenConfigure implements WebMvcConfigurer {
    @Autowired
    private TokenService tokenService;

    @Autowired
    private SaTokenExcludeUrlConfig excludeUrlPathConfig;


    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserContextProvider userContextProvider() {
        return new SecurityUserContextProvider();
    }

    /**
     * 注册sa-token的拦截器
     *
     * @param registry
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 注册 Sa-Token 的路由拦截器
        List<String> excludeUrlPath = excludeUrlPathConfig.getExcludeUrlPath();
        SaInterceptor saInterceptor = new SaInterceptor(handle -> {
            HttpServletRequest request = ServletUtils.getRequest();
            try {
                LoginUser loginUser = tokenService.getLoginUser(request);
                if (Objects.nonNull(loginUser)) {
                    tokenService.verifyToken(loginUser);
                } else {
                    if (BootConfig.isFrontCoupled()) {
                        // 前后端一体化就跳转到登录页面
                        HttpServletResponse response = ServletUtils.getResponse();
                        try {
                            // 重定向到前端登录页面的 URL
                            // 请将 "/login" 替换为你实际的前端登录页面路径
                            String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
                            // 拼接前端登录路径和重定向参数
                            String loginUrl = baseUrl + "/#/login?redirect=%2Findex";
                            response.sendRedirect(loginUrl);
                        } catch (IOException e) {
                            // 处理重定向可能发生的 IOException
                            throw new RuntimeException("重定向到登录页失败", e);
                        }
                    } else {
                        log.error("这不报错了。。。。。");
                        //前后端分离就抛出异常
                        //throw new NotLoginException(NotLoginException.TOKEN_TIMEOUT_MESSAGE, "", NotLoginException.TOKEN_TIMEOUT);
                    }
                }
            } catch (Exception e) {
                //throw new NotLoginException(NotLoginException.TOKEN_TIMEOUT_MESSAGE, "", NotLoginException.TOKEN_TIMEOUT);
                log.error("这不报错了222222。。。。。");
            }
        });


        registry.addInterceptor(saInterceptor)
                .addPathPatterns("/**")
                // 排除不需要拦截的路径
                .excludePathPatterns(excludeUrlPath);
    }


}