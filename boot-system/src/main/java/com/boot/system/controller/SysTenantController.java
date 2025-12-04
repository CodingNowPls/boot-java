package com.boot.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.boot.common.core.constant.Constants;
import com.boot.common.core.domain.AjaxResult;
import com.boot.common.core.domain.entity.SysRole;
import com.boot.common.core.domain.entity.SysUser;
import com.boot.common.core.exception.ServiceException;
import com.boot.common.core.utils.StringUtils;
import com.boot.common.log.annotation.Log;
import com.boot.common.core.enums.BusinessType;
import com.boot.common.mybatis.page.TableDataInfo;
import com.boot.common.security.utils.SecurityUtils;
import com.boot.common.web.controller.BaseController;
import com.boot.system.domain.SysMenuPackDetail;
import com.boot.system.domain.SysTenant;
import com.boot.system.service.*;
import com.boot.common.core.domain.entity.SysMenu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.HashSet;
import java.util.List;
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
    private ISysRoleService roleService;

    @Autowired
    private ISysMenuPackDetailService menuPackDetailService;

    @Autowired
    private ISysMenuService menuService;

    @Autowired
    private com.boot.system.mapper.SysMenuMapper menuMapper;

    @Autowired
    private ISysUserService userService;

    @Autowired
    private ISysConfigService configService;

    /**
     * 查询租户列表
     */
    @SaCheckPermission("system:tenant:list")
    @GetMapping("/list")
    public TableDataInfo list(SysTenant tenant) {
        startMpPage(SysTenant.class);
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
        // 查询该租户的菜单，获取菜单套餐ID（通过菜单的tenant_id和菜单套餐详情关联）
        // 这里简化处理：从菜单套餐详情中查找包含该租户菜单的套餐
        // 实际实现可能需要更复杂的逻辑，这里先返回空列表，由前端传入
        tenant.setPackIds(Collections.emptyList());
        return AjaxResult.success(tenant);
    }

    /**
     * 新增租户
     */
    @SaCheckPermission("system:tenant:add")
    @Log(title = "租户管理", businessType = BusinessType.INSERT)
    @PostMapping
    @Transactional(rollbackFor = Exception.class)
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
        if (!Constants.PLATFORM_TENANT_ID.equals(tenant.getTenantId())) {
            AjaxResult adminValidate = validateTenantAdminInfo(tenant);
            if (adminValidate != null) {
                return adminValidate;
            }
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
            if (!Constants.PLATFORM_TENANT_ID.equals(tenant.getTenantId())) {
                Long adminRoleId = createTenantAdminRole(tenant);
                createTenantAdminUser(tenant, adminRoleId);
            }
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
            if (!Constants.PLATFORM_TENANT_ID.equals(tenant.getTenantId())) {
                syncTenantAdminMenus(tenant.getTenantId(), tenant.getPackIds());
            }
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

    /**
     * 为租户分配菜单（从菜单套餐复制菜单到sys_menu表）
     */
    private void assignTenantMenuPacks(String tenantId, List<Long> packIds) {
        if (StringUtils.isBlank(tenantId)) {
            return;
        }
        if (Constants.PLATFORM_TENANT_ID.equals(tenantId)) {
            // 平台租户固定菜单，不允许调整
            return;
        }
        // 先删除该租户的所有菜单
        // 查询该租户的所有菜单ID
        SysMenu queryMenu = new SysMenu();
        queryMenu.setTenantId(tenantId);
        List<SysMenu> tenantMenus = menuService.selectMenuList(queryMenu, null);
        if (!CollectionUtils.isEmpty(tenantMenus)) {
            for (SysMenu menu : tenantMenus) {
                menuService.deleteMenuById(menu.getMenuId());
            }
        }
        if (!CollectionUtils.isEmpty(packIds)) {
            // 从菜单套餐详情中获取菜单ID列表
            List<Long> menuIds = resolveMenuIdsByPackIds(packIds);
            if (!CollectionUtils.isEmpty(menuIds)) {
                // 复制菜单到租户（需要处理菜单树结构）
                copyMenusToTenant(menuIds, tenantId);
            }
        }
    }

    /**
     * 复制菜单到租户（处理菜单树结构）
     */
    private void copyMenusToTenant(List<Long> menuIds, String tenantId) {
        // 查询所有需要复制的菜单（包括父菜单）
        Set<Long> allMenuIds = new HashSet<>(menuIds);
        // 查找所有父菜单
        for (Long menuId : menuIds) {
            SysMenu menu = menuService.selectMenuById(menuId);
            if (menu != null && menu.getParentId() != null && menu.getParentId() != 0) {
                collectParentMenus(menu.getParentId(), allMenuIds);
            }
        }
        // 创建菜单ID映射（原菜单ID -> 新菜单ID）
        java.util.Map<Long, Long> menuIdMap = new java.util.HashMap<>();
        // 按parent_id排序，先插入父菜单
        List<SysMenu> menusToCopy = allMenuIds.stream()
                .map(menuService::selectMenuById)
                .filter(menu -> menu != null)
                .sorted((m1, m2) -> {
                    // 父菜单在前
                    if (m1.getParentId() == null || m1.getParentId() == 0) {
                        return -1;
                    }
                    if (m2.getParentId() == null || m2.getParentId() == 0) {
                        return 1;
                    }
                    return 0;
                })
                .collect(Collectors.toList());
        // 复制菜单
        for (SysMenu sourceMenu : menusToCopy) {
            SysMenu newMenu = new SysMenu();
            newMenu.setMenuName(sourceMenu.getMenuName());
            newMenu.setParentId(sourceMenu.getParentId() != null && sourceMenu.getParentId() != 0 
                    ? menuIdMap.get(sourceMenu.getParentId()) : sourceMenu.getParentId());
            newMenu.setOrderNum(sourceMenu.getOrderNum());
            newMenu.setPath(sourceMenu.getPath());
            newMenu.setComponent(sourceMenu.getComponent());
            newMenu.setQuery(sourceMenu.getQuery());
            newMenu.setIsFrame(sourceMenu.getIsFrame());
            newMenu.setFrameEmbedFlag(sourceMenu.getFrameEmbedFlag());
            newMenu.setIsCache(sourceMenu.getIsCache());
            newMenu.setMenuType(sourceMenu.getMenuType());
            newMenu.setVisible(sourceMenu.getVisible());
            newMenu.setStatus(sourceMenu.getStatus());
            newMenu.setPerms(sourceMenu.getPerms());
            newMenu.setIcon(sourceMenu.getIcon());
            newMenu.setRemark(sourceMenu.getRemark());
            newMenu.setTenantId(tenantId);
            newMenu.setCreateBy(getUserName());
            menuService.insertMenu(newMenu);
            // 保存菜单ID映射
            menuIdMap.put(sourceMenu.getMenuId(), newMenu.getMenuId());
        }
    }

    /**
     * 递归收集父菜单
     */
    private void collectParentMenus(Long parentId, Set<Long> menuIds) {
        if (parentId == null || parentId == 0) {
            return;
        }
        if (menuIds.contains(parentId)) {
            return;
        }
        menuIds.add(parentId);
        SysMenu parentMenu = menuService.selectMenuById(parentId);
        if (parentMenu != null && parentMenu.getParentId() != null && parentMenu.getParentId() != 0) {
            collectParentMenus(parentMenu.getParentId(), menuIds);
        }
    }

    private AjaxResult validateTenantAdminInfo(SysTenant tenant) {
        if (StringUtils.isBlank(tenant.getAdminAccount())) {
            return AjaxResult.error("管理员账号不能为空");
        }
        if (StringUtils.isBlank(tenant.getAdminName())) {
            return AjaxResult.error("管理员姓名不能为空");
        }
        if (StringUtils.isBlank(tenant.getAdminContact())) {
            return AjaxResult.error("管理员联系方式不能为空");
        }
        SysUser exists = userService.selectUserByUserName(tenant.getAdminAccount());
        if (exists != null) {
            return AjaxResult.error("管理员账号已存在，请更换账号");
        }
        return null;
    }

    private Long createTenantAdminRole(SysTenant tenant) {
        List<Long> menuIds = resolveMenuIdsByPackIds(tenant.getPackIds());
        SysRole role = new SysRole();
        role.setTenantId(tenant.getTenantId());
        role.setRoleName(tenant.getTenantName() + "管理员");
        role.setRoleKey("TENANT_ADMIN_" + tenant.getTenantCode());
        role.setIsAdmin("1");
        role.setStatus("0");
        role.setDelFlag("0");
        role.setCreateBy(getUserName());
        role.setMenuIds(menuIds.toArray(new Long[0]));
        int insert = roleService.insertRole(role);
        if (insert <= 0 || role.getRoleId() == null) {
            throw new ServiceException("创建租户管理员角色失败");
        }
        return role.getRoleId();
    }

    private List<Long> resolveMenuIdsByPackIds(List<Long> packIds) {
        if (CollectionUtils.isEmpty(packIds)) {
            return Collections.emptyList();
        }
        Set<Long> menuIds = new HashSet<>();
        menuPackDetailService.lambdaQuery()
                .in(SysMenuPackDetail::getPackId, packIds)
                .list()
                .forEach(detail -> {
                    if (detail.getMenuId() != null) {
                        menuIds.add(detail.getMenuId());
                    }
                });
        return menuIds.stream().collect(Collectors.toList());
    }

    private void createTenantAdminUser(SysTenant tenant, Long roleId) {
        SysUser exists = userService.selectUserByUserName(tenant.getAdminAccount());
        if (exists != null) {
            throw new ServiceException("管理员账号已存在，请更换账号");
        }
        SysUser user = new SysUser();
        user.setUserName(tenant.getAdminAccount());
        user.setNickName(tenant.getAdminName());
        user.setStatus("0");
        user.setDelFlag("0");
        user.setTenantId(tenant.getTenantId());
        String contact = tenant.getAdminContact();
        if (StringUtils.isNotBlank(contact)) {
            if (contact.contains("@")) {
                user.setEmail(contact);
            } else {
                user.setPhonenumber(contact);
            }
        }
        String initPassword = configService.selectConfigByKey("sys.user.initPassword");
        if (StringUtils.isBlank(initPassword)) {
            initPassword = "123456";
        }
        user.setPassword(SecurityUtils.encryptPassword(initPassword));
        if (roleId != null) {
            user.setRoleIds(new Long[]{roleId});
        } else {
            user.setRoleIds(new Long[0]);
        }
        user.setCreateBy(getUserName());
        int rows = userService.insertUser(user);
        if (rows <= 0 || user.getUserId() == null) {
            throw new ServiceException("租户管理员用户创建失败");
        }
        // 用户已通过tenant_id直接关联租户，不需要额外的关联表
    }

    private void syncTenantAdminMenus(String tenantId, List<Long> packIds) {
        if (StringUtils.isBlank(tenantId)) {
            return;
        }
        List<Long> menuIds = resolveMenuIdsByPackIds(packIds);
        SysRole query = new SysRole();
        query.setTenantId(tenantId);
        query.setIsAdmin("1");
        query.getParams().put("dataScope", "");
        List<SysRole> adminRoles = roleService.selectRoleList(query);
        if (CollectionUtils.isEmpty(adminRoles)) {
            return;
        }
        Long[] menuIdArray = menuIds.toArray(new Long[0]);
        for (SysRole adminRole : adminRoles) {
            SysRole update = new SysRole();
            update.setRoleId(adminRole.getRoleId());
            update.setMenuIds(menuIdArray);
            update.setUpdateBy(getUserName());
            roleService.updateRole(update);
        }
    }
}
