package com.boot.common.mybatis.base.impl;


import com.boot.common.mybatis.base.SuperMapper;
import com.boot.common.mybatis.base.SuperService;
import com.github.yulichang.base.MPJBaseServiceImpl;

public class SuperServiceImpl <M extends SuperMapper<T>, T> extends MPJBaseServiceImpl<M, T> implements SuperService<T> {



}
