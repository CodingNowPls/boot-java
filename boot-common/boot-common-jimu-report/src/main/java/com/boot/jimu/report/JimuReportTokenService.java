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
}