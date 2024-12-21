package com.boot.common.mybatis.handler;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.boot.common.security.core.domain.model.LoginUser;
import com.boot.common.security.utils.SecurityUtils;
import org.apache.ibatis.reflection.MetaObject;

import java.util.Date;

/**
 * mybatis-plus 自动填充字段
 *
 * @author theodo
 */
public class FieldMetaObjectHandler implements MetaObjectHandler {
    private final static String CREATE_TIME = "createTime";
    private final static String CREATE_BY = "createBy";
    private final static String UPDATE_TIME = "updateTime";
    private final static String UPDATE_BY = "updateBy";
    private final static String DEL_FLAG = "delFlag";

    @Override
    public void insertFill(MetaObject metaObject) {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        Date date = new Date();
        // 创建者
        strictInsertFill(metaObject, CREATE_BY, String.class, loginUser.getUserName());
        // 创建时间
        strictInsertFill(metaObject, CREATE_TIME, Date.class, date);
        // 更新者
        strictInsertFill(metaObject, UPDATE_BY, String.class, loginUser.getUserName());
        // 更新时间
        strictInsertFill(metaObject, UPDATE_TIME, Date.class, date);
        // 删除标识
        strictInsertFill(metaObject, DEL_FLAG, Integer.class, 0);
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        // 更新者
        strictUpdateFill(metaObject, UPDATE_BY, String.class, loginUser.getUserName());
        // 更新时间
        strictUpdateFill(metaObject, UPDATE_TIME, Date.class, new Date());
    }
}
