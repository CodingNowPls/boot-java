package com.boot.common.security.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.TimeUnit;
import java.util.stream.Stream;

import cn.dev33.satoken.exception.NotLoginException;
import com.alibaba.fastjson2.JSON;
import com.boot.common.core.domain.AjaxResult;
import com.boot.common.log.manager.AsyncManager;
import com.boot.common.log.manager.factory.AsyncFactory;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;

import cn.dev33.satoken.context.model.SaRequest;
import com.boot.common.core.cache.BootCache;
import com.boot.common.core.constant.CacheConstants;
import com.boot.common.core.constant.Constants;
import com.boot.common.core.utils.ServletUtils;
import com.boot.common.core.utils.StringUtils;
import com.boot.common.core.utils.ip.AddressUtils;
import com.boot.common.core.utils.ip.IpUtils;
import com.boot.common.core.utils.uuid.IdUtils;
import com.boot.common.security.core.domain.model.LoginUser;
import jakarta.servlet.http.HttpServletResponse;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import eu.bitwalker.useragentutils.UserAgent;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * token验证处理
 *
 * @author ruoyi
 */
@Component
public class TokenService {
    // 令牌自定义标识
    @Getter
    @Value("${token.header}")
    private String header;

    // 令牌秘钥
    @Value("${token.secret}")
    private String secret;

    // 令牌有效期（默认30分钟）
    @Value("${token.expireTime}")
    private int expireTime;

    protected static final long MILLIS_SECOND = 1000;

    protected static final long MILLIS_MINUTE = 60 * MILLIS_SECOND;

    private static final Long MILLIS_MINUTE_TEN = 20 * 60 * 1000L;

    @Autowired
    private BootCache bootChche;

    /**
     * 获取用户身份信息
     *
     * @return 用户信息
     */
    public LoginUser getLoginUser(HttpServletRequest request) {
        // 获取请求携带的令牌
        String token = getToken(request);
        if (StringUtils.isNotEmpty(token)) {
            Claims claims = parseToken(token);
            // 解析对应的权限以及用户信息
            String uuid = (String) claims.get(Constants.LOGIN_USER_KEY);
            String userKey = getTokenKey(uuid);
            LoginUser user = bootChche.getCacheObject(userKey);
            return user;
        }
        return null;
    }

    /**
     * 加这个方法即可
     *
     * @return 用户信息
     */
    public LoginUser getLoginUserByCookie() {
        // 获取请求携带的令牌
        Cookie[] cookies = ServletUtils.getRequest().getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("Admin-Token") || cookie.getName().equals(Constants.TOKEN)) {
                    String authorization = cookie.getValue();
                    Claims claims = parseToken(authorization);
                    String uuid = (String) claims.get(Constants.LOGIN_USER_KEY);
                    String userKey = getTokenKey(uuid);
                    LoginUser user = bootChche.getCacheObject(userKey);
                    return user;
                }
            }
        }
        return null;

    }


    public String getTokenByCookie() {
        // 获取请求携带的令牌
        Cookie[] cookies = ServletUtils.getRequest().getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("Admin-Token") || cookie.getName().equals(Constants.TOKEN)
                        || cookie.getName().equals("Token")) {
                    String authorization = cookie.getValue();
                    return authorization;
                }
            }
        }
        return null;
    }

    public void loginOut() {
        HttpServletRequest request = ServletUtils.getRequest();
        HttpServletResponse response = ServletUtils.getResponse();
        LoginUser loginUser = this.getLoginUser(request);
        if (StringUtils.isNotNull(loginUser)) {
            String userName = loginUser.getUserName();
            // 删除用户缓存记录
            this.delLoginUser(loginUser.getToken());
            // 记录用户退出日志
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(userName, Constants.LOGOUT, "退出成功"));
        }
        ServletUtils.renderString(response, JSON.toJSONString(AjaxResult.success("退出成功")));
    }

    /**
     * @Description: TODO
     * @author: wangming
     * @date: 根据共有的request去获取用户
     * @Return:
     */
    public LoginUser getLoginUser() {
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) requestAttributes;
        HttpServletRequest request = servletRequestAttributes.getRequest();
        return getLoginUser(request);
    }


    public LoginUser getLoginUser(SaRequest request) {
        //通过sarequest方式去获取header
        // 获取请求携带的令牌
        String token = getToken(request);
        if (StringUtils.isNotEmpty(token)) {
            Claims claims = parseToken(token);
            // 解析对应的权限以及用户信息
            String uuid = (String) claims.get(Constants.LOGIN_USER_KEY);
            String userKey = getTokenKey(uuid);
            LoginUser user = bootChche.getCacheObject(userKey);
            return user;
        }
        return null;
    }

    /**
     * 设置用户身份信息
     */
    public void setLoginUser(LoginUser loginUser) {
        if (StringUtils.isNotNull(loginUser) && StringUtils.isNotEmpty(loginUser.getToken())) {
            refreshToken(loginUser);
        }
    }

    /**
     * 删除用户身份信息
     */
    public void delLoginUser(String token) {
        if (StringUtils.isNotEmpty(token)) {
            String userKey = getTokenKey(token);
            bootChche.deleteObject(userKey);
        }
    }

    /**
     * 创建令牌
     *
     * @param loginUser 用户信息
     * @return 令牌
     */
    public String createToken(LoginUser loginUser) {
        String token = IdUtils.fastUUID();
        loginUser.setToken(token);
        setUserAgent(loginUser);
        refreshToken(loginUser);

        Map<String, Object> claims = new HashMap<>();
        claims.put(Constants.LOGIN_USER_KEY, token);
        return createToken(claims);
    }

    /**
     * 验证令牌有效期，相差不足20分钟，自动刷新缓存
     *
     * @param loginUser
     * @return 令牌
     */
    public void verifyToken(LoginUser loginUser) {
        long expireTime = loginUser.getExpireTime();
        long currentTime = System.currentTimeMillis();
        if (expireTime - currentTime <= MILLIS_MINUTE_TEN) {
            refreshToken(loginUser);
        }
    }


    public void verifyToken(String token) {
        if (StringUtils.isNotEmpty(token)) {
            Claims claims = parseToken(token);
            // 解析对应的权限以及用户信息
            String uuid = (String) claims.get(Constants.LOGIN_USER_KEY);
            String userKey = getTokenKey(uuid);
            LoginUser user = bootChche.getCacheObject(userKey);
            if (Objects.isNull(user)) {
                throw new RuntimeException("请从网站登录页登陆");
            }
            verifyToken(user);
        }
    }

    /**
     * 刷新令牌有效期
     *
     * @param loginUser 登录信息
     */
    public void refreshToken(LoginUser loginUser) {
        loginUser.setLoginTime(System.currentTimeMillis());
        loginUser.setExpireTime(loginUser.getLoginTime() + expireTime * MILLIS_MINUTE);
        // 根据uuid将loginUser缓存
        String userKey = getTokenKey(loginUser.getToken());
        bootChche.setCacheObject(userKey, loginUser, expireTime, TimeUnit.MINUTES);
    }

    /**
     * 设置用户代理信息
     *
     * @param loginUser 登录信息
     */
    public void setUserAgent(LoginUser loginUser) {
        UserAgent userAgent = UserAgent.parseUserAgentString(ServletUtils.getRequest().getHeader("User-Agent"));
        String ip = IpUtils.getIpAddr();
        loginUser.setIpaddr(ip);
        loginUser.setLoginLocation(AddressUtils.getRealAddressByIP(ip));
        loginUser.setBrowser(userAgent.getBrowser().getName());
        loginUser.setOs(userAgent.getOperatingSystem().getName());
    }

    /**
     * 从数据声明生成令牌
     *
     * @param claims 数据声明
     * @return 令牌
     */
    private String createToken(Map<String, Object> claims) {
        String token = Jwts.builder()
                .setClaims(claims)
                .signWith(SignatureAlgorithm.HS512, secret).compact();
        return token;
    }

    /**
     * 从令牌中获取数据声明
     *
     * @param token 令牌
     * @return 数据声明
     */
    public Claims parseToken(String token) {
        return Jwts.parser()
                .setSigningKey(secret)
                .parseClaimsJws(token)
                .getBody();
    }

    public LoginUser getLoginUserFromToken(String token) {
        if (StringUtils.isNotEmpty(token) && token.length() < 30) {
            token = null;
        }
        if (StringUtils.isEmpty(token)) {
            token = getToken(ServletUtils.getRequest());
            if (StringUtils.isNotEmpty(token) && token.length() < 30) {
                token = null;
            }
        }
        if (StringUtils.isEmpty(token)) {
            token = getTokenByCookie();
            if (StringUtils.isNotEmpty(token) && token.length() < 30) {
                token = null;
            }
        }

        if (StringUtils.isEmpty(token)) {
            return null;
        }

        Claims claims = parseToken(token);
        // 解析对应的权限以及用户信息
        String uuid = (String) claims.get(Constants.LOGIN_USER_KEY);
        String userKey = getTokenKey(uuid);
        LoginUser user = bootChche.getCacheObject(userKey);
        return user;
    }

    /**
     * 获取请求token
     * 只要有一个不为空就返回不为空的token
     *
     * @param request
     * @return token
     */
    public String getToken(HttpServletRequest request) {
        String token = request.getHeader(header);
        if (StringUtils.isNotEmpty(token) && token.length() >= 30) {
            if (token.startsWith(Constants.TOKEN_PREFIX)) {
                token = token.replace(Constants.TOKEN_PREFIX, "");
            }
            return token;
        }
        token = request.getParameter(Constants.TOKEN);
        if (StringUtils.isNotEmpty(token) && token.length() >= 30) {
            return token;
        }
        token = request.getParameter("Token");
        if (StringUtils.isNotEmpty(token) && token.length() >= 30) {
            return token;
        }
        token = request.getHeader("X-Access-Token");
        if (StringUtils.isNotEmpty(token) && token.length() >= 30) {
            if (token.startsWith(Constants.TOKEN_PREFIX)) {
                token = token.replace(Constants.TOKEN_PREFIX, "");
            }
            return token;
        }

        token = getTokenByCookie();
        if (Objects.nonNull(token) && token.length() >= 30) {
            return token;
        }

        return token;
    }


    /**
     * 获取请求token
     *
     * @param request
     * @return token
     */
    private String getToken(SaRequest request) {
        String token = request.getHeader(header);
        if (StringUtils.isNotEmpty(token) && token.startsWith(Constants.TOKEN_PREFIX)) {
            token = token.replace(Constants.TOKEN_PREFIX, "");
        }
        return token;
    }


    public String getTokenKey(String uuid) {
        return CacheConstants.LOGIN_TOKEN_KEY + uuid;
    }


    private String getToken(String token) {
        if (StringUtils.isNotEmpty(token) && token.startsWith(Constants.TOKEN_PREFIX)) {
            token = token.replace(Constants.TOKEN_PREFIX, "");
        }
        return token;
    }

}
