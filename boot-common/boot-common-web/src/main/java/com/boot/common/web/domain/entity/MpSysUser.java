package com.boot.common.web.domain.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.boot.common.core.annotation.Excel;
import com.boot.common.core.annotation.Excel.ColumnType;
import com.boot.common.core.annotation.Excel.Type;
import lombok.Data;
import lombok.ToString;

import java.io.Serializable;
import java.util.Date;

/**
 * 基于MP的 用户对象 sys_user
 *
 * @author boot
 */
@Data
@ToString
@TableName("sys_user")
public class MpSysUser implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 用户ID
     */
    @Excel(name = "用户序号", cellType = ColumnType.NUMERIC, prompt = "用户编号")
    @TableId
    private Long userId;

    /**
     * 部门ID
     */
    @Excel(name = "部门编号", type = Type.IMPORT)
    @TableField
    private Long deptId;

    /**
     * 用户账号
     */
    @Excel(name = "登录名称")
    @TableField
    private String userName;

    /**
     * 用户昵称
     */
    @Excel(name = "用户名称")
    @TableField
    private String nickName;

    /**
     * 用户邮箱
     */
    @Excel(name = "用户邮箱")
    @TableField
    private String email;

    /**
     * 手机号码
     */
    @Excel(name = "手机号码")
    @TableField
    private String phonenumber;

    /**
     * 用户性别
     */
    @Excel(name = "用户性别", readConverterExp = "0=男,1=女,2=未知")
    @TableField
    private String sex;

    /**
     * 用户头像
     */
    @TableField
    private String avatar;

    /**
     * 密码
     */
    @TableField
    private String password;
    /**
     * 用户类型
     */
    @TableField
    private String userType;

    /**
     * 帐号状态（0正常 1停用）
     */
    @Excel(name = "帐号状态", readConverterExp = "0=正常,1=停用")
    @TableField
    private String status;

    /**
     * 删除标志（0代表存在 2代表删除）
     */
    @TableField
    private String delFlag;


    /**
     * 最后登录IP
     */
    @Excel(name = "最后登录IP", type = Type.EXPORT)
    @TableField
    private String loginIp;

    /**
     * 最后登录时间
     */
    @Excel(name = "最后登录时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss", type = Type.EXPORT)
    @TableField
    private Date loginDate;

//        *   增加`is_sys`标识，只有为`1`的用户才能登录管理后台，管理后台中创建新用户时可以选择。
//            *   增加`user_tenant`关联表，用于标识用户和租户的关系。
//            *   管理后台的用户管理展示全部的用户，用户可以选择分配到哪个租户中，无部门选择，可以选择后台管理的角色。
//            *   业务后台的用户管理展示此租户下的用户，有部门，且可以选择租户下的角色。
    @TableField("is_sys")
    private Integer isSys;

    @TableField("tenant_id")
    private String tenantId;

    /**
     * 是否是管理员
     */
    @TableField("is_admin")
    private Integer isAdmin;
}
