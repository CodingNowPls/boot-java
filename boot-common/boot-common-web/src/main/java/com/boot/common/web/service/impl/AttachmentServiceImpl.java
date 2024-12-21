package com.boot.common.web.service.impl;

import com.boot.common.web.domain.Attachment;
import com.boot.common.web.mapper.AttachmentMapper;
import com.boot.common.web.service.IAttachmentService;
import com.github.yulichang.base.MPJBaseServiceImpl;
import org.springframework.stereotype.Service;

/**
 * @author : gao
 * @date 2024年12月16日
 * -------------------------------------------<br>
 * <br>
 * <br>
 */
@Service
public class AttachmentServiceImpl extends MPJBaseServiceImpl<AttachmentMapper, Attachment> implements IAttachmentService {
}
