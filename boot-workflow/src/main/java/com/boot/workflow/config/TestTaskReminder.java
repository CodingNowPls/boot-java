package com.boot.workflow.config;

import com.aizuda.bpm.engine.TaskReminder;
import com.aizuda.bpm.engine.core.FlowLongContext;
import com.aizuda.bpm.engine.entity.FlwTask;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * 注入自定义任务提醒处理类
 * 注解 EnableScheduling 必须启动
 */
@Slf4j
@Component
@EnableScheduling
public class TestTaskReminder implements TaskReminder {

    @Override
    public Date remind(FlowLongContext context, Long instanceId, FlwTask currentTask) {
        log.info("测试提醒：" + instanceId);
        return null;
    }
}
