package com.boot.common.web.domain.server;

import com.boot.common.core.utils.Arith;
import lombok.Setter;

/**
 * 內存相关信息
 *
 * @author boot
 */
public class Mem {
    /**
     * 内存总量
     */
    @Setter
    private double total;

    /**
     * 已用内存
     */
    @Setter
    private double used;

    /**
     * 剩余内存
     */
    @Setter
    private double free;

    public double getTotal() {
        return Arith.div(total, (1024 * 1024 * 1024), 2);
    }



    public double getUsed() {
        return Arith.div(used, (1024 * 1024 * 1024), 2);
    }


    public double getFree() {
        return Arith.div(free, (1024 * 1024 * 1024), 2);
    }



    public double getUsage() {
        return Arith.mul(Arith.div(used, total, 4), 100);
    }
}
