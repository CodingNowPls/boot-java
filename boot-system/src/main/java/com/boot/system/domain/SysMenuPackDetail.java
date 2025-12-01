package com.boot.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 租户菜单套餐明细
 */
@Data
@TableName("sys_menu_pack_detail")
public class SysMenuPackDetail {

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField("pack_id")
    private Long packId;

    @TableField("menu_id")
    private Long menuId;
}

