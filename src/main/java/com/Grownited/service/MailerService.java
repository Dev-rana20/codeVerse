package com.Grownited.service;

import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
//import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;
import com.CodeVerseApplication;
import com.Grownited.entity.UserEntity;

import jakarta.mail.internet.MimeMessage;

@Service
public class MailerService {

	@Autowired
	JavaMailSender javaMailSender;

	@Autowired
	ResourceLoader resourceLoader;

	MailerService(CodeVerseApplication codeVerseApplication) {
	}
//	
//	public void sendWalcomeMail(UserEntity user) {
//		SimpleMailMessage message= new SimpleMailMessage();
//		
//		
//		message.setTo(user.getEmail());
//		message.setFrom("devr202004@gmail.com");
//		message.setSubject("CodeVerse - Welcome to CodeVerse Online Hackathon PlatForm !!!");
//		message.setText("Hey "+ user.getFirstName()+" , WE ARE HAPPY TO HAVE YOU ON OUR PLATFORM.");
//		
//		javaMailSender.send(message);
//		
//	}

	public void sendWalcomeMail(UserEntity user) {
		MimeMessage message = javaMailSender.createMimeMessage();

		Resource resource = resourceLoader.getResource("classpath:templates/WelcomeMailTemplate.html");

		try {

			String html = new String(resource.getInputStream().readAllBytes(), StandardCharsets.UTF_8);

			MimeMessageHelper helper;

			String body = html.replace("${name}", user.getFirstName()).replace("${email}", user.getEmail())
					.replace("${loginUrl}", "http://localhost:9999/login").replace("${companyName}", "CodeVerse").replace("${year}","2026");
			helper = new MimeMessageHelper(message, true);
			helper.setTo(user.getEmail());
			helper.setSubject("CodeVerse - Welcome Aboard !!!");
			helper.setText(body, true);

			javaMailSender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
