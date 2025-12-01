package com.boot.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.dev33.satoken.annotation.SaMode;
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
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

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
        fillMenuDetail(list);
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
        List<Long> menuIds = details.stream().map(SysMenuPackDetail::getMenuId).collect(Collectors.toList());
        pack.setMenuIds(menuIds);
        pack.setMenuCount(menuIds.size());
        if (!CollectionUtils.isEmpty(menuIds)) {
            pack.setMenuNameList(menuIds.stream()
                    .map(menuService::selectMenuById)
                    .filter(java.util.Objects::nonNull)
                    .map(SysMenu::getMenuName)
                    .collect(Collectors.toList()));
        }
        AjaxResult ajax = AjaxResult.success(pack);
        ajax.put("menuIds", menuIds.toArray(new Long[0]));
        return ajax;
    }

    /**
     * 提供给租户管理的租户菜单下拉
     */
    @SaCheckPermission(value = {"system:menuPack:list", "system:tenant:list"}, mode = SaMode.OR)
    @GetMapping("/simpleList")
    public AjaxResult simpleList(@RequestParam(value = "status", required = false) String status) {
        List<SysMenuPack> list = menuPackService.lambdaQuery()
                .eq(StringUtils.isNotBlank(status), SysMenuPack::getStatus, status)
                .list();
        fillMenuDetail(list);
        return AjaxResult.success(list);
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

    private void fillMenuDetail(List<SysMenuPack> list) {
        if (CollectionUtils.isEmpty(list)) {
            return;
        }
        List<Long> packIds = list.stream().map(SysMenuPack::getPackId).collect(Collectors.toList());
        List<SysMenuPackDetail> details = menuPackDetailService.lambdaQuery()
                .in(SysMenuPackDetail::getPackId, packIds)
                .list();
        Map<Long, List<Long>> detailMap = details.stream()
                .collect(Collectors.groupingBy(SysMenuPackDetail::getPackId,
                        Collectors.mapping(SysMenuPackDetail::getMenuId, Collectors.toList())));
        Map<Long, SysMenu> menuCache = new HashMap<>();
        for (SysMenuPack pack : list) {
            List<Long> menuIds = detailMap.getOrDefault(pack.getPackId(), Collections.emptyList());
            pack.setMenuIds(menuIds);
            pack.setMenuCount(menuIds.size());
            if (!CollectionUtils.isEmpty(menuIds)) {
                List<String> names = new ArrayList<>();
                for (Long menuId : menuIds) {
                    SysMenu menu = menuCache.computeIfAbsent(menuId, menuService::selectMenuById);
                    if (menu != null) {
                        names.add(menu.getMenuName());
                    }
                }
                pack.setMenuNameList(names);
            } else {
                pack.setMenuNameList(Collections.emptyList());
            }
        }
    }
}


