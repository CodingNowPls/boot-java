package com.boot.system.controller;

import cn.dev33.satoken.stp.StpUtil;
import com.alibaba.fastjson2.JSON;
import com.boot.common.core.constant.Constants;
import com.boot.common.core.domain.AjaxResult;
import com.boot.common.core.domain.entity.SysMenu;
import com.boot.common.core.domain.entity.SysUser;
import com.boot.common.core.domain.model.LoginBody;
import com.boot.common.core.utils.ServletUtils;
import com.boot.common.core.utils.StringUtils;
import com.boot.common.log.manager.AsyncManager;
import com.boot.common.log.manager.factory.AsyncFactory;
import com.boot.common.security.core.domain.model.LoginUser;
import com.boot.common.security.service.TokenService;
import com.boot.common.security.utils.SecurityUtils;
import com.boot.system.service.ISysMenuService;
import com.boot.system.service.SysLoginServiceImpl;
import com.boot.system.service.SysPermissionServiceImpl;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import jakarta.servlet.http.Cookie;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;
import java.util.Set;

/**
 * 登录验证
 *
 * @author boot
 */
@Api(value = "用户登录认证", tags = {"用户登录认证"})
@RestController
public class SysLoginController {
    @Autowired
    private SysLoginServiceImpl loginService;

    @Autowired
    private ISysMenuService menuService;

    @Autowired
    private SysPermissionServiceImpl permissionService;
    @Autowired
    private TokenService tokenService;

    /**
     * 登录方法
     *
     * @param loginBody 登录信息
     * @return 结果
     */
    @ApiOperation("用户登录")
    @PostMapping("/login")
    public AjaxResult login(@RequestBody LoginBody loginBody) throws Exception {
        AjaxResult ajax = AjaxResult.success();
        // 生成令牌
        String token = loginService.login(loginBody.getUserName(), loginBody.getPassword(), loginBody.getCode(),
                loginBody.getUuid());
        ajax.put(Constants.TOKEN, token);
        Cookie tokenCookie = new Cookie("token", token);
        tokenCookie.setHttpOnly(true); // 防止XSS攻击
        tokenCookie.setSecure(true);   // 仅在HTTPS下传输
        tokenCookie.setPath("/");      // Cookie有效路径
        HttpServletResponse response = ServletUtils.getResponse();
        response.addCookie(tokenCookie);
        return ajax;
    }

    @PostMapping("/logout")
    public void logout(HttpServletRequest request, HttpServletResponse response) {
         tokenService.loginOut();
    }

    /**
     * 获取用户信息
     *
     * @return 用户信息
     */
    @ApiOperation("获取用户信息")
    @GetMapping("/getInfo")
    public AjaxResult getInfo() {
        //if (!StpUtil.isLogin()) {
        //    return AjaxResult.error("登陆状态失效");
        //}
        SysUser user = SecurityUtils.getLoginUser().getUser();
        // 角色集合
        Set<String> roles = permissionService.getRolePermission(user);
        // 权限集合
        Set<String> permissions = permissionService.getMenuPermission(user);
        AjaxResult ajax = AjaxResult.success();
        ajax.put("user", user);
        ajax.put("roles", roles);
        ajax.put("permissions", permissions);
        return ajax;
    }

    /**
     * 获取路由信息
     *
     * @return 路由信息
     */
    @ApiOperation("获取路由信息")
    @GetMapping("/getRouters")
    public AjaxResult getRouters() {
        Long userId = SecurityUtils.getUserId();
        List<SysMenu> menus = menuService.selectMenuTreeByUserId(userId);
        return AjaxResult.success(menuService.buildMenus(menus));
    }
}
