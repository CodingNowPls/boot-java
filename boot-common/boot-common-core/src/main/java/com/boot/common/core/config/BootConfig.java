package com.boot.common.core.config;

import com.boot.common.core.enums.EnumCacheType;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 读取项目相关配置
 *
 * @author boot
 */
@Data
@Component
@ConfigurationProperties(prefix = "boot")
public class BootConfig {
    /**
     * 上传路径
     */
    private static String profile;
    /**
     * 获取地址开关
     */
    private static boolean addressEnabled;
    /**
     * 验证码类型
     */
    private static String captchaType;
    /**
     * 项目名称
     */
    private String name;
    /**
     * 版本
     */
    private String version;
    /**
     * 版权年份
     */
    private String copyrightYear;
    /**
     * 实例演示开关
     */
    private boolean demoEnabled;
    /**
     * 前后端是否是一体化，true是一体，false是前后端分离
     */
    private static boolean frontCoupled;

    /**
     * 缓存类型
     */
    private String cacheType = EnumCacheType.CACHE_TYPE_LOCAL;



    public static String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        BootConfig.profile = profile;
    }

    public static boolean isAddressEnabled() {
        return addressEnabled;
    }

    public void setAddressEnabled(boolean addressEnabled) {
        BootConfig.addressEnabled = addressEnabled;
    }

    public static String getCaptchaType() {
        return captchaType;
    }

    public void setCaptchaType(String captchaType) {
        BootConfig.captchaType = captchaType;
    }


    public static boolean isFrontCoupled() {
        return frontCoupled;
    }

    public void setFrontCoupled(boolean frontCoupled) {
        BootConfig.frontCoupled = frontCoupled;
    }
    /**
     * 获取导入上传路径
     */
    public static String getImportPath() {
        return getProfile() + "/import";
    }

    /**
     * 获取头像上传路径
     */
    public static String getAvatarPath() {
        return getProfile() + "/avatar";
    }

    /**
     * 获取下载路径
     */
    public static String getDownloadPath() {
        return getProfile() + "/download/";
    }

    /**
     * 获取上传路径
     */
    public static String getUploadPath() {
        return getProfile() + "/upload";
    }

}
