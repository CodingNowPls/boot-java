package com.boot.common.web.domain.server;

import com.boot.common.core.utils.Arith;
import com.boot.common.core.utils.DateUtils;
import lombok.Getter;
import lombok.Setter;

import java.lang.management.ManagementFactory;

/**
 * JVM相关信息
 *
 * @author boot
 */
public class Jvm {
    /**
     * 当前JVM占用的内存总数(M)
     */
    @Setter
    private double total;

    /**
     * JVM最大可用内存总数(M)
     */
    @Setter
    private double max;

    /**
     * JVM空闲内存(M)
     */
    @Setter
    private double free;

    /**
     * JDK版本
     */
    @Getter
    @Setter
    private String version;

    /**
     * JDK路径
     */
    @Setter
    private String home;

    public double getTotal() {
        return Arith.div(total, (1024 * 1024), 2);
    }

    public double getMax() {
        return Arith.div(max, (1024 * 1024), 2);
    }


    public double getFree() {
        return Arith.div(free, (1024 * 1024), 2);
    }


    public double getUsed() {
        return Arith.div(total - free, (1024 * 1024), 2);
    }

    public double getUsage() {
        return Arith.mul(Arith.div(total - free, total, 4), 100);
    }

    /**
     * 获取JDK名称
     */
    public String getName() {
        return ManagementFactory.getRuntimeMXBean().getVmName();
    }

    /**
     * JDK启动时间
     */
    public String getStartTime() {
        return DateUtils.parseDateToStr(DateUtils.YYYY_MM_DD_HH_MM_SS, DateUtils.getServerStartDate());
    }

    /**
     * JDK运行时间
     */
    public String getRunTime() {
        return DateUtils.timeDistance(DateUtils.getNowDate(), DateUtils.getServerStartDate());
    }

    /**
     * 运行参数
     */
    public String getInputArgs() {
        return ManagementFactory.getRuntimeMXBean().getInputArguments().toString();
    }
}