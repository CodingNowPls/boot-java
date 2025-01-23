package com.boot.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.boot.common.web.controller.BaseController;
import com.boot.common.core.domain.AjaxResult;
import com.boot.common.core.domain.entity.SysOperLog;
import com.boot.common.mybatis.page.TableDataInfo;
import com.boot.common.core.enums.BusinessType;
import com.boot.common.log.annotation.Log;
import com.boot.common.core.utils.poi.ExcelUtil;
import com.boot.system.service.ISysOperLogService;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 操作日志记录
 *
 * @author boot
 */
@RestController
@RequestMapping("/monitor/operlog")
public class SysOperlogController extends BaseController {
    @Autowired
    private ISysOperLogService operLogService;

    @SaCheckPermission("monitor:operlog:list")
    @GetMapping("/list")
    public TableDataInfo list(SysOperLog operLog) {
        startPage();
        List<SysOperLog> list = operLogService.selectOperLogList(operLog);
        return getDataTable(list);
    }

    @Log(title = "操作日志", businessType = BusinessType.EXPORT)
    @SaCheckPermission("monitor:operlog:export")
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysOperLog operLog) {
        List<SysOperLog> list = operLogService.selectOperLogList(operLog);
        ExcelUtil<SysOperLog> util = new ExcelUtil<SysOperLog>(SysOperLog.class);
        util.exportExcel(response, list, "操作日志");
    }

    @Log(title = "操作日志", businessType = BusinessType.DELETE)
    @SaCheckPermission("monitor:operlog:remove")
    @DeleteMapping("/{operIds}")
    public AjaxResult remove(@PathVariable Long[] operIds) {
        return toAjax(operLogService.deleteOperLogByIds(operIds));
    }

    @Log(title = "操作日志", businessType = BusinessType.CLEAN)
    @SaCheckPermission("monitor:operlog:remove")
    @DeleteMapping("/clean")
    public AjaxResult clean() {
        operLogService.cleanOperLog();
        return success();
    }
}
