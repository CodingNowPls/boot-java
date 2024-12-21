package com.boot;

import com.github.jeffreyning.mybatisplus.conf.EnableMPP;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.ApplicationContext;
import org.springframework.core.env.Environment;

/**
 * 启动程序
 *
 * @author boot
 */
@EnableMPP
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
public class BootApplication {

    public static void main(String[] args) {
        ApplicationContext context = SpringApplication.run(BootApplication.class, args);
        Environment environment = context.getEnvironment();
        String serverPort = environment.getProperty("server.port");

        System.out.println("boot 启动成功  \n");
        System.out.println("前后端合并打包访问  \n");
        System.out.println("http://localhost:" + serverPort);
    }
}
