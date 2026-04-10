package com.Grownited.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.Grownited.entity.HackathonEntity;
import com.Grownited.entity.HackathonRegistrationEntity;
import com.Grownited.repository.HackathonRegistrationRepository;
import com.Grownited.repository.HackathonRepository;

@Service
public class ReminderService {

	@Autowired
	private HackathonRepository hackathonRepository;

	@Autowired
	private HackathonRegistrationRepository registrationRepository;

	@Autowired
	private MailerService mailerService;

	// Runs every day at 09:00 AM
	@Scheduled(cron = "0 0 9 * * *")
	public void sendDailyReminders() {
		LocalDate tomorrow = LocalDate.now().plusDays(1);

		// 🚀 Reminders for Hackathons starting tomorrow
		List<HackathonEntity> startingTomorrow = hackathonRepository.findHackathonsStartingOn(tomorrow);
		for (HackathonEntity h : startingTomorrow) {
			List<HackathonRegistrationEntity> registrations = registrationRepository.findByHackathon_HackathonId(h.getHackathonId());
			for (HackathonRegistrationEntity reg : registrations) {
				mailerService.sendHackathonReminderMail(reg.getUser(), h, "HACKATHON_START");
			}
		}

		// ⏰ Reminders for Submission Deadlines tomorrow
		List<HackathonEntity> deadlinesTomorrow = hackathonRepository.findHackathonsWithDeadlineOn(tomorrow);
		for (HackathonEntity h : deadlinesTomorrow) {
			List<HackathonRegistrationEntity> registrations = registrationRepository.findByHackathon_HackathonId(h.getHackathonId());
			for (HackathonRegistrationEntity reg : registrations) {
				mailerService.sendHackathonReminderMail(reg.getUser(), h, "SUBMISSION_DEADLINE");
			}
		}
	}
}
