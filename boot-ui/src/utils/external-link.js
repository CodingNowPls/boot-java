import { getToken } from './auth'

/**
 * 打开外部链接并添加token到URL参数
 * @param {string} url - 外部链接地址
 * @param {string} target - 打开方式，默认为'_blank'
 * @param {object} features - window.open的features参数
 */
export function openExternalLinkWithToken(url, target = '_blank', features = '') {
  if (!url) {
    console.error('URL不能为空')
    return
  }

  // 获取当前token
  const token = getToken()
  
  // 如果没有token，直接打开链接
  if (!token) {
    window.open(url, target, features)
    return
  }

  // 创建一个带有token的URL
  const urlWithToken = addTokenToUrl(url, token)
  
  // 打开新窗口
  window.open(urlWithToken, target, features)
}

/**
 * 向URL添加token参数
 * @param {string} url - 原始URL
 * @param {string} token - token值
 * @returns {string} 带有token的URL
 */
function addTokenToUrl(url, token) {
  if (!token) return url
  
  try {
    const urlObj = new URL(url)
    urlObj.searchParams.set('token', token)
    return urlObj.toString()
  } catch (e) {
    // 如果URL解析失败，尝试简单拼接
    const separator = url.includes('?') ? '&' : '?'
    return `${url}${separator}token=${token}`
  }
}