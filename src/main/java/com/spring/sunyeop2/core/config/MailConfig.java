package com.spring.sunyeop2.core.config;

import java.util.Properties;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Slf4j
@Configuration
public class MailConfig {

	@Value("${spring.mail.host}")
	private String mailHost;

	@Value("${spring.mail.username}")
	private String mailUsername;

	@Value("${spring.mail.password}")
	private String mailPwd;

	@Bean
	public JavaMailSender mailSender(){
  		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
  		mailSender.setHost(mailHost);
  		mailSender.setUsername(mailUsername);
  		mailSender.setPassword(mailPwd);
  		Properties prop = new Properties();
  		prop.put("mail.smtp.auth", "true");
  		prop.put("mail.smtp.debug", "true");
  		prop.put("mail.smtp.starttls.enable", "true");
  		prop.put("mail.smtp.EnableSSL.enable", "true");
  		mailSender.setJavaMailProperties(prop);
  		return mailSender;


  
  		


  
  	}
	
}
