import request from '@/utils/request'

// 查询租户菜单列表
export function listMenuPack(query) {
  return request({
    url: '/system/menuPack/list',
    method: 'get',
    params: query
  })
}

// 查询租户菜单详细（含已分配菜单ID）
export function getMenuPack(packId) {
  return request({
    url: '/system/menuPack/' + packId,
    method: 'get'
  })
}

// 新增租户菜单
export function addMenuPack(data) {
  return request({
    url: '/system/menuPack',
    method: 'post',
    data: data
  })
}

// 修改租户菜单
export function updateMenuPack(data) {
  return request({
    url: '/system/menuPack',
    method: 'put',
    data: data
  })
}

// 删除租户菜单
export function delMenuPack(packIds) {
  return request({
    url: '/system/menuPack/' + packIds,
    method: 'delete'
  })
}

// 为租户菜单分配菜单
export function assignMenusToPack(data) {
  return request({
    url: '/system/menuPack/assignMenus',
    method: 'post',
    data: data
  })
}


