package com.boot.common.magicapi.interceptor;

import com.boot.common.security.core.domain.model.LoginUser;
import com.boot.common.security.utils.SecurityUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.ssssssss.magicapi.core.interceptor.RequestInterceptor;
import org.ssssssss.magicapi.core.model.ApiInfo;
import org.ssssssss.magicapi.core.model.JsonBean;
import org.ssssssss.magicapi.core.model.Options;
import org.ssssssss.magicapi.core.servlet.MagicHttpServletRequest;
import org.ssssssss.magicapi.core.servlet.MagicHttpServletResponse;
import org.ssssssss.script.MagicScriptContext;

/**
 * magic-api 接口鉴权
 */
@Slf4j
@Component
public class CustomRequestInterceptor implements RequestInterceptor {


	/**
	 * 接口请求之前
	 * @param info	接口信息
	 * @param context	脚本变量信息
	 */
	@Override
	public Object preHandle(ApiInfo info, MagicScriptContext context, MagicHttpServletRequest request, MagicHttpServletResponse response) throws Exception {
		LoginUser user = SecurityUtils.getLoginUser();
		log.info("{} 请求接口：{}", user, info.getName());
		// 接口选项配置了需要登录
		if ("true".equals(info.getOptionValue(Options.REQUIRE_LOGIN))) {
			if (user == null) {
				return new JsonBean<>(401, "用户未登录");
			}
		}
		String role = info.getOptionValue(Options.ROLE);
//		if (StringUtils.isNotEmpty(role) && user.getUser().hasRole(role)) {
//			return new JsonBean<>(403, "用户权限不足");
//		}
//		String permission = info.getOptionValue(Options.PERMISSION);
//		if (StringUtils.isNotBlank(permission) && user.hasPermission(permission)) {
//			return new JsonBean<>(403, "用户权限不足");
//		}
		return null;
	}

	/**
	 * 接口执行之后
	 * @param info	接口信息
	 * @param context	变量信息
	 * @param value 即将要返回到页面的值
	 */
	@Override
	public Object postHandle(ApiInfo info, MagicScriptContext context, Object value, MagicHttpServletRequest request, MagicHttpServletResponse response) throws Exception {
		log.info("{} 执行完毕，返回结果:{}", info.getName(), value);
		return null;
	}
}