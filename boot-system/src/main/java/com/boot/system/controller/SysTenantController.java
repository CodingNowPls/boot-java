package com.boot.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.boot.common.core.constant.Constants;
import com.boot.common.core.domain.AjaxResult;
import com.boot.common.core.utils.StringUtils;
import com.boot.common.log.annotation.Log;
import com.boot.common.core.enums.BusinessType;
import com.boot.common.mybatis.page.TableDataInfo;
import com.boot.common.web.controller.BaseController;
import com.boot.common.core.domain.TreeSelect;
import com.boot.common.core.domain.entity.SysMenu;
import com.boot.system.domain.SysTenant;
import com.boot.system.domain.SysTenantMenuPack;
import com.boot.system.domain.SysMenuPack;
import com.boot.system.domain.SysMenuPackDetail;
import com.boot.system.service.ISysTenantService;
import com.boot.system.service.ISysTenantMenuPackService;
import com.boot.system.service.ISysMenuPackService;
import com.boot.system.service.ISysMenuPackDetailService;
import com.boot.system.service.ISysMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
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
    private ISysMenuPackService menuPackService;

    @Autowired
    private ISysMenuPackDetailService menuPackDetailService;

    @Autowired
    private ISysTenantMenuPackService tenantMenuPackService;

    @Autowired
    private ISysMenuService menuService;

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
        return toAjax(sysTenantService.save(tenant));
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
        return toAjax(sysTenantService.updateById(tenant));
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

    private String buildTenantPackCode(String tenantId) {
        return "tenant_custom_" + tenantId;
    }

    /**
     * 查询租户已分配的菜单ID列表
     */
    @SaCheckPermission("system:tenant:query")
    @GetMapping("/menuIds/{tenantId}")
    public AjaxResult getTenantMenuIds(@PathVariable("tenantId") String tenantId) {
        return AjaxResult.success(loadTenantMenuIds(tenantId));
    }

    /**
     * 仿角色授权获取菜单树，过滤租户管理自身菜单
     */
    @SaCheckPermission("system:tenant:query")
    @GetMapping("/menuTreeselect/{tenantId}")
    public AjaxResult tenantMenuTreeselect(@PathVariable("tenantId") String tenantId) {
        List<SysMenu> menus = menuService.selectMenuList(getUserId());
        List<TreeSelect> treeSelects = menuService.buildMenuTreeSelect(filterTenantManageMenus(menus));
        List<Long> checkedKeys = loadTenantMenuIds(tenantId);
        AjaxResult ajax = AjaxResult.success();
        ajax.put("menus", treeSelects);
        ajax.put("checkedKeys", checkedKeys);
        return ajax;
    }

    /**
     * 为租户设置菜单（级联选择）
     */
    @SaCheckPermission("system:tenant:edit")
    @Log(title = "租户菜单设置", businessType = BusinessType.GRANT)
    @PostMapping("/assignMenus")
    public AjaxResult assignMenus(@RequestBody TenantAssignMenuRequest request) {
        if (request == null || StringUtils.isBlank(request.getTenantId())) {
            return AjaxResult.error("租户ID不能为空");
        }
        SysTenant tenant = sysTenantService.getById(request.getTenantId());
        if (tenant == null) {
            return AjaxResult.error("租户不存在");
        }
        String packCode = buildTenantPackCode(request.getTenantId());
        SysMenuPack pack = menuPackService.lambdaQuery()
                .eq(SysMenuPack::getPackCode, packCode)
                .one();
        if (pack == null) {
            pack = new SysMenuPack();
            pack.setPackName(tenant.getTenantName() + "菜单");
            pack.setPackCode(packCode);
            pack.setStatus("0");
            pack.setCreateBy(getUserName());
            menuPackService.save(pack);
        } else {
            pack.setUpdateBy(getUserName());
            menuPackService.updateById(pack);
        }
        Long packId = pack.getPackId();
        // 更新套餐明细
        menuPackDetailService.lambdaUpdate()
                .eq(SysMenuPackDetail::getPackId, packId)
                .remove();
        if (!CollectionUtils.isEmpty(request.getMenuIds())) {
            for (Long menuId : request.getMenuIds()) {
                SysMenuPackDetail detail = new SysMenuPackDetail();
                detail.setPackId(packId);
                detail.setMenuId(menuId);
                menuPackDetailService.save(detail);
            }
        }
        // 重新绑定租户与套餐
        tenantMenuPackService.lambdaUpdate()
                .eq(SysTenantMenuPack::getTenantId, request.getTenantId())
                .remove();
        SysTenantMenuPack relation = new SysTenantMenuPack();
        relation.setTenantId(request.getTenantId());
        relation.setPackId(packId);
        relation.setCreateBy(getUserName());
        tenantMenuPackService.save(relation);
        return AjaxResult.success();
    }

    private List<Long> loadTenantMenuIds(String tenantId) {
        if (StringUtils.isBlank(tenantId)) {
            return Collections.emptyList();
        }
        String packCode = buildTenantPackCode(tenantId);
        SysMenuPack pack = menuPackService.lambdaQuery()
                .eq(SysMenuPack::getPackCode, packCode)
                .one();
        if (pack == null) {
            return Collections.emptyList();
        }
        return menuPackDetailService.lambdaQuery()
                .eq(SysMenuPackDetail::getPackId, pack.getPackId())
                .list()
                .stream()
                .map(SysMenuPackDetail::getMenuId)
                .collect(Collectors.toList());
    }

    private List<SysMenu> filterTenantManageMenus(List<SysMenu> menus) {
        if (CollectionUtils.isEmpty(menus)) {
            return menus;
        }
        Map<Long, List<SysMenu>> childrenMap = menus.stream()
                .collect(Collectors.groupingBy(SysMenu::getParentId, HashMap::new, Collectors.toList()));
        Set<Long> excludeIds = new HashSet<>();
        for (SysMenu menu : menus) {
            if (isTenantManageMenu(menu)) {
                excludeIds.add(menu.getMenuId());
                markDescendants(menu.getMenuId(), childrenMap, excludeIds);
            }
        }
        return menus.stream()
                .filter(menu -> !excludeIds.contains(menu.getMenuId()))
                .collect(Collectors.toList());
    }

    private void markDescendants(Long menuId, Map<Long, List<SysMenu>> childrenMap, Set<Long> excludeIds) {
        List<SysMenu> children = childrenMap.get(menuId);
        if (CollectionUtils.isEmpty(children)) {
            return;
        }
        for (SysMenu child : children) {
            if (excludeIds.add(child.getMenuId())) {
                markDescendants(child.getMenuId(), childrenMap, excludeIds);
            }
        }
    }

    private boolean isTenantManageMenu(SysMenu menu) {
        String perms = menu.getPerms();
        if (StringUtils.isNotBlank(perms)) {
            if (perms.startsWith("system:tenant") || perms.startsWith("system:menuPack") || perms.startsWith("system:tenantMenuPack")) {
                return true;
            }
        }
        String component = menu.getComponent();
        if (StringUtils.isNotBlank(component) &&
                (component.contains("/system/tenant") || component.contains("/system/menuPack"))) {
            return true;
        }
        String path = menu.getPath();
        return StringUtils.isNotBlank(path) && (path.contains("tenant") || path.contains("menuPack"));
    }

    public static class TenantAssignMenuRequest {
        private String tenantId;
        private List<Long> menuIds;

        public String getTenantId() {
            return tenantId;
        }

        public void setTenantId(String tenantId) {
            this.tenantId = tenantId;
        }

        public List<Long> getMenuIds() {
            return menuIds;
        }

        public void setMenuIds(List<Long> menuIds) {
            this.menuIds = menuIds;
        }
    }
}
