package com.boot.common.web.domain.server;

import com.boot.common.core.utils.Arith;
import lombok.Getter;
import lombok.Setter;

/**
 * CPU相关信息
 *
 * @author boot
 */
public class Cpu {
    /**
     * 核心数
     */
    @Getter
    @Setter
    private int cpuNum;

    /**
     * CPU总的使用率
     */
    @Setter
    private double total;

    /**
     * CPU系统使用率
     */
    @Setter
    private double sys;

    /**
     * CPU用户使用率
     */
    @Setter
    private double used;

    /**
     * CPU当前等待率
     */
    @Setter
    private double wait;

    /**
     * CPU当前空闲率
     */
    @Setter
    private double free;


    public double getTotal() {
        return Arith.round(Arith.mul(total, 100), 2);
    }



    public double getSys() {
        return Arith.round(Arith.mul(sys / total, 100), 2);
    }


    public double getUsed() {
        return Arith.round(Arith.mul(used / total, 100), 2);
    }



    public double getWait() {
        return Arith.round(Arith.mul(wait / total, 100), 2);
    }


    public double getFree() {
        return Arith.round(Arith.mul(free / total, 100), 2);
    }


}
