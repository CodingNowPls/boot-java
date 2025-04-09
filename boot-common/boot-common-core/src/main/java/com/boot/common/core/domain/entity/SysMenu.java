package com.boot.common.core.domain.entity;

import com.boot.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.ToString;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.util.ArrayList;
import java.util.List;

/**
 * 菜单权限表 sys_menu
 *
 * @author boot
 */
@Data
@ToString
public class SysMenu extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 菜单ID
     */
    private Long menuId;

    /**
     * 菜单名称
     */
    private String menuName;

    /**
     * 父菜单名称
     */
    private String parentName;

    /**
     * 父菜单ID
     */
    private Long parentId;

    /**
     * 显示顺序
     */
    private Integer orderNum;

    /**
     * 路由地址
     */
    private String path;

    /**
     * 组件路径
     */
    private String component;

    /**
     * 路由参数
     */
    private String query;

    /**
     * 是否为外链（0是 1否）
     */
    private String isFrame;

    /**
     * 是否缓存（0缓存 1不缓存）
     */
    private String isCache;

    /**
     * 类型（M目录 C菜单 F按钮）
     */
    private String menuType;

    /**
     * 显示状态（0显示 1隐藏）
     */
    private String visible;

    /**
     * 菜单状态（0正常 1停用）
     */
    private String status;

    /**
     * 权限字符串
     */
    private String perms;

    /**
     * 菜单图标
     */
    private String icon;


    //        *   不需要增加租户标识字段，而是依赖`sys_role_menu`角色菜单表来展示不同的菜单。
//            *   增加`is_sys`标识，只用于最顶层的菜单，为`1`标识这个菜单只展示在管理后台中，为`0`标识这个菜单只展示在租户业务后台中，不允许一个菜单既是管理后台的有时业务后台的，如存在此情况，新建不同的菜单来区分。
//            *   菜单列表展示所有的菜单，包含后台管理和业务的，且可以修改。
//            *   后台管理设置角色权限时只展示`is_sys`为`1`的菜单。
//            *   后台管理设置租户菜单套餐时只展示`is_sys`为`0`的菜单
    private Integer isSys;


    /**
     * 子菜单
     */
    private List<SysMenu> children = new ArrayList<SysMenu>();

    @NotBlank(message = "菜单名称不能为空")
    @Size(min = 0, max = 50, message = "菜单名称长度不能超过50个字符")
    public String getMenuName() {
        return menuName;
    }

    @NotNull(message = "显示顺序不能为空")
    public Integer getOrderNum() {
        return orderNum;
    }


    @Size(min = 0, max = 200, message = "路由地址不能超过200个字符")
    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    @Size(min = 0, max = 200, message = "组件路径不能超过255个字符")
    public String getComponent() {
        return component;
    }

    @NotBlank(message = "菜单类型不能为空")
    public String getMenuType() {
        return menuType;
    }



    @Size(min = 0, max = 100, message = "权限标识长度不能超过100个字符")
    public String getPerms() {
        return perms;
    }


}
