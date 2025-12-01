package com.boot.system.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import com.alibaba.fastjson2.JSON;
import com.boot.common.core.constant.Constants;
import com.boot.common.core.domain.AjaxResult;
import com.boot.common.core.domain.entity.SysMenu;
import com.boot.common.core.domain.entity.SysUser;
import com.boot.common.core.domain.model.LoginBody;
import com.boot.common.core.utils.ServletUtils;
import com.boot.common.core.utils.StringUtils;
import com.boot.common.security.service.TokenService;
import com.boot.common.security.utils.SecurityUtils;
import com.boot.system.domain.SysTenant;
import com.boot.system.domain.SysUserTenant;
import com.boot.system.domain.vo.LoginConfigVO;
import com.boot.system.domain.vo.TenantVO;
import com.boot.system.service.*;
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

import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import org.springframework.util.CollectionUtils;

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
    @Autowired
    private ISysConfigService configService;
    @Autowired
    private ISysTenantService tenantService;
    @Autowired
    private ISysUserService userService;
    @Autowired
    private ISysUserTenantService userTenantService;

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
                loginBody.getUuid(), loginBody.getTenantId(), loginBody.getIsAdminLogin());
        ajax.put(Constants.TOKEN, token);
        Cookie tokenCookie = new Cookie(Constants.TOKEN, token);
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

    @ApiOperation("获取登录配置")
    @SaIgnore
    @GetMapping("/getLoginConfig")
    public AjaxResult getLoginConfig() {
        return AjaxResult.success(buildLoginConfig());
    }

    @ApiOperation("获取租户下拉列表")
    @SaIgnore
    @GetMapping("/getTenantList")
    public AjaxResult getTenantList(String userName, Boolean isAdminLogin) {
        boolean adminLogin = Boolean.TRUE.equals(isAdminLogin);
        List<TenantVO> tenants = adminLogin
                ? Collections.singletonList(buildTenantVO(Constants.ADMIN_DEFAULT_TENANT_ID))
                : buildUserTenantList(userName);
        return AjaxResult.success(tenants);
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
        // 当前登录用户和租户上下文
        com.boot.common.security.core.domain.model.LoginUser loginUser = SecurityUtils.getLoginUser();
        SysUser user = loginUser.getUser();
        // 角色集合
        Set<String> roles = permissionService.getRolePermission(user);
        // 权限集合
        Set<String> permissions = permissionService.getMenuPermission(user);
        AjaxResult ajax = AjaxResult.success();
        ajax.put("user", user);
        ajax.put("roles", roles);
        ajax.put("permissions", permissions);
        // 兼容前端多租户显示
        ajax.put("tenantId", loginUser.getTenantId());
        ajax.put("tenantName", loginUser.getTenantName());
        return ajax;
    }

    /**
     * 切换当前业务租户
     */
    @ApiOperation("切换租户")
    @PostMapping("/switchTenant")
    public AjaxResult switchTenant(String tenantId) {
        if (StringUtils.isEmpty(tenantId)) {
            return AjaxResult.error("租户ID不能为空");
        }
        com.boot.common.security.core.domain.model.LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null) {
            return AjaxResult.error("登录状态已失效");
        }
        SysUser user = loginUser.getUser();
        // 管理后台登录始终使用平台租户，不支持切换
        // 这里只处理业务后台租户切换
        List<SysUserTenant> relations = userTenantService.lambdaQuery()
                .eq(SysUserTenant::getUserId, user.getUserId())
                .eq(SysUserTenant::getDisabled, "0")
                .list();
        if (CollectionUtils.isEmpty(relations)) {
            // 没有关系时仅允许切换到默认租户
            if (!Constants.DEFAULT_TENANT_ID.equals(tenantId)) {
                return AjaxResult.error("当前用户不属于该租户");
            }
        } else {
            List<String> tenantIds = relations.stream()
                    .map(SysUserTenant::getTenantId)
                    .distinct()
                    .collect(Collectors.toList());
            if (!tenantIds.contains(tenantId)) {
                return AjaxResult.error("当前用户不属于该租户");
            }
        }
        SysTenant tenant = tenantService.getById(tenantId);
        if (tenant == null || !"0".equals(tenant.getStatus()) || !"0".equals(tenant.getDelFlag())) {
            return AjaxResult.error("租户不可用或已被删除");
        }
        // 更新登录上下文中的租户信息
        loginUser.setTenantId(tenant.getTenantId());
        loginUser.setTenantName(tenant.getTenantName());
        // 记录业务后台最后登录租户
        SysUser update = new SysUser();
        update.setUserId(user.getUserId());
        update.setBusinessLoginTenantId(tenant.getTenantId());
        userService.updateUserProfile(update);
        // 刷新缓存中的 LoginUser
        tokenService.setLoginUser(loginUser);
        return AjaxResult.success();
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

    private LoginConfigVO buildLoginConfig() {
        LoginConfigVO vo = new LoginConfigVO();
        vo.setCaptchaEnabled(configService.selectCaptchaEnabled());
        vo.setShowTenantSelect(Boolean.parseBoolean(configService.selectConfigByKey("sys.login.showTenantSelect")));
        String tenantMode = configService.selectConfigByKey("sys.tenant.mode");
        vo.setTenantMode(StringUtils.isEmpty(tenantMode) ? "auto" : tenantMode);
        String defaultTenantId = configService.selectConfigByKey("sys.tenant.defaultTenantId");
        vo.setDefaultTenantId(StringUtils.isEmpty(defaultTenantId) ? Constants.DEFAULT_TENANT_ID : defaultTenantId);
        vo.setPlatformTenantId(Constants.PLATFORM_TENANT_ID);
        List<TenantVO> tenantList = buildAllActiveTenants();
        vo.setTenantList(tenantList);
        vo.setTenantCount(tenantList.size());
        return vo;
    }

    private List<TenantVO> buildUserTenantList(String userName) {
        if (StringUtils.isEmpty(userName)) {
            return Collections.emptyList();
        }
        SysUser user = userService.selectUserByUserName(userName);
        if (user == null) {
            return Collections.emptyList();
        }
        List<SysUserTenant> relations = userTenantService.lambdaQuery()
                .eq(SysUserTenant::getUserId, user.getUserId())
                .eq(SysUserTenant::getDisabled, "0")
                .list();
        if (CollectionUtils.isEmpty(relations)) {
            return Collections.singletonList(buildTenantVO(Constants.DEFAULT_TENANT_ID));
        }
        List<String> tenantIds = relations.stream()
                .map(SysUserTenant::getTenantId)
                .distinct()
                .collect(Collectors.toList());
        if (CollectionUtils.isEmpty(tenantIds)) {
            return Collections.singletonList(buildTenantVO(Constants.DEFAULT_TENANT_ID));
        }
        List<SysTenant> tenants = tenantService.lambdaQuery()
                .in(SysTenant::getTenantId, tenantIds)
                .eq(SysTenant::getStatus, "0")
                .eq(SysTenant::getDelFlag, "0")
                .list();
        if (CollectionUtils.isEmpty(tenants)) {
            return Collections.singletonList(buildTenantVO(Constants.DEFAULT_TENANT_ID));
        }
        return tenants.stream()
                .map(tenant -> new TenantVO(tenant.getTenantId(), tenant.getTenantName()))
                .collect(Collectors.toList());
    }

    private List<TenantVO> buildAllActiveTenants() {
        List<SysTenant> tenants = tenantService.lambdaQuery()
                .eq(SysTenant::getStatus, "0")
                .eq(SysTenant::getDelFlag, "0")
                .list();
        if (CollectionUtils.isEmpty(tenants)) {
            return Collections.singletonList(buildTenantVO(Constants.DEFAULT_TENANT_ID));
        }
        return tenants.stream()
                .map(tenant -> new TenantVO(tenant.getTenantId(), tenant.getTenantName()))
                .collect(Collectors.toList());
    }

    private TenantVO buildTenantVO(String tenantId) {
        String target = StringUtils.isEmpty(tenantId) ? Constants.DEFAULT_TENANT_ID : tenantId;
        SysTenant tenant = tenantService.getById(target);
        String tenantName = tenant == null ? "默认租户" : tenant.getTenantName();
        return new TenantVO(target, tenantName);
    }
}
