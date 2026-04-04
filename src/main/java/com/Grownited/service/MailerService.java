package com.Grownited.service;

import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
//import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;
import com.Grownited.entity.UserEntity;

import jakarta.mail.internet.MimeMessage;

@Service
public class MailerService {

	@Autowired
	JavaMailSender javaMailSender;

	@Autowired
	ResourceLoader resourceLoader;
	
	@Autowired
	OtpService otpService;

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
	
	 public void sendOtp(String email, String otp) {

	        SimpleMailMessage message = new SimpleMailMessage();

	        message.setTo(email);
	        message.setSubject("Password Reset OTP");
	        message.setText("Your OTP is: " + otp);

	        javaMailSender.send(message);
	    }
	 
	 public void sendJudgeInviteMail(String email, String password) {

		    SimpleMailMessage message = new SimpleMailMessage();

		    message.setTo(email);
		    message.setSubject("CodeVerse - Judge Invitation");

		    message.setText(
		        "You have been invited as a Judge on CodeVerse.\n\n"
		        + "Login Credentials:\n"
		        + "Email: " + email + "\n"
		        + "Password: " + password + "\n\n"
		        + "Login here: http://localhost:9999/login\n"
		        + "Please change your password after first login."
		    );

		    javaMailSender.send(message);
		}

}
