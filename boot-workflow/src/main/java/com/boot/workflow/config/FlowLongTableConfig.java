package com.boot.workflow.config;

import com.aizuda.bpm.engine.entity.*;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.*;

@Slf4j
@Configuration
public class FlowLongTableConfig {


    @Autowired
    private MybatisPlusInterceptor mybatisPlusInterceptor;


    @Bean
    public FlowLongTableInterceptor flowLongTableInterceptor() {
        // 添加自定义拦截器，并指定需要拦截的表
        log.info("添加自定义拦截器拦截workflow的表");
        Map<String, Class> tablesHashMap = new HashMap<>();
        tablesHashMap.put("flw_ext_instance", FlwExtInstance.class);
        tablesHashMap.put("flw_his_instance", FlwHisInstance.class);
        tablesHashMap.put("flw_his_task", FlwHisTask.class);
        tablesHashMap.put("flw_his_task_actor", FlwHisTaskActor.class);
        tablesHashMap.put("flw_instance", FlwInstance.class);
        tablesHashMap.put("flw_process", FlwProcess.class);
        tablesHashMap.put("flw_task", FlwTask.class);
        tablesHashMap.put("flw_task_actor", FlwTaskActor.class);


        FlowLongTableInterceptor flowLongTableInterceptor = new FlowLongTableInterceptor(tablesHashMap);
        mybatisPlusInterceptor.addInnerInterceptor(flowLongTableInterceptor);
        return flowLongTableInterceptor;
    }
}
