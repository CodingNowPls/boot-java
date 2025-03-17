package com.boot.demo.biz.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import com.boot.common.web.controller.SuperController;
import com.boot.demo.biz.entity.Demo2;
import com.boot.demo.biz.service.Demo2Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/demo2")
public class Demo2Controller extends SuperController<Demo2Service, Demo2> {

    @RequestMapping("/test")
    @SaIgnore
    public Object test() {
        Demo2 demo2 = new Demo2();
        demo2.setName("测试" + System.currentTimeMillis());
        baseService.save(demo2);
        return demo2;
    }

}
