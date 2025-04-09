package com.boot.system.domain;

import com.boot.common.core.domain.BaseEntity;
import com.boot.common.core.xss.Xss;
import lombok.Data;
import lombok.ToString;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * 通知公告表 sys_notice
 *
 * @author boot
 */
@Data
@ToString
public class SysNotice extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 公告ID
     */
    private Long noticeId;

    /**
     * 公告标题
     */
    private String noticeTitle;

    /**
     * 公告类型（1通知 2公告）
     */
    private String noticeType;

    /**
     * 公告内容
     */
    private String noticeContent;

    /**
     * 公告状态（0正常 1关闭）
     */
    private String status;



    @Xss(message = "公告标题不能包含脚本字符")
    @NotBlank(message = "公告标题不能为空")
    @Size(min = 0, max = 50, message = "公告标题不能超过50个字符")
    public String getNoticeTitle() {
        return noticeTitle;
    }

}
