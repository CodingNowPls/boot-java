package com.boot.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.boot.system.domain.SysMenuPack;
import com.boot.system.mapper.SysMenuPackMapper;
import com.boot.system.service.ISysMenuPackService;
import org.springframework.stereotype.Service;

@Service
public class SysMenuPackServiceImpl extends ServiceImpl<SysMenuPackMapper, SysMenuPack> implements ISysMenuPackService {
}

