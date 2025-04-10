package com.boot.system.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.boot.common.core.utils.sql.SqlUtil;
import com.boot.common.mybatis.page.PageDomain;
import com.boot.common.mybatis.page.TableDataInfo;
import com.boot.common.web.controller.BaseController;
import com.boot.system.domain.SysTenant;
import com.boot.system.service.ISysTenantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("/system/tenant")
public class SysTenantController extends BaseController {

    @Autowired
    private ISysTenantService sysTenantService;

    @GetMapping("/list")
    public TableDataInfo list(SysTenant sysTenant) throws Exception {
        IPage<SysTenant> page = new Page<>();
        PageDomain pageDomain = SysTenant.getPageDomain();
        Integer pageNum = pageDomain.getPageNum();
        Integer pageSize = pageDomain.getPageSize();
//        String orderBy = SqlUtil.escapeOrderBySql(pageDomain.getOrderBy());
//        Boolean reasonable = pageDomain.getReasonable();

        page.setSize(pageSize);
        page.setCurrent(pageNum);

        List<SysTenant> list = sysTenantService.list(page);


//        List<Map> list = new ArrayList<>();
//        Map<String,Object> map = new HashMap<>();
//        map.put("tenantId","1");
//        map.put("tenantCode","0");
//        map.put("tenantName","默认租户");
//        map.put("status","0");
//        map.put("contactName","张三");
//        map.put("contactPhone","1300000000");
//        list.add(map);
        return getDataTable(list);
    }


}
