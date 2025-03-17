package com.boot.demo.biz.service.impl;

import com.boot.common.mybatis.base.impl.SuperServiceImpl;
import com.boot.demo.biz.entity.Demo2;
import com.boot.demo.biz.mapper.Demo2Mapper;
import com.boot.demo.biz.service.Demo2Service;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class DemoServiceImpl extends SuperServiceImpl<Demo2Mapper, Demo2> implements Demo2Service {



}
