import request from '@/utils/request'

export function getTemplateList() {
  return request({ url: '/print/templates', method: 'get' })
}

export function saveTemplate(data) {
  return request({ url: '/print/templates', method: 'post', data })
}
