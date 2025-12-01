package com.boot.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.boot.common.core.constant.Constants;
import com.boot.common.core.domain.AjaxResult;
import com.boot.common.core.utils.StringUtils;
import com.boot.common.log.annotation.Log;
import com.boot.common.core.enums.BusinessType;
import com.boot.common.mybatis.page.TableDataInfo;
import com.boot.common.web.controller.BaseController;
import com.boot.system.domain.SysTenant;
import com.boot.system.domain.SysTenantMenuPack;
import com.boot.system.service.ISysTenantService;
import com.boot.system.service.ISysTenantMenuPackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 租户管理
 */
@RestController
@RequestMapping("/system/tenant")
public class SysTenantController extends BaseController {

    @Autowired
    private ISysTenantService sysTenantService;

    @Autowired
    private ISysTenantMenuPackService tenantMenuPackService;

    /**
     * 查询租户列表
     */
    @SaCheckPermission("system:tenant:list")
    @GetMapping("/list")
    public TableDataInfo list(SysTenant tenant) {
        startPage();
        List<SysTenant> list = sysTenantService.lambdaQuery()
                .like(StringUtils.isNotBlank(tenant.getTenantName()), SysTenant::getTenantName, tenant.getTenantName())
                .eq(StringUtils.isNotBlank(tenant.getStatus()), SysTenant::getStatus, tenant.getStatus())
                .eq(StringUtils.isNotBlank(tenant.getTenantCode()), SysTenant::getTenantCode, tenant.getTenantCode())
                .list();
        return getDataTable(list);
    }

    /**
     * 获取租户详细信息
     */
    @SaCheckPermission("system:tenant:query")
    @GetMapping(value = "/{tenantId}")
    public AjaxResult getInfo(@PathVariable("tenantId") String tenantId) {
        SysTenant tenant = sysTenantService.getById(tenantId);
        if (tenant == null) {
            return AjaxResult.error("租户不存在");
        }
        List<Long> packIds = tenantMenuPackService.lambdaQuery()
                .eq(SysTenantMenuPack::getTenantId, tenantId)
                .list()
                .stream()
                .map(SysTenantMenuPack::getPackId)
                .collect(Collectors.toList());
        tenant.setPackIds(packIds);
        return AjaxResult.success(tenant);
    }

    /**
     * 新增租户
     */
    @SaCheckPermission("system:tenant:add")
    @Log(title = "租户管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysTenant tenant) {
        // 校验租户编码（必填且唯一）
        if (StringUtils.isBlank(tenant.getTenantCode())) {
            return AjaxResult.error("租户编码不能为空");
        }
        boolean codeExists = sysTenantService.lambdaQuery()
                .eq(SysTenant::getTenantCode, tenant.getTenantCode())
                .exists();
        if (codeExists) {
            return AjaxResult.error("租户编码已存在");
        }
        // 如果前端未传租户ID，则默认使用租户编码作为租户ID（字符串类型）
        if (StringUtils.isBlank(tenant.getTenantId())) {
            tenant.setTenantId(tenant.getTenantCode());
        }
        // 保留平台/默认租户ID
        if (Constants.PLATFORM_TENANT_ID.equals(tenant.getTenantId())) {
            return AjaxResult.error("租户ID已保留为平台/默认租户，请使用其他ID");
        }
        boolean exists = sysTenantService.lambdaQuery()
                .eq(SysTenant::getTenantId, tenant.getTenantId())
                .exists();
        if (exists) {
            return AjaxResult.error("租户ID已存在");
        }
        // 默认状态和删除标记
        if (StringUtils.isBlank(tenant.getStatus())) {
            tenant.setStatus("0");
        }
        tenant.setDelFlag("0");
        tenant.setCreateBy(getUserName());
        boolean saved = sysTenantService.save(tenant);
        if (saved) {
            assignTenantMenuPacks(tenant.getTenantId(), tenant.getPackIds());
        }
        return toAjax(saved);
    }

    /**
     * 修改租户
     */
    @SaCheckPermission("system:tenant:edit")
    @Log(title = "租户管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysTenant tenant) {
        if (StringUtils.isBlank(tenant.getTenantId())) {
            return AjaxResult.error("租户ID不能为空");
        }
        if (Constants.PLATFORM_TENANT_ID.equals(tenant.getTenantId())) {
            // 平台/默认租户允许修改名称等基础信息，但不允许修改为停用/删除可在前端或这里再细化
        }
        tenant.setUpdateBy(getUserName());
        boolean updated = sysTenantService.updateById(tenant);
        if (updated && tenant.getPackIds() != null) {
            assignTenantMenuPacks(tenant.getTenantId(), tenant.getPackIds());
        }
        return toAjax(updated);
    }

    /**
     * 删除租户
     */
    @SaCheckPermission("system:tenant:remove")
    @Log(title = "租户管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{tenantIds}")
    public AjaxResult remove(@PathVariable String[] tenantIds) {
        for (String tenantId : tenantIds) {
            if (Constants.PLATFORM_TENANT_ID.equals(tenantId)) {
                return AjaxResult.error("平台/默认租户不允许删除");
            }
        }
        return toAjax(sysTenantService.removeBatchByIds(java.util.Arrays.asList(tenantIds)));
    }

    private void assignTenantMenuPacks(String tenantId, List<Long> packIds) {
        if (StringUtils.isBlank(tenantId)) {
            return;
        }
        if (Constants.PLATFORM_TENANT_ID.equals(tenantId)) {
            // 平台租户固定菜单，不允许调整
            return;
        }
        tenantMenuPackService.lambdaUpdate()
                .eq(SysTenantMenuPack::getTenantId, tenantId)
                .remove();
        if (!CollectionUtils.isEmpty(packIds)) {
            for (Long packId : packIds) {
                SysTenantMenuPack relation = new SysTenantMenuPack();
                relation.setTenantId(tenantId);
                relation.setPackId(packId);
                relation.setCreateBy(getUserName());
                tenantMenuPackService.save(relation);
            }
        }
    }
}
