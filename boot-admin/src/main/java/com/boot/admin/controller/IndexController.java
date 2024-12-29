package com.boot.admin.controller;

import com.boot.common.core.config.BootConfig;
import com.github.yulichang.base.MPJBaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * 首页
 *
 * @author boot
 */
@Controller
public class IndexController {
    /**
     * 系统基础配置
     */
    @Autowired
    private BootConfig bootConfig;

    @Autowired
    private com.github.yulichang.base.MPJBaseServiceImpl MPJBaseServiceImpl;

    /**
     * 测试index
     * @return
     */
    @GetMapping(value = {"/"})
    public String index() {
        return "index.html";
    }
}
