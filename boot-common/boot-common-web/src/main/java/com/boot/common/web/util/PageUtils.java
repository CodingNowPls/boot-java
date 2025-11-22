package com.boot.common.web.util;

import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.boot.common.core.utils.StringUtils;
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

    public static  <T> Page<T> startMpPage(T t) {
        Page<T> page = new Page<>();
        PageDomain pageDomain = TableSupport.buildPageRequest();
        Integer pageNum = pageDomain.getPageNum();
        Integer pageSize = pageDomain.getPageSize();
        if (pageNum == null){
            pageNum = 1;
        }
        if (pageSize == null){
            pageSize = 10;
        }
        String orderBy = SqlUtil.escapeOrderBySql(pageDomain.getOrderBy());
        if (StringUtils.isNotEmpty(orderBy)){
            String[] split = orderBy.split(" ");
            if (split.length == 2 && split[1].equals("asc")){
                OrderItem asc = OrderItem.asc(split[0]);
                page.addOrder(asc);
            }
            if (split.length == 2 && split[1].equals("desc")){
                OrderItem asc = OrderItem.desc(split[0]);
                page.addOrder(asc);
            }
        }
        page.setCurrent(pageNum);
        page.setSize(pageSize);
        return page;
    }
    /**
     * 清理分页的线程变量
     */
    public static void clearPage() {
        PageHelper.clearPage();
    }
}
