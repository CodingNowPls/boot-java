package com.boot.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.boot.common.web.controller.BaseController;
import com.boot.common.core.domain.AjaxResult;
import com.boot.common.core.domain.entity.SysLogininfor;
import com.boot.common.mybatis.page.TableDataInfo;
import com.boot.common.core.enums.BusinessType;
import com.boot.common.log.annotation.Log;
import com.boot.common.core.utils.poi.ExcelUtil;
import com.boot.system.service.ISysLogininforService;
import com.boot.system.service.SysPasswordService;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 系统访问记录
 *
 * @author boot
 */
@RestController
@RequestMapping("/monitor/logininfor")
public class SysLogininforController extends BaseController {
    @Autowired
    private ISysLogininforService logininforService;

    @Autowired
    private SysPasswordService passwordService;

    @SaCheckPermission("monitor:logininfor:list")
    @GetMapping("/list")
    public TableDataInfo list(SysLogininfor logininfor) {
        startPage();
        List<SysLogininfor> list = logininforService.selectLogininforList(logininfor);
        return getDataTable(list);
    }

    @Log(title = "登录日志", businessType = BusinessType.EXPORT)
    @SaCheckPermission("monitor:logininfor:export")
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysLogininfor logininfor) {
        List<SysLogininfor> list = logininforService.selectLogininforList(logininfor);
        ExcelUtil<SysLogininfor> util = new ExcelUtil<SysLogininfor>(SysLogininfor.class);
        util.exportExcel(response, list, "登录日志");
    }

    @SaCheckPermission("monitor:logininfor:remove")
    @Log(title = "登录日志", businessType = BusinessType.DELETE)
    @DeleteMapping("/{infoIds}")
    public AjaxResult remove(@PathVariable Long[] infoIds) {
        return toAjax(logininforService.deleteLogininforByIds(infoIds));
    }

    @SaCheckPermission("monitor:logininfor:remove")
    @Log(title = "登录日志", businessType = BusinessType.CLEAN)
    @DeleteMapping("/clean")
    public AjaxResult clean() {
        logininforService.cleanLogininfor();
        return success();
    }

    @SaCheckPermission("monitor:logininfor:unlock")
    @Log(title = "账户解锁", businessType = BusinessType.OTHER)
    @GetMapping("/unlock/{userName}")
    public AjaxResult unlock(@PathVariable("userName") String userName) {
        passwordService.clearLoginRecordCache(userName);
        return success();
    }
}
