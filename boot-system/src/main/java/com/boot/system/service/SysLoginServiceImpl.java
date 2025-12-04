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
import com.boot.system.domain.SysTenant;
import com.boot.system.service.ISysTenantService;
import com.boot.system.service.impl.UserSaServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
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

    @Autowired
    private ISysTenantService tenantService;

    private static final String STATUS_NORMAL = "0";
    private static final String DEFAULT_TENANT_NAME = "默认租户";

    /**
     * 登录验证
     *
     * @param username 用户名
     * @param password 密码
     * @param code     验证码
     * @param uuid     唯一标识
     * @param tenantId 租户ID（业务后台必填）
     * @param isAdminLogin 是否管理后台登录
     * @return 结果
     */
    @Override
    public String login(String username, String password, String code, String uuid, String tenantId, Boolean isAdminLogin) throws Exception {
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
        boolean adminLogin = Boolean.TRUE.equals(isAdminLogin);
        TenantInfo tenantInfo = determineTenant(loginUser.getUser(), tenantId, adminLogin);
        loginUser.setTenantId(tenantInfo.getTenantId());
        loginUser.setTenantName(tenantInfo.getTenantName());
        updateLastLoginTenant(loginUser.getUser(), tenantInfo.getTenantId(), adminLogin);
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

    private TenantInfo determineTenant(SysUser user, String requestedTenantId, boolean adminLogin) {
        if (adminLogin) {
            // 管理后台登录使用平台租户
            return buildTenantInfo(Constants.PLATFORM_TENANT_ID);
        }
        
        // 获取用户所属的租户ID
        String userTenantId = user.getTenantId();
        if (StringUtils.isEmpty(userTenantId)) {
            // 如果用户没有设置tenant_id，使用默认租户
            userTenantId = Constants.DEFAULT_TENANT_ID;
        }
        
        // 如果用户请求了租户ID，验证是否与用户所属租户一致
        if (StringUtils.isNotEmpty(requestedTenantId)) {
            // 验证请求的租户ID是否与用户所属租户一致
            if (!userTenantId.equals(requestedTenantId)) {
                throw new ServiceException("当前用户无权访问该租户，用户所属租户为：" + userTenantId);
            }
            // 验证租户是否存在且可用
            SysTenant tenant = tenantService.getById(requestedTenantId);
            if (tenant == null) {
                throw new ServiceException("租户不存在：" + requestedTenantId);
            }
            if (!STATUS_NORMAL.equals(tenant.getStatus())) {
                throw new ServiceException("租户已被停用：" + requestedTenantId);
            }
            if (!STATUS_NORMAL.equals(tenant.getDelFlag())) {
                throw new ServiceException("租户已被删除：" + requestedTenantId);
            }
            return buildTenantInfo(tenant);
        }
        
        // 如果用户没有请求租户ID，使用用户所属的租户
        SysTenant userTenant = tenantService.getById(userTenantId);
        if (userTenant != null && STATUS_NORMAL.equals(userTenant.getStatus()) && STATUS_NORMAL.equals(userTenant.getDelFlag())) {
            return buildTenantInfo(userTenant);
        }
        
        // 如果用户的租户不存在或已禁用，尝试使用默认租户
        if (!Constants.DEFAULT_TENANT_ID.equals(userTenantId)) {
            SysTenant defaultTenant = tenantService.getById(Constants.DEFAULT_TENANT_ID);
            if (defaultTenant != null && STATUS_NORMAL.equals(defaultTenant.getStatus()) && STATUS_NORMAL.equals(defaultTenant.getDelFlag())) {
                return buildTenantInfo(defaultTenant);
            }
        }
        
        // 如果默认租户也不可用，抛出异常
        throw new ServiceException("用户所属租户不可用，请联系管理员");
    }

    /**
     * 获取用户可用的租户列表
     * 现在用户直接通过sys_user.tenant_id关联租户，一个用户只能属于一个租户
     */
    private List<SysTenant> getAvailableTenants(Long userId) {
        SysUser user = userService.selectUserById(userId);
        if (user == null) {
            return Collections.emptyList();
        }
        String tenantId = user.getTenantId();
        if (StringUtils.isEmpty(tenantId)) {
            // 如果没有设置tenant_id，使用默认租户
            tenantId = Constants.DEFAULT_TENANT_ID;
        }
        SysTenant tenant = tenantService.getById(tenantId);
        if (tenant != null && STATUS_NORMAL.equals(tenant.getStatus()) && STATUS_NORMAL.equals(tenant.getDelFlag())) {
            return Collections.singletonList(tenant);
        }
        // 如果租户不存在或已禁用，返回默认租户
        SysTenant defaultTenant = tenantService.getById(Constants.DEFAULT_TENANT_ID);
        if (defaultTenant != null) {
            return Collections.singletonList(defaultTenant);
        }
        return Collections.emptyList();
    }

    private SysTenant findTenant(List<SysTenant> tenants, String tenantId) {
        if (CollectionUtils.isEmpty(tenants) || StringUtils.isEmpty(tenantId)) {
            return null;
        }
        return tenants.stream()
                .filter(tenant -> tenantId.equals(tenant.getTenantId()))
                .findFirst()
                .orElse(null);
    }

    /**
     * 更新最后登录租户
     * 现在用户直接通过sys_user.tenant_id关联租户，不需要额外记录
     * 如果用户的tenant_id与登录的tenant_id不一致，可以在这里更新（但通常不需要）
     */
    private void updateLastLoginTenant(SysUser user, String tenantId, boolean adminLogin) {
        // 用户已通过tenant_id直接关联租户，不需要额外记录最后登录租户
        // 如果未来需要记录最后登录租户，可以在这里添加逻辑
    }

    private TenantInfo buildTenantInfo(SysTenant tenant) {
        if (tenant == null) {
            return buildTenantInfo(Constants.DEFAULT_TENANT_ID);
        }
        return new TenantInfo(tenant.getTenantId(), tenant.getTenantName());
    }

    private TenantInfo buildTenantInfo(String tenantId) {
        String targetTenantId = StringUtils.isEmpty(tenantId) ? Constants.DEFAULT_TENANT_ID : tenantId;
        SysTenant tenant = tenantService.getById(targetTenantId);
        if (tenant != null) {
            return new TenantInfo(tenant.getTenantId(), tenant.getTenantName());
        }
        return new TenantInfo(targetTenantId, DEFAULT_TENANT_NAME);
    }

    private static class TenantInfo {
        private final String tenantId;
        private final String tenantName;

        TenantInfo(String tenantId, String tenantName) {
            this.tenantId = tenantId;
            this.tenantName = tenantName;
        }

        public String getTenantId() {
            return tenantId;
        }

        public String getTenantName() {
            return tenantName;
        }
    }
}
