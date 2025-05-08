package com.boot.common.web.config;

import com.boot.common.core.config.BootConfig;
import com.boot.common.core.constant.Constants;
import com.boot.common.web.interceptor.RepeatSubmitInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.CacheControl;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;
import org.springframework.web.servlet.config.annotation.*;

import java.util.concurrent.TimeUnit;

/**
 * 通用配置
 *
 * @author boot
 */
@Configuration
public class ResourcesConfig implements WebMvcConfigurer {
    @Autowired
    private RepeatSubmitInterceptor repeatSubmitInterceptor;

    @Override
    public void configureAsyncSupport(AsyncSupportConfigurer configurer) {
        // 设置默认异步请求超时为60秒
        configurer.setDefaultTimeout(60000);
    }


    /**
     * 自定义拦截规则
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(repeatSubmitInterceptor).addPathPatterns("/**");
    }

    /**
     * 跨域配置
     */
    @Bean
    public CorsFilter corsFilter() {
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowCredentials(true);
        // 设置访问源地址
        config.addAllowedOriginPattern("*");
        // 设置访问源请求头
        config.addAllowedHeader("*");
        // 设置访问源请求方法
        config.addAllowedMethod("*");
        // 有效期 1800秒
        config.setMaxAge(1800L);
        // 添加映射路径，拦截一切请求
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);
        // 返回新的CorsFilter
        return new CorsFilter(source);
    }


    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        /** 本地文件上传路径 */
        registry.addResourceHandler(Constants.RESOURCE_PREFIX + "/**")
                .addResourceLocations("file:" + BootConfig.getProfile() + "/");

        /** swagger配置 */
        registry.addResourceHandler("/swagger-ui/**")
                .addResourceLocations("classpath:/META-INF/resources/webjars/springfox-swagger-ui/")
                .setCacheControl(CacheControl.maxAge(5, TimeUnit.HOURS).cachePublic());


        // 处理WebJar中的静态资源
        registry.addResourceHandler("/webjars/**")
                .addResourceLocations("classpath:/META-INF/resources/webjars/");

        // 处理static目录下的资源
        registry.addResourceHandler("/static/**")
                .addResourceLocations(
                        "classpath:/META-INF/resources/webjars/static/",
                        "classpath:/static/");

        // 处理js目录下的资源
        registry.addResourceHandler("/js/**")
                .addResourceLocations("classpath:/META-INF/resources/webjars/static/js/");

        // 处理css目录下的资源
        registry.addResourceHandler("/css/**")
                .addResourceLocations("classpath:/META-INF/resources/webjars/static/css/");

        // 处理其他静态资源，确保所有路径都能被正确映射
        registry.addResourceHandler("/**")
                .addResourceLocations(
                        "classpath:/META-INF/resources/webjars/static/",
                        "classpath:/META-INF/resources/webjars/",
                        "classpath:/META-INF/resources/",
                        "classpath:/resources/",
                        "classpath:/static/",
                        "classpath:/public/");
    }

    /**
     * 添加视图控制器，将根路径请求映射到index.html
     */
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // 将根路径请求映射到index.html
        registry.addViewController("/").setViewName("forward:/index.html");
    }

}
