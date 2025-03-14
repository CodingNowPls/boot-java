package com.boot.workflow.config;

import com.aizuda.bpm.engine.core.FlowCreator;
import com.aizuda.bpm.engine.core.enums.TaskEventType;
import com.aizuda.bpm.engine.entity.FlwTask;
import com.aizuda.bpm.engine.listener.TaskListener;
import com.aizuda.bpm.engine.model.NodeModel;
import lombok.extern.slf4j.Slf4j;

import java.util.function.Supplier;

/**
 * 同步监听任务事件，需要注入该监听器有效
 * <p>
 * 不可以 EventTaskListener 同时使用，同时关闭 flowlong.eventing.task = true 配置
 * </p>
 */
@Slf4j
public class TestTaskListener implements TaskListener {

    @Override
    public boolean notify(TaskEventType eventType, Supplier<FlwTask> supplier, NodeModel nodeModel, FlowCreator flowCreator) {
        log.error("当前执行任务 = " + supplier.get().getTaskName() +
                " ，执行事件 = " + eventType.name() + "，创建人=" + flowCreator.getCreateBy());
        return true;
    }

}
