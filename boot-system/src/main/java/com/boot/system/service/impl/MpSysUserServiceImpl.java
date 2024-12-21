package com.boot.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.boot.common.web.domain.entity.MpSysUser;
import com.boot.system.mapper.MpSysUserMapper;
import com.boot.system.service.IMpSysUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;


/**
 * 用户 业务层处理
 *
 * @author boot
 */
@Slf4j
@Service
public class MpSysUserServiceImpl extends ServiceImpl<MpSysUserMapper, MpSysUser> implements IMpSysUserService {

}
