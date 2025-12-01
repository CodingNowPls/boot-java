package com.boot.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.boot.common.core.domain.AjaxResult;
import com.boot.common.core.utils.StringUtils;
import com.boot.common.core.enums.BusinessType;
import com.boot.common.log.annotation.Log;
import com.boot.common.web.controller.BaseController;
import com.boot.system.domain.SysUserTenant;
import com.boot.system.service.ISysUserTenantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 用户租户关系管理
 *
 * 管理后台：为用户分配/移除租户
 */
@RestController
@RequestMapping("/system/userTenant")
public class SysUserTenantController extends BaseController {

    @Autowired
    private ISysUserTenantService userTenantService;

    /**
     * 根据用户ID获取用户已分配的租户列表
     */
    @SaCheckPermission("system:user:query")
    @GetMapping("/listByUser/{userId}")
    public AjaxResult listByUser(@PathVariable("userId") Long userId) {
        List<SysUserTenant> list = userTenantService.lambdaQuery()
                .eq(SysUserTenant::getUserId, userId)
                .list();
        return AjaxResult.success(list);
    }

    /**
     * 为用户分配租户（支持一次分配多个租户）
     */
    @SaCheckPermission("system:user:edit")
    @Log(title = "用户租户分配", businessType = BusinessType.GRANT)
    @PostMapping("/assign")
    public AjaxResult assignTenants(@RequestBody AssignTenantRequest request) {
        if (request == null || request.getUserId() == null
                || request.getTenantIds() == null || request.getTenantIds().length == 0) {
            return AjaxResult.error("用户ID和租户ID不能为空");
        }
        Long userId = request.getUserId();
        // 先删除该用户已有的租户关系，再重新插入（简单实现）
        userTenantService.lambdaUpdate()
                .eq(SysUserTenant::getUserId, userId)
                .remove();
        for (String tenantId : request.getTenantIds()) {
            if (StringUtils.isBlank(tenantId)) {
                continue;
            }
            SysUserTenant rel = new SysUserTenant();
            rel.setUserId(userId);
            rel.setTenantId(tenantId);
            rel.setDisabled("0");
            userTenantService.save(rel);
        }
        return AjaxResult.success();
    }

    /**
     * 从某个租户中移除用户
     */
    @SaCheckPermission("system:user:edit")
    @Log(title = "用户租户移除", businessType = BusinessType.DELETE)
    @DeleteMapping("/removeByUserAndTenant")
    public AjaxResult removeByUserAndTenant(@RequestParam("userId") Long userId,
                                            @RequestParam("tenantId") String tenantId) {
        if (userId == null || StringUtils.isBlank(tenantId)) {
            return AjaxResult.error("用户ID和租户ID不能为空");
        }
        boolean removed = userTenantService.lambdaUpdate()
                .eq(SysUserTenant::getUserId, userId)
                .eq(SysUserTenant::getTenantId, tenantId)
                .remove();
        return toAjax(removed);
    }

    /**
     * 分配租户请求体
     */
    public static class AssignTenantRequest {
        private Long userId;
        private String[] tenantIds;

        public Long getUserId() {
            return userId;
        }

        public void setUserId(Long userId) {
            this.userId = userId;
        }

        public String[] getTenantIds() {
            return tenantIds;
        }

        public void setTenantIds(String[] tenantIds) {
            this.tenantIds = tenantIds;
        }
    }
}


