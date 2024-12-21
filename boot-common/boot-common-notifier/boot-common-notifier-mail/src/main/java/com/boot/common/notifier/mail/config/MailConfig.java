package com.boot.common.notifier.mail.config;

import cn.hutool.core.util.StrUtil;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.Objects;
import java.util.Properties;

@Component
@ConditionalOnProperty(prefix = "boot.mail", name = "enabled", havingValue = "true")
public class MailConfig {

    @Resource
    private MailProperties mailProperties;

    public String getFrom() {
        return mailProperties.getFrom();
    }

    public JavaMailSender getMailSender(String username, String password) {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost(mailProperties.getHost());
        mailSender.setPort(mailProperties.getPort());

        mailSender.setUsername(StrUtil.blankToDefault(username, mailProperties.getFrom()));
        mailSender.setPassword(StrUtil.blankToDefault(password, mailProperties.getPassword()));

        Properties props = mailSender.getJavaMailProperties();
        // starttls.enable = true 时为 smtps
        if (Objects.nonNull(mailProperties.getStarttlsEnable()) && mailProperties.getStarttlsEnable()) {
            props.put("mail.transport.protocol", "smtps");
        } else {
            props.put("mail.transport.protocol", "smtp");
        }
        props.put("mail.smtp.auth", mailProperties.getAuth());
        props.put("mail.smtp.starttls.enable", mailProperties.getStarttlsEnable());
        props.put("mail.smtp.ssl.trust", mailProperties.getSslTrust());
        props.put("mail.debug", "true");

        return mailSender;
    }

}
