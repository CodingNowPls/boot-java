package com.boot.common.core.utils.ip;

import com.boot.common.core.utils.RegionUtil;
import com.boot.common.core.utils.StringUtils;
import com.boot.common.core.config.BootConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 获取地址类
 *
 * @author boot
 */
public class AddressUtils {
    // 未知地址
    public static final String UNKNOWN = "XX XX";
    private static final Logger log = LoggerFactory.getLogger(AddressUtils.class);

    public static String getRealAddressByIP(String ip) {
        String address = UNKNOWN;
        // 内网不查询
        if (IpUtils.internalIp(ip)) {
            return "内网IP";
        }
        if (BootConfig.isAddressEnabled()) {
            try {
                String rspStr = RegionUtil.getRegion(ip);
                if (StringUtils.isEmpty(rspStr)) {
                    log.error("获取地理位置异常 {}", ip);
                    return UNKNOWN;
                }
                String[] obj = rspStr.split("\\|");
                String region = obj[2];
                String city = obj[3];

                return String.format("%s %s", region, city);
            } catch (Exception e) {
                log.error("获取地理位置异常 {}", e);
            }
        }
        return address;
    }
}
