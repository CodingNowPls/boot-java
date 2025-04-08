package com.boot.system.controller;

import com.boot.common.mybatis.page.TableDataInfo;
import com.boot.common.web.controller.BaseController;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("/system/tenant")
public class SysTenantController  extends BaseController {

    @GetMapping("/list")
    public TableDataInfo list() throws Exception {
        List<Map> list = new ArrayList<>();
        Map<String,Object> map = new HashMap<>();
        map.put("tenantId","1");
        map.put("tenantName","测试租户1");
        list.add(map);
        return getDataTable(list);
     }


}
