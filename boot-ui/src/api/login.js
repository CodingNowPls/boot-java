import request from '@/utils/request'
import { encrypt } from '@/utils/jsencrypt'

// 登录方法（支持租户与管理后台标识）
export function login(userName, password, code, uuid, tenantId, isAdminLogin) {
  // 集成jsencrypt实现密码加密传输方式
  password = encrypt(password);
  const data = {
    userName,
    password,
    code,
    uuid,
    tenantId,
    isAdminLogin
  }
  return request({
    url: '/login',
    headers: {
      isToken: false
    },
    method: 'post',
    data: data
  })
}

// 获取登录配置（是否显示租户下拉、模式等）
export function getLoginConfig() {
  return request({
    url: '/getLoginConfig',
    headers: {
      isToken: false
    },
    method: 'get'
  })
}

// 获取租户下拉列表
export function getTenantList(userName, isAdminLogin) {
  return request({
    url: '/getTenantList',
    headers: {
      isToken: false
    },
    method: 'get',
    params: { userName, isAdminLogin }
  })
}

// 切换当前业务租户
export function switchTenant(tenantId) {
  return request({
    url: '/switchTenant',
    method: 'post',
    params: { tenantId }
  })
}

// 注册方法
export function register(data) {
  return request({
    url: '/register',
    headers: {
      isToken: false
    },
    method: 'post',
    data: data
  })
}

// 获取用户详细信息
export function getInfo() {
  return request({
    url: '/getInfo',
    method: 'get'
  })
}

// 退出方法
export function logout() {
  return request({
    url: '/logout',
    method: 'post'
  })
}

// 获取验证码
export function getCodeImg() {
  return request({
    url: '/captchaImage',
    headers: {
      isToken: false
    },
    method: 'get',
    timeout: 20000
  })
}
