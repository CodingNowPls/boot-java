package com.boot.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.boot.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 租户菜单套餐
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_menu_pack")
public class SysMenuPack extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @TableId(value = "pack_id", type = IdType.AUTO)
    private Long packId;

    @TableField("pack_name")
    private String packName;

    @TableField("pack_code")
    private String packCode;

    /**
     * 状态（0正常 1停用）
     */
    @TableField("status")
    private String status;
}

