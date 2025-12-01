package com.boot.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.boot.common.core.domain.AjaxResult;
import com.boot.common.core.enums.BusinessType;
import com.boot.common.core.utils.StringUtils;
import com.boot.common.log.annotation.Log;
import com.boot.common.mybatis.page.TableDataInfo;
import com.boot.common.web.controller.BaseController;
import com.boot.common.core.domain.entity.SysMenu;
import com.boot.system.domain.SysMenuPack;
import com.boot.system.domain.SysMenuPackDetail;
import com.boot.system.service.ISysMenuPackDetailService;
import com.boot.system.service.ISysMenuPackService;
import com.boot.system.service.ISysMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 租户菜单管理（原菜单套餐）
 */
@RestController
@RequestMapping("/system/menuPack")
public class SysMenuPackController extends BaseController {

    @Autowired
    private ISysMenuPackService menuPackService;

    @Autowired
    private ISysMenuPackDetailService menuPackDetailService;

    @Autowired
    private ISysMenuService menuService;

    /**
     * 查询租户菜单列表
     */
    @SaCheckPermission("system:menuPack:list")
    @GetMapping("/list")
    public TableDataInfo list(SysMenuPack query) {
        startPage();
        List<SysMenuPack> list = menuPackService.lambdaQuery()
                .like(StringUtils.isNotBlank(query.getPackName()), SysMenuPack::getPackName, query.getPackName())
                .eq(StringUtils.isNotBlank(query.getStatus()), SysMenuPack::getStatus, query.getStatus())
                .list();
        return getDataTable(list);
    }

    /**
     * 获取租户菜单详情（含已分配的菜单ID列表）
     */
    @SaCheckPermission("system:menuPack:query")
    @GetMapping("/{packId}")
    public AjaxResult getInfo(@PathVariable("packId") Long packId) {
        SysMenuPack pack = menuPackService.getById(packId);
        List<SysMenuPackDetail> details = menuPackDetailService.lambdaQuery()
                .eq(SysMenuPackDetail::getPackId, packId)
                .list();
        AjaxResult ajax = AjaxResult.success(pack);
        ajax.put("menuIds", details.stream().map(SysMenuPackDetail::getMenuId).toArray(Long[]::new));
        return ajax;
    }

    /**
     * 新增租户菜单
     */
    @SaCheckPermission("system:menuPack:add")
    @Log(title = "租户菜单管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysMenuPack pack) {
        if (StringUtils.isBlank(pack.getPackName())) {
            return AjaxResult.error("租户菜单名称不能为空");
        }
        pack.setCreateBy(getUserName());
        if (StringUtils.isBlank(pack.getStatus())) {
            pack.setStatus("0");
        }
        return toAjax(menuPackService.save(pack));
    }

    /**
     * 修改租户菜单
     */
    @SaCheckPermission("system:menuPack:edit")
    @Log(title = "租户菜单管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysMenuPack pack) {
        if (pack.getPackId() == null) {
            return AjaxResult.error("租户菜单ID不能为空");
        }
        pack.setUpdateBy(getUserName());
        return toAjax(menuPackService.updateById(pack));
    }

    /**
     * 删除租户菜单（如已分配给租户需限制删除，前续可补充判定）
     */
    @SaCheckPermission("system:menuPack:remove")
    @Log(title = "租户菜单管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{packIds}")
    public AjaxResult remove(@PathVariable Long[] packIds) {
        // 简单实现：先删除明细，再删除主表
        for (Long packId : packIds) {
            menuPackDetailService.lambdaUpdate()
                    .eq(SysMenuPackDetail::getPackId, packId)
                    .remove();
        }
        return toAjax(menuPackService.removeBatchByIds(java.util.Arrays.asList(packIds)));
    }

    /**
     * 为租户菜单分配菜单
     */
    @SaCheckPermission("system:menuPack:edit")
    @Log(title = "租户菜单分配菜单", businessType = BusinessType.GRANT)
    @PostMapping("/assignMenus")
    public AjaxResult assignMenus(@RequestBody AssignMenusRequest request) {
        if (request == null || request.getPackId() == null) {
            return AjaxResult.error("租户菜单ID不能为空");
        }
        Long packId = request.getPackId();
        // 先清空原有明细
        menuPackDetailService.lambdaUpdate()
                .eq(SysMenuPackDetail::getPackId, packId)
                .remove();
        if (request.getMenuIds() != null && request.getMenuIds().length > 0) {
            for (Long menuId : request.getMenuIds()) {
                SysMenu menu = menuService.selectMenuById(menuId);
                if (menu == null) {
                    return AjaxResult.error("菜单ID不存在：" + menuId);
                }
                if (!"0".equals(menu.getIsSys())) {
                    return AjaxResult.error("仅允许选择业务菜单，非法菜单：" + menu.getMenuName());
                }
            }
            for (Long menuId : request.getMenuIds()) {
                SysMenuPackDetail detail = new SysMenuPackDetail();
                detail.setPackId(packId);
                detail.setMenuId(menuId);
                menuPackDetailService.save(detail);
            }
        }
        return AjaxResult.success();
    }

    public static class AssignMenusRequest {
        private Long packId;
        private Long[] menuIds;

        public Long getPackId() {
            return packId;
        }

        public void setPackId(Long packId) {
            this.packId = packId;
        }

        public Long[] getMenuIds() {
            return menuIds;
        }

        public void setMenuIds(Long[] menuIds) {
            this.menuIds = menuIds;
        }
    }
}


