package com.boot.admin.controller;

import com.boot.common.core.config.BootConfig;
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



    @GetMapping(value = {"/"})
    public String index() {
        return "index.html";
    }
}
