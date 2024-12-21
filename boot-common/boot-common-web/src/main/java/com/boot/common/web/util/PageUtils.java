package com.boot.common.web.util;

import com.github.pagehelper.PageHelper;
import com.boot.common.mybatis.page.PageDomain;
import com.boot.common.mybatis.page.TableSupport;
import com.boot.common.core.utils.sql.SqlUtil;

/**
 * 分页工具类
 *
 * @author boot
 */
public class PageUtils extends PageHelper {
    /**
     * 设置请求分页数据
     */
    public static void startPage() {
        PageDomain pageDomain = TableSupport.buildPageRequest();
        Integer pageNum = pageDomain.getPageNum();
        Integer pageSize = pageDomain.getPageSize();
        String orderBy = SqlUtil.escapeOrderBySql(pageDomain.getOrderBy());
        Boolean reasonable = pageDomain.getReasonable();
        startPage(pageNum, pageSize, orderBy).setReasonable(reasonable);
    }

    /**
     * 清理分页的线程变量
     */
    public static void clearPage() {
        PageHelper.clearPage();
    }
}
