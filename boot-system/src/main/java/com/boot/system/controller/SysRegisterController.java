package com.boot.system.controller;

import com.boot.common.web.controller.BaseController;
import com.boot.common.core.domain.AjaxResult;
import com.boot.common.core.domain.model.RegisterBody;
import com.boot.common.core.utils.StringUtils;
import com.boot.system.service.ISysConfigService;
import com.boot.system.service.SysRegisterServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

/**
 * 注册验证
 *
 * @author boot
 */
@RestController
public class SysRegisterController extends BaseController {
    @Autowired
    private SysRegisterServiceImpl registerService;

    @Autowired
    private ISysConfigService configService;

    @PostMapping("/register")
    public AjaxResult register(@RequestBody RegisterBody user) {
        if (!("true".equals(configService.selectConfigByKey("sys.account.registerUser")))) {
            return error("当前系统没有开启注册功能！");
        }
        String msg = registerService.register(user);
        return StringUtils.isEmpty(msg) ? success() : error(msg);
    }
}
