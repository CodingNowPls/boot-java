package com.boot.common.core.domain.entity;

import com.boot.common.core.annotation.Excel;
import com.boot.common.core.annotation.Excel.ColumnType;
import com.boot.common.core.annotation.Excel.Type;
import com.boot.common.core.annotation.Excels;
import com.boot.common.core.domain.BaseEntity;
import com.boot.common.core.enums.EnumUserRoleType;
import com.boot.common.core.enums.EnumYesNo;
import com.boot.common.core.xss.Xss;
import jakarta.validation.constraints.Email;
import lombok.Data;
import lombok.ToString;

import jakarta.validation.constraints.Size;
import jakarta.validation.constraints.NotBlank;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * 用户对象 sys_user
 *
 * @author boot
 */
@Data
@ToString
public class SysUser extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 用户ID
     */
    @Excel(name = "用户序号", cellType = ColumnType.NUMERIC, prompt = "用户编号")
    private Long userId;

    /**
     * 部门ID
     */
    @Excel(name = "部门编号", type = Type.IMPORT)
    private Long deptId;

    /**
     * 用户账号
     */
    @Excel(name = "登录名称")
    private String userName;

    /**
     * 用户昵称
     */
    @Excel(name = "用户名称")
    private String nickName;

    /**
     * 用户邮箱
     */
    @Excel(name = "用户邮箱")
    private String email;

    /**
     * 手机号码
     */
    @Excel(name = "手机号码")
    private String phonenumber;

    /**
     * 用户性别
     */
    @Excel(name = "用户性别", readConverterExp = "0=男,1=女,2=未知")
    private String sex;

    /**
     * 用户头像
     */
    private String avatar;

    /**
     * 密码
     */
    private String password;
    /**
     * 用户类型: 系统管理员00  主播100  管理组：20
     */
    private String userType;

    /**
     * 帐号状态（0正常 1停用）
     */
    @Excel(name = "帐号状态", readConverterExp = "0=正常,1=停用")
    private String status;

    /**
     * 删除标志（0代表存在 2代表删除）
     */
    private String delFlag;


    /**
     * 最后登录IP
     */
    @Excel(name = "最后登录IP", type = Type.EXPORT)
    private String loginIp;

    /**
     * 最后登录时间
     */
    @Excel(name = "最后登录时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss", type = Type.EXPORT)
    private Date loginDate;

    /**
     * 部门对象
     */
    @Excels({
            @Excel(name = "部门名称", targetAttr = "deptName", type = Type.EXPORT),
            @Excel(name = "部门负责人", targetAttr = "leader", type = Type.EXPORT)
    })
    private SysDept dept;

    /**
     * 角色对象
     */
    private List<SysRole> roles;

    /**
     * 角色组
     */
    private Long[] roleIds;

    /**
     * 岗位组
     */
    private Long[] postIds;

    /**
     * 角色ID
     */
    private Long roleId;


//        *   增加`is_sys`标识，只有为`1`的用户才能登录管理后台，管理后台中创建新用户时可以选择。
//            *   增加`user_tenant`关联表，用于标识用户和租户的关系。
//            *   管理后台的用户管理展示全部的用户，用户可以选择分配到哪个租户中，无部门选择，可以选择后台管理的角色。
//            *   业务后台的用户管理展示此租户下的用户，有部门，且可以选择租户下的角色。

    private Integer isSys;
    /**
     * 租户ID
     */
    private Long tenantId;
    /**
     * 是否是管理员
     */
    private Integer isAdmin;


    public SysUser() {

    }

    public SysUser(Long userId) {
        this.userId = userId;
    }

    public static boolean isAdmin(Integer isAdmin) {
        return EnumYesNo.YES.getCode() == isAdmin;
    }



    @Xss(message = "用户昵称不能包含脚本字符")
    @Size(min = 0, max = 30, message = "用户昵称长度不能超过30个字符")
    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    @Xss(message = "用户账号不能包含脚本字符")
    @NotBlank(message = "用户账号不能为空")
    @Size(min = 0, max = 30, message = "用户账号长度不能超过30个字符")
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Email(message = "邮箱格式不正确")
    @Size(min = 0, max = 50, message = "邮箱长度不能超过50个字符")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Size(min = 0, max = 11, message = "手机号码长度不能超过11个字符")
    public String getPhonenumber() {
        return phonenumber;
    }

}
