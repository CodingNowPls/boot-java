package com.boot.common.web.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@TableName("sys_attachments")
public class Attachment implements Serializable {

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    /**
     * 文件名称
     */
    private String fileName;
    /**
     *  文件类型
     */
    private String fileType;
    /**
     *  上传时间
     */
    private LocalDateTime uploadTime;
    /**
     * 文件大小
     */
    private Long fileSize;
    /**
     *  文件存储路径
     */
    private String filePath;
    /**
     * 创建时间
     */
    private LocalDateTime createdAt;
    /**
     *  更新时间
     */
    private LocalDateTime updatedAt;
}
