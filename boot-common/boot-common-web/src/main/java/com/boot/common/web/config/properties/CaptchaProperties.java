package com.boot.common.web.config.properties;

import com.boot.common.core.enums.CaptchaEnum;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 验证码配置
 *
 * @author theodo
 */
@Data
@Component
@ConfigurationProperties(prefix = "captcha")
public class CaptchaProperties {
    /**
     * 验证码配置
     */
    private CaptchaEnum codeType;
    /**
     * 验证码有效期 分钟
     */
    private Long expiration = 2L;
    /**
     * 验证码内容长度
     */
    private int length = 2;
    /**
     * 验证码宽度
     */
    private int width = 111;
    /**
     * 验证码高度
     */
    private int height = 36;
    /**
     * 验证码字体
     */
    private String fontName;
    /**
     * 字体大小
     */
    private int fontSize = 25;

    public CaptchaEnum getCodeType() {
        return codeType;
    }
}
