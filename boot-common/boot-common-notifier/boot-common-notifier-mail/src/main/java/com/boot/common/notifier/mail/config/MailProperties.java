package com.boot.common.notifier.mail.config;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Component;

/**
 * @author gao
 */
@Data
@Component
@ConditionalOnProperty(name = "boot.mail.enabled", havingValue = "true")
public class MailProperties {

    @Value("${boot.mail.host}")
    private String host;

    @Value("${boot.mail.password}")
    private String password;
    @Value("${boot.mail.from}")
    private String from;
    @Value("${boot.mail.port}")
    private Integer port;

    @Value("${boot.mail.properties.mail.smtp.auth}")
    private Boolean auth;

    @Value("${boot.mail.properties.mail.smtp.starttls.enable}")
    private Boolean starttlsEnable;

    @Value("${boot.mail.properties.mail.smtp.ssl.trust}")
    private String sslTrust;

    @Value("#{'${boot.mail.to}'.split(',')}")
    private String[] to;

}
