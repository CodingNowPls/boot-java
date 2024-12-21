package com.boot.demo.demo1.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.PostConstruct;

/**
 * @author : gao
 * @date 2024年12月12日
 * -------------------------------------------<br>
 * <br>
 * <br>
 */
@RestController
@RequestMapping("/demo")
public class DemoController {

    @PostConstruct
    public void init() {
        System.out.println("DemoController init");
    }

    @SaIgnore
    @GetMapping("/test")
    public String test() {
        return "OK";
    }

}
