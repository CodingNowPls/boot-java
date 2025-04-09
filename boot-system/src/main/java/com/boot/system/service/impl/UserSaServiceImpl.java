package com.boot.system.service.impl;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.plugins.IgnoreStrategy;
import com.baomidou.mybatisplus.core.plugins.InterceptorIgnoreHelper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.boot.common.core.constant.Constants;
import com.boot.common.core.domain.entity.SysUser;
import com.boot.common.core.enums.EnumYesNo;
import com.boot.common.core.enums.LoginUserType;
import com.boot.common.core.exception.ServiceException;
import com.boot.common.security.core.domain.model.LoginUser;
import com.boot.system.domain.SysTenant;
import com.boot.system.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;


/**
 * @author gao
 */
@Service
public class UserSaServiceImpl {
    private static final Logger log = LoggerFactory.getLogger(UserSaServiceImpl.class);

    @Autowired
    private ISysUserService userService;

    @Autowired
    private SysPermissionServiceImpl permissionService;

    @Autowired
    private SysPasswordServiceImpl passwordService;


    @Autowired
    private ISysTenantService systemTenantService;

    @Autowired
    private IMpSysUserService mpSysUserService;


    /**
     *  查询用户
     * @param username
     * @param password
     * @param tenantId
     * @param isAdminLogin
     * @return
     */
    public LoginUser loadUserName(String username, String password,Long tenantId,Integer isAdminLogin) {
        try {
            //此时还没有租户，所以全部关闭租户功能
            InterceptorIgnoreHelper.handle(IgnoreStrategy.builder().tenantLine(true).build());
            //区分管理登录和业务登录
            Boolean isAdminLoginFlag = (isAdminLogin != null && EnumYesNo.YES.getCode() == isAdminLogin);
            if (isAdminLoginFlag) {
                //后台管理登录时，默认为0
                tenantId = Constants.ADMIN_DEFAULT_TENANT_ID;
            }

            SysUser user = userService.selectUserByUserNameAndTenantId(username, tenantId);
            passwordService.validate(user, username, password);
            if (isAdminLoginFlag) {
                //如果是管理后台登录，额外判定
                if (EnumYesNo.NO.equals(user.getIsSys())) {
                    log.info("登录用户：{} 非管理用户.", username);
                    throw new ServiceException("对不起，您的账号：" + username + " 并非管理账号");
                }
            }
//            else {
//                //判定是否存在租户，且设置默认租户
//                LambdaQueryWrapper<SysTenant> lqw = Wrappers.lambdaQuery(SysTenant.class);
//                lqw.eq(SysTenant::getTenantId,tenantId);
//                // 状态为启用
//                lqw.eq(SysTenant::getStatus,EnumYesNo.YES.getCode());
//                SysTenant sysTenant = systemTenantService.getOne(lqw);
//                if (sysTenant == null ) {
//                    log.error("登录用户：{} 无归属租户.", username);
//                    throw new ServiceException("对不起，您的账号：" + username + " 无归属租户");
//                }
//            }
            //组装部门、角色等信息，管理和业务端也是不一样的
//            user = userService.getLatestUser(user, isAdminLogin, user.getUserId(), tenantId);
            //返回
            return new LoginUser(user, isAdminLogin, permissionService.getMenuPermission(user));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //恢复租户功能
            InterceptorIgnoreHelper.clearIgnoreStrategy();
        }
        return null;
    }
    private LoginUser createLoginUser(SysUser user) {
        return new LoginUser(user, permissionService.getMenuPermission(user));
    }
}
