package com.boot.common.core.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.boot.common.core.annotation.Excel;
import com.boot.common.core.annotation.Excel.ColumnType;
import com.boot.common.core.constant.UserConstants;
import com.boot.common.core.domain.BaseEntity;
import lombok.Data;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * 字典数据表 sys_dict_data
 *
 * @author boot
 */
@Data
@TableName("sys_dict_data")
public class SysDictData extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 字典编码
     */
    @Excel(name = "字典编码", cellType = ColumnType.NUMERIC)
    @TableId(type = IdType.AUTO)
    private Long dictCode;

    /**
     * 字典排序
     */
    @Excel(name = "字典排序", cellType = ColumnType.NUMERIC)
    @TableField("dict_sort")
    private Long dictSort;

    /**
     * 字典标签
     */
    @Excel(name = "字典标签")
    @TableField("dict_label")
    private String dictLabel;

    /**
     * 字典键值
     */
    @Excel(name = "字典键值")
    @TableField("dict_value")
    private String dictValue;

    /**
     * 字典类型
     */
    @Excel(name = "字典类型")
    @TableField("dict_type")
    private String dictType;

    /**
     * 样式属性（其他样式扩展）
     */
    @TableField("css_class")
    private String cssClass;

    /**
     * 表格字典样式
     */
    @TableField("list_class")
    private String listClass;

    /**
     * 是否默认（Y是 N否）
     */
    @Excel(name = "是否默认", readConverterExp = "Y=是,N=否")
    @TableField("is_default")
    private String isDefault;

    /**
     * 状态（0正常 1停用）
     */
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    @TableField("status")
    private String status;

    @NotBlank(message = "字典标签不能为空")
    @Size(max = 100, message = "字典标签长度不能超过100个字符")
    public String getDictLabel() {
        return dictLabel;
    }


    @NotBlank(message = "字典键值不能为空")
    @Size(max = 100, message = "字典键值长度不能超过100个字符")
    public String getDictValue() {
        return dictValue;
    }


    @NotBlank(message = "字典类型不能为空")
    @Size(max = 100, message = "字典类型长度不能超过100个字符")
    public String getDictType() {
        return dictType;
    }


    @Size(max = 100, message = "样式属性长度不能超过100个字符")
    public String getCssClass() {
        return cssClass;
    }

    public boolean getDefault() {
        return UserConstants.YES.equals(this.isDefault);
    }


}
