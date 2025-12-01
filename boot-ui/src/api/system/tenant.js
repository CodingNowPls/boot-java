import request from '@/utils/request'

// 查询租户列表
export function listTenant(query) {
  return request({
    url: '/system/tenant/list',
    method: 'get',
    params: query
  })
}

// 查询租户详细
export function getTenant(tenantId) {
  return request({
    url: '/system/tenant/' + tenantId,
    method: 'get'
  })
}

// 新增租户
export function addTenant(data) {
  return request({
    url: '/system/tenant',
    method: 'post',
    data: data
  })
}

// 修改租户
export function updateTenant(data) {
  return request({
    url: '/system/tenant',
    method: 'put',
    data: data
  })
}

// 删除租户
export function delTenant(tenantIds) {
  return request({
    url: '/system/tenant/' + tenantIds,
    method: 'delete'
  })
}

// 查询某租户已分配的租户菜单
export function listTenantMenuPackByTenant(tenantId) {
  return request({
    url: '/system/tenantMenuPack/listByTenant/' + tenantId,
    method: 'get'
  })
}

// 为租户分配租户菜单
export function assignTenantMenuPack(data) {
  return request({
    url: '/system/tenantMenuPack/assign',
    method: 'post',
    data: data
  })
}

// 为租户分配自定义菜单
export function assignTenantMenus(data) {
  return request({
    url: '/system/tenant/assignMenus',
    method: 'post',
    data: data
  })
}

// 查询租户菜单树及选中项
export function tenantMenuTreeselect(tenantId) {
  return request({
    url: '/system/tenant/menuTreeselect/' + tenantId,
    method: 'get'
  })
}


