package com.boot.jimu.report;

import com.boot.common.core.utils.StringUtils;
import com.boot.common.core.utils.json.BootJsonUtil;
import com.boot.common.security.core.domain.model.LoginUser;
import com.boot.common.security.service.TokenService;
import com.boot.common.security.utils.SecurityUtils;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.jeecg.modules.jmreport.api.JmReportTokenServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.Objects;


@Component
@AllArgsConstructor
public class JimuReportTokenService implements JmReportTokenServiceI {

    @Autowired
    private TokenService tokenService;

    @Override
    public String getUsername(String token) {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        return loginUser.getUserName();
    }

    @Override
    public Boolean verifyToken(String token) {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (StringUtils.isNotNull(loginUser)) {
            tokenService.verifyToken(loginUser);
            return true;
        }
        return false;
    }

    @Override
    public String getToken(HttpServletRequest request) {
        return SecurityUtils.getLoginUser().getToken();
    }

    @Override
    public Map<String, Object> getUserInfo(String token) {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (Objects.isNull(loginUser)) {
            return null;
        }
        return BootJsonUtil.toMap(loginUser);
    }
    //drag:datasource:testConnection	仪表盘数据库连接测试
    //onl:drag:clear:recovery	仪表盘清空回收站
    //drag:analysis:sql	仪表盘SQL解析
    //drag:design:getTotalData	仪表盘对Online表单展示数据
    //onl:drag:page:delete 仪表盘数据删除

    @Override
    public String[] getRoles(String token) {
        return new String[]{"admin", "lowdeveloper", "dbadeveloper"};
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