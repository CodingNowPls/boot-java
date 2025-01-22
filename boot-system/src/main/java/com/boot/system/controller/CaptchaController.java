package com.boot.system.controller;

import com.boot.common.core.cache.BootCache;
import com.boot.common.core.constant.CacheConstants;
import com.boot.common.core.domain.AjaxResult;

import com.boot.common.core.enums.CaptchaEnum;
import com.boot.common.core.exception.ServiceException;
import com.boot.common.core.utils.StringUtils;
import com.boot.common.core.utils.uuid.IdUtils;
import com.boot.common.web.config.properties.CaptchaProperties;
import com.boot.system.service.ISysConfigService;
import com.wf.captcha.*;
import com.wf.captcha.base.Captcha;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.IOException;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

/**
 * 验证码操作处理
 *
 * @author boot
 */
@Api(value = "用户登录认证", tags = {"用户登录认证"})
@RestController
public class CaptchaController {
    @Autowired
    private CaptchaProperties captchaProperties;

    @Autowired
    private BootCache bootCache;

    @Autowired
    private ISysConfigService configService;

    /**
     * 生成验证码
     */
    @ApiOperation("获取验证码")
    @GetMapping("/captchaImage")
    public AjaxResult getCode(HttpServletResponse response) throws IOException {
        AjaxResult ajax = AjaxResult.success();

        // 检测配置表是否开启验证码
        boolean captchaEnabled = configService.selectCaptchaEnabled();
        ajax.put("captchaEnabled", captchaEnabled);
        if (!captchaEnabled) {
            return ajax;
        }

        // 保存验证码信息
        String uuid = IdUtils.simpleUUID();
        String verifyKey = CacheConstants.CAPTCHA_CODE_KEY + uuid;
        // 获取运算的结果
        Captcha captcha = this.getCaptcha();
        // 当验证码类型为 arithmetic时且长度 >= 2 时，captcha.text()的结果有几率为浮点型
        String captchaValue = captcha.text();
        if (captcha.getCharType() - 1 == CaptchaEnum.arithmetic.ordinal() && captchaValue.contains(".")) {
            captchaValue = captchaValue.split("\\.")[0];
        }
        // 保存
        bootCache.setCacheObject(verifyKey, captchaValue,
                captchaProperties.getExpiration().intValue(), TimeUnit.MINUTES);

        // 返回
        ajax.put("uuid", uuid);
        ajax.put("img", captcha.toBase64());
        ajax.put("captchaCode", captchaValue);
        return ajax;
    }

    /**
     * 获取验证码生产类
     *
     * @return /
     */
    public Captcha getCaptcha() {
        if (Objects.isNull(captchaProperties)) {
            captchaProperties = new CaptchaProperties();
            if (Objects.isNull(captchaProperties.getCodeType())) {
                captchaProperties.setCodeType(CaptchaEnum.arithmetic);
            }
        }
        return switchCaptcha(captchaProperties);
    }

    /**
     * 依据配置信息生产验证码
     *
     * @param captchaProperties 验证码配置信息
     * @return /
     */
    private Captcha switchCaptcha(CaptchaProperties captchaProperties) {
        Captcha captcha;
        synchronized (this) {
            switch (captchaProperties.getCodeType()) {
                case arithmetic:
                    // 算术类型 https://gitee.com/whvse/EasyCaptcha
                    captcha = new FixedArithmeticCaptcha(captchaProperties.getWidth(), captchaProperties.getHeight());
                    // 几位数运算，默认是两位
                    captcha.setLen(captchaProperties.getLength());
                    break;
                case chinese:
                    captcha = new ChineseCaptcha(captchaProperties.getWidth(), captchaProperties.getHeight());
                    captcha.setLen(captchaProperties.getLength());
                    break;
                case chinese_gif:
                    captcha = new ChineseGifCaptcha(captchaProperties.getWidth(), captchaProperties.getHeight());
                    captcha.setLen(captchaProperties.getLength());
                    break;
                case gif:
                    captcha = new GifCaptcha(captchaProperties.getWidth(), captchaProperties.getHeight());
                    captcha.setLen(captchaProperties.getLength());
                    break;
                case spec:
                    captcha = new SpecCaptcha(captchaProperties.getWidth(), captchaProperties.getHeight());
                    captcha.setLen(captchaProperties.getLength());
                    break;
                default:
                    throw new ServiceException("验证码配置信息错误！正确配置查看 LoginCodeEnum ");
            }
        }
        if (StringUtils.isNotBlank(captchaProperties.getFontName())) {
            captcha.setFont(new Font(captchaProperties.getFontName(), Font.PLAIN, captchaProperties.getFontSize()));
        }
        return captcha;
    }

    static class FixedArithmeticCaptcha extends ArithmeticCaptcha {
        public FixedArithmeticCaptcha(int width, int height) {
            super(width, height);
        }

        @Override
        protected char[] alphas() {
            // 生成随机数字和运算符
            int n1 = num(1, 10), n2 = num(1, 10);
            int opt = num(3);

            // 计算结果
            int res = new int[]{n1 + n2, n1 - n2, n1 * n2}[opt];
            // 转换为字符运算符
            char optChar = "+-x".charAt(opt);

            this.setArithmeticString(String.format("%s%c%s=?", n1, optChar, n2));
            this.chars = String.valueOf(res);

            return chars.toCharArray();
        }
    }

}
