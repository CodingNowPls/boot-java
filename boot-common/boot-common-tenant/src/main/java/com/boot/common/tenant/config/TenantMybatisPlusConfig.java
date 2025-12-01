package com.boot.common.tenant.config;

import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.handler.TenantLineHandler;
import com.baomidou.mybatisplus.extension.plugins.inner.InnerInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.TenantLineInnerInterceptor;
import com.boot.common.core.utils.StringUtils;
import com.boot.common.security.utils.SecurityUtils;

import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.NullValue;
import net.sf.jsqlparser.expression.StringValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Configuration;

import java.util.List;
import java.util.Objects;

@Slf4j
@Configuration
@ConditionalOnProperty(prefix = "tenant", name = "enable", havingValue = "true")
public class TenantMybatisPlusConfig {

    @Autowired
    private TenantProperties tenantProperties;
    
    @Autowired
    private MybatisPlusInterceptor mybatisPlusInterceptor;

    /**
     * 初始化租户拦截器
     */
    @PostConstruct
    public void init() {
        //多租户插件
        if (tenantProperties.getEnable()) {
            TenantLineInnerInterceptor tenantLineInnerInterceptor = new TenantLineInnerInterceptor(new TenantLineHandler() {
                /**
                 * 获取租户ID
                 *
                 * @return
                 */
                @Override
                public Expression getTenantId() {
                    //从登录信息中获取当前租户ID
                    String tenantId = SecurityUtils.getCurrentTenantId();
                    if (StringUtils.isEmpty(tenantId)) {
                        return new NullValue();
                    }
                    return new StringValue(tenantId);
                }

                /**
                 * 获取租户字段的名称
                 *
                 * @return
                 */
                @Override
                public String getTenantIdColumn() {
                    return tenantProperties.getColumn();
                }

                /**
                 * 哪些表忽略租户
                 *
                 * @param tableName 表名
                 * @return true忽略，false开启
                 */
                @Override
                public boolean ignoreTable(String tableName) {
                    List<String> excludeTables = tenantProperties.getExcludes();
                    if (excludeTables != null && !excludeTables.isEmpty() && excludeTables.contains(tableName)) {
                        return true;
                    }
                    return false;
                }
            });
            // 确保租户拦截器在所有拦截器的最前面
            MybatisPlusInterceptor newInterceptor = new MybatisPlusInterceptor();
            newInterceptor.addInnerInterceptor(tenantLineInnerInterceptor);
            List<InnerInterceptor> existingInterceptors = mybatisPlusInterceptor.getInterceptors();
            for (InnerInterceptor innerInterceptor : existingInterceptors) {
                newInterceptor.addInnerInterceptor(innerInterceptor);
            }
            // 使用反射替换原有的拦截器列表
            java.lang.reflect.Field interceptorsField = null;
            try {
                interceptorsField = MybatisPlusInterceptor.class.getDeclaredField("interceptors");
                interceptorsField.setAccessible(true);
                interceptorsField.set(mybatisPlusInterceptor, newInterceptor.getInterceptors());
            } catch (Exception e) {
                log.error("替换拦截器列表失败", e);
            }finally {
                if (Objects.nonNull(interceptorsField)) {
                    try {
                        interceptorsField.setAccessible(false);
                    } catch (Exception e) {
                        log.error("重置拦截器列表失败", e);
                    }
                }
            }
        }
    }

}
