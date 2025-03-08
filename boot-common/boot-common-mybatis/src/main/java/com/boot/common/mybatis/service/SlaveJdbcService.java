package com.boot.common.mybatis.service;


import com.baomidou.dynamic.datasource.annotation.DS;
import com.boot.common.core.utils.spring.SpringUtils;
import com.boot.common.mybatis.enums.DataSourceType;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 * 使用的时候只需要继承 SlaveJdbcService即可，会自动切换到从库
 */

@DS(DataSourceType.slaveDsName)
public interface SlaveJdbcService {
    default JdbcTemplate getJdbcTemplate() {
        return SpringUtils.getBean(JdbcTemplate.class);
    }
}
