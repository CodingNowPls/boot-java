package com.boot.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.boot.system.domain.SysUserTenant;
import com.boot.system.mapper.SysUserTenantMapper;
import com.boot.system.service.ISysUserTenantService;
import org.springframework.stereotype.Service;

@Service
public class SysUserTenantServiceImpl extends ServiceImpl<SysUserTenantMapper, SysUserTenant> implements ISysUserTenantService {
}

