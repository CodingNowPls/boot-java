package com.boot.common.security.service;

import com.boot.common.core.domain.model.RegisterBody;

public interface SysRegisterService {


    /**
     * 注册
     */
    String register(RegisterBody registerBody);

    /**
     * 校验验证码
     *
     * @param username 用户名
     * @param code     验证码
     * @param uuid     唯一标识
     * @return 结果
     */
    void validateCaptcha(String username, String code, String uuid);
}
