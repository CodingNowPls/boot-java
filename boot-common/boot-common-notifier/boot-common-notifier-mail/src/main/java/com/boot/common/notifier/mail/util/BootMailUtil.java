package com.boot.common.notifier.mail.util;

import com.boot.common.notifier.mail.config.MailConfig;
import com.boot.common.notifier.mail.config.MailProperties;
import com.boot.common.core.utils.spring.SpringUtils;
import org.springframework.mail.SimpleMailMessage;

/**
 * @author : gao
 * @date 2024年12月18日
 * -------------------------------------------<br>
 * <br>
 * <br>
 */

public class BootMailUtil {

    /**
     * 发送邮件
     *
     * @param subject
     * @param text
     */
    public static void sendSimpleMessage(String subject, String text) {
        MailConfig mailConfig = SpringUtils.getBean(MailConfig.class);
        MailProperties mailProperties = SpringUtils.getBean(MailProperties.class);
        SimpleMailMessage message = new SimpleMailMessage();
        // 邮件发送人
        message.setFrom(mailConfig.getFrom());
        // 邮件接收人（可以使用 String[] 发送给多个用户）
        message.setTo(mailProperties.getTo());
        // 邮件标题
        message.setSubject(subject);
        // 邮件内容
        message.setText(text);
        // 发送邮件
        mailConfig.getMailSender(mailProperties.getFrom(), mailProperties.getPassword()).send(message);
    }
}
