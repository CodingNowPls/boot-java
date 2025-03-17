package com.boot.common.web.controller;

import com.boot.common.mybatis.base.SuperService;
import jakarta.annotation.Resource;

public abstract class SuperController<S extends SuperService<Entity>, Entity> extends BaseController {

    @Resource
    protected S baseService;


}
