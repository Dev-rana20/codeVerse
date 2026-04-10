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

import com.Grownited.entity.HackathonEntity;
import com.Grownited.entity.HackathonTeamEntity;
import com.Grownited.entity.SubmissionEntity;

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

	public void sendTeamInviteMail(UserEntity invitee, HackathonTeamEntity team) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(invitee.getEmail());
		message.setSubject("CodeVerse - Team Invitation");
		message.setText("Hello " + invitee.getFirstName() + ",\n\n" + "You have been invited to join the team \""
				+ team.getTeamName() + "\" for the hackathon \"" + team.getHackathon().getTitle() + "\".\n\n"
				+ "Login to CodeVerse to accept or reject the invitation: http://localhost:9999/login");
		javaMailSender.send(message);
	}

	public void sendInviteAcceptedMail(UserEntity leader, UserEntity member, HackathonTeamEntity team) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(leader.getEmail());
		message.setSubject("CodeVerse - Invitation Accepted");
		message.setText("Hello " + leader.getFirstName() + ",\n\n" + member.getFirstName() + " (" + member.getEmail()
				+ ") has accepted your invitation to join team \"" + team.getTeamName() + "\".");
		javaMailSender.send(message);
	}

	public void sendSubmissionConfirmationMail(UserEntity uploader, HackathonTeamEntity team,
			SubmissionEntity submission) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(uploader.getEmail());
		message.setSubject("CodeVerse - Submission Confirmation");
		message.setText("Hello " + uploader.getFirstName() + ",\n\n" + "Your submission for team \""
				+ team.getTeamName() + "\" has been successfully received.\n\n" + "Type: " + submission.getType()
				+ "\n" + "Description: " + submission.getDescription() + "\n\n" + "You can view your submission details on the CodeVerse dashboard.");
		javaMailSender.send(message);
	}

	public void sendHackathonReminderMail(UserEntity user, HackathonEntity hackathon, String reminderType) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(user.getEmail());
		message.setSubject("CodeVerse - " + reminderType + " Reminder");

		String content = reminderType.equals("HACKATHON_START")
				? "Get ready! The hackathon \"" + hackathon.getTitle() + "\" starts tomorrow."
				: "Clock is ticking! The submission deadline for \"" + hackathon.getTitle() + "\" is tomorrow.";

		message.setText("Hello " + user.getFirstName() + ",\n\n" + content + "\n\n"
				+ "Visit the dashboard for more details: http://localhost:9999/login");
		javaMailSender.send(message);
	}
}
