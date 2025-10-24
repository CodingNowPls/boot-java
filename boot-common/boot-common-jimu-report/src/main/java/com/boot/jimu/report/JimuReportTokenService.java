package com.boot.jimu.report;

import cn.dev33.satoken.exception.NotLoginException;
import com.boot.common.core.domain.entity.SysRole;
import com.boot.common.core.utils.json.BootJsonUtil;
import com.boot.common.security.core.domain.model.LoginUser;
import com.boot.common.security.service.TokenService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.jeecg.modules.jmreport.api.JmReportTokenServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;
import java.util.Objects;


@Component
@AllArgsConstructor
public class JimuReportTokenService implements JmReportTokenServiceI {

    @Autowired
    private TokenService tokenService;
    @Override
    public String getUsername(String token) {
        try {
            LoginUser loginUser = tokenService.getLoginUserFromToken(token);
            if (Objects.isNull(loginUser)){
                return null;
            }
            return loginUser.getUserName();
        } catch (Exception e) {
            throw new NotLoginException(NotLoginException.TOKEN_TIMEOUT_MESSAGE, "", NotLoginException.TOKEN_TIMEOUT);
        }
    }

    @Override
    public Boolean verifyToken(String token) {
        try {
            tokenService.verifyToken(token);
            return true;
        } catch (Exception e) {
            throw new NotLoginException(NotLoginException.TOKEN_TIMEOUT_MESSAGE, "", NotLoginException.TOKEN_TIMEOUT);
        }
    }

    @Override
    public String getToken(HttpServletRequest request) {
        try {
            String token = tokenService.getToken(request);
            return token;
        } catch (Exception e) {
           e.printStackTrace();
        }
        throw new NotLoginException(NotLoginException.TOKEN_TIMEOUT_MESSAGE, "", NotLoginException.TOKEN_TIMEOUT);
    }

    @Override
    public Map<String, Object> getUserInfo(String token) {
        LoginUser loginUser = tokenService.getLoginUserFromToken(token);
        if (Objects.isNull(loginUser)) {
            return null;
        }
        return BootJsonUtil.toMap(loginUser);
    }


    @Override
    public String[] getRoles(String token) {
        //后期要设置角色 https://help.jimureport.com/prodSafe
        //拥有角色admin、dbadeveloper 、lowdeveloper 用户可以访问敏感接口。 拥有角色admin、lowdeveloper 用户在关闭在线报表设计情况下，也可以设计报表
        //admin	超级管理员	拥有最高权限
        //dbadeveloper	DB管理员	可以设置数据库连接
        //lowdeveloper	报表设计管理员	可以设计报表
        LoginUser loginUser = tokenService.getLoginUserFromToken(token);
        if (Objects.isNull(loginUser)) {
            return new String[]{};
        }
        List<SysRole> roles = loginUser.getUser().getRoles();
        String[] userRoles = new String[roles.size()];
        for (SysRole role : roles) {
            userRoles[roles.indexOf(role)] = role.getRoleKey();
        }
        //new String[]{"admin", "lowdeveloper", "dbadeveloper"}
        return userRoles;
    }

    @Override
    public String[] getPermissions(String token) {
        //drag:datasource:testConnection	仪表盘数据库连接测试
        //onl:drag:clear:recovery	仪表盘清空回收站
        //drag:analysis:sql	仪表盘SQL解析
        //drag:design:getTotalData	仪表盘对Online表单展示数据
        //onl:drag:page:delete 仪表盘数据删除
        return new String[]{"drag:datasource:testConnection", "onl:drag:clear:recovery", "drag:analysis:sql", "drag:design:getTotalData", "onl:drag:page:delete"};
    }
}