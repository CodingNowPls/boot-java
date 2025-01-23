package com.boot.admin.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * 首页
 *
 * @author boot
 */
@Controller
public class IndexController {

    @GetMapping(value = {"/", "/index.html"})
    public String index() {
        return "index.html";
    }
}
