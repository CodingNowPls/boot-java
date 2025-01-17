package com.ruoyi.tenant;

import com.baomidou.mybatisplus.extension.plugins.handler.TenantLineHandler;
import com.boot.common.core.utils.StringUtils;
import com.boot.common.security.utils.SecurityUtils;
import lombok.AllArgsConstructor;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.StringValue;


@AllArgsConstructor
public class CommonTenantHandler implements TenantLineHandler {

    /**
     * 获取租户ID
     *
     * @return 租户ID
     */
    @Override
    public Expression getTenantId() {
        if (SecurityUtils.getLoginUser() != null) {
            String tenantId = SecurityUtils.getLoginUser().getTenantId();
            if (!StringUtils.isEmpty(tenantId)) {
                return new StringValue(tenantId);
            }
        }
        return new StringValue(TenantProperties.getInstance().getDefaultTenantId());
    }
    /**
     * 获取租户字段名称
     *
     * @return 租户字段名称
     */
    @Override
    public String getTenantIdColumn() {
        return TenantProperties.getInstance().getInstance().getColumn();
    }

    /**
     * 过滤租户表
     *
     * @param tableName 表名
     * @return 是否进行过滤 返回true 表示不进行多租户处理
     */
    @Override
    public boolean ignoreTable(String tableName) {
        if (!TenantProperties.getInstance().getEnable()){
            return true;
        }
        return TenantProperties.getInstance().getIgnoreTables().contains(tableName);
    }
}
