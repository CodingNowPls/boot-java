package com.boot.workflow.config;

import com.baomidou.mybatisplus.core.metadata.TableInfo;
import com.baomidou.mybatisplus.core.metadata.TableInfoHelper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.baomidou.mybatisplus.extension.plugins.inner.InnerInterceptor;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Signature;

import java.lang.reflect.Field;
import java.sql.SQLException;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.Executor;

/**
 * FlowLongTable表主键赋值拦截器
 */
@Intercepts({
        @Signature(type = Executor.class, method = "update", args = {MappedStatement.class, Object.class})
})
public class FlowLongTableInterceptor implements InnerInterceptor {

    private Map<String, Class> targetTablesMap;

    public FlowLongTableInterceptor(Map<String, Class> targetTablesMap) {
        this.targetTablesMap = targetTablesMap;
    }

    @Override
    public void beforeUpdate(org.apache.ibatis.executor.Executor executor, MappedStatement ms, Object parameter) throws SQLException {
        // 只处理 INSERT 操作
        if (SqlCommandType.INSERT != ms.getSqlCommandType()) {
            return;
        }
        if (CollectionUtils.isEmpty(targetTablesMap)) {
            return;
        }

        // 获取当前操作的表名
        TableInfo tableInfo = TableInfoHelper.getTableInfo(parameter.getClass());
        if (Objects.nonNull(tableInfo)) {
            String tableName = tableInfo.getTableName();
            // 判断是否需要拦截
            if (targetTablesMap.containsKey(tableName)) {
                Class<?> tableEntityClazz = targetTablesMap.get(tableName);
                // 确保 parameter 是目标实体类对象
                if (tableEntityClazz.isInstance(parameter)) {
                    // 获取主键字段名
                    String keyProperty = tableInfo.getKeyProperty();
                    // 递归查找字段（包括父类）
                    Field idField = findField(tableEntityClazz, keyProperty);
                    if (idField != null) {
                        try {
                            idField.setAccessible(true);
                            if (idField.get(parameter) == null) {
                                idField.set(parameter, generateId());
                            }
                        } catch (IllegalAccessException e) {
                            throw new SQLException("设置table的ID出错: " + tableName, e);
                        } finally {
                            idField.setAccessible(false);
                        }
                    } else {
                        throw new SQLException("字段 '" + keyProperty + "' 未找到: " + tableEntityClazz.getName());
                    }
                }
            }
        }
    }


    /**
     * 递归查找字段（包括父类）
     */
    private Field findField(Class<?> clazz, String fieldName) {
        try {
            return clazz.getDeclaredField(fieldName);
        } catch (NoSuchFieldException e) {
            // 如果当前类没有该字段，尝试从父类中查找
            Class<?> superClass = clazz.getSuperclass();
            if (superClass != null && superClass != Object.class) {
                return findField(superClass, fieldName);
            }
            return null;
        }
    }


    private Long generateId() {
        return IdWorker.getId();
    }
}