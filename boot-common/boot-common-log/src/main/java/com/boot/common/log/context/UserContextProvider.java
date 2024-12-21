package com.boot.common.log.context;

/**
 * 提供用户上下文信息的接口
 * @author gao
 */
public interface UserContextProvider {
    /**
     * 获取当前登录用户名
     *
     * @return 当前登录用户名
     */
    String getCurrentUserName();
}
