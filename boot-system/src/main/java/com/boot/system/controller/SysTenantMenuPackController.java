package com.boot.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.boot.common.core.domain.AjaxResult;
import com.boot.common.core.enums.BusinessType;
import com.boot.common.log.annotation.Log;
import com.boot.common.web.controller.BaseController;
import com.boot.system.domain.SysTenantMenuPack;
import com.boot.system.service.ISysTenantMenuPackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 租户与租户菜单关联管理
 */
@RestController
@RequestMapping("/system/tenantMenuPack")
public class SysTenantMenuPackController extends BaseController {

    @Autowired
    private ISysTenantMenuPackService tenantMenuPackService;

    /**
     * 查询某租户已分配的租户菜单列表
     */
    @SaCheckPermission("system:tenant:query")
    @GetMapping("/listByTenant/{tenantId}")
    public AjaxResult listByTenant(@PathVariable("tenantId") String tenantId) {
        List<SysTenantMenuPack> list = tenantMenuPackService.lambdaQuery()
                .eq(SysTenantMenuPack::getTenantId, tenantId)
                .list();
        return AjaxResult.success(list);
    }

    /**
     * 为租户分配租户菜单（覆盖式）
     */
    @SaCheckPermission("system:tenant:edit")
    @Log(title = "租户分配租户菜单", businessType = BusinessType.GRANT)
    @PostMapping("/assign")
    public AjaxResult assign(@RequestBody AssignTenantMenuPackRequest request) {
        if (request == null || request.getTenantId() == null) {
            return AjaxResult.error("租户ID不能为空");
        }
        String tenantId = request.getTenantId();
        // 先清空原有关联
        tenantMenuPackService.lambdaUpdate()
                .eq(SysTenantMenuPack::getTenantId, tenantId)
                .remove();
        if (request.getPackIds() != null) {
            for (Long packId : request.getPackIds()) {
                SysTenantMenuPack rel = new SysTenantMenuPack();
                rel.setTenantId(tenantId);
                rel.setPackId(packId);
                rel.setCreateBy(getUserName());
                tenantMenuPackService.save(rel);
            }
        }
        // TODO: 这里可以根据租户菜单变更，刷新相关租户下管理员角色的菜单缓存
        return AjaxResult.success();
    }

    public static class AssignTenantMenuPackRequest {
        private String tenantId;
        private Long[] packIds;

        public String getTenantId() {
            return tenantId;
        }

        public void setTenantId(String tenantId) {
            this.tenantId = tenantId;
        }

        public Long[] getPackIds() {
            return packIds;
        }

        public void setPackIds(Long[] packIds) {
            this.packIds = packIds;
        }
    }
}


