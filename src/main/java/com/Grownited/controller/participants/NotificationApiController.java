package com.Grownited.controller.participants;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.Grownited.dto.NotificationDTO;
import com.Grownited.entity.NotificationEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.repository.NotificationRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class NotificationApiController {

	@Autowired
	NotificationRepository notificationRepository;

	@GetMapping("/participant/notifications/data")
	public String notificationData(HttpSession session, Model model) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		List<NotificationEntity> notifications = notificationRepository
				.findTop5ByUserUserIdOrderByCreatedAtDesc(user.getUserId());

		// 🔥 Convert Entity → DTO
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy • hh:mm a");

		List<NotificationDTO> dtoList = notifications.stream().map(n -> {
			NotificationDTO dto = new NotificationDTO();
			dto.setId(n.getNotificationId());
			dto.setMessage(n.getMessage());
			dto.setRead(n.isRead());
			dto.setRedirectUrl(n.getRedirectUrl());
			dto.setType(n.getType());
			dto.setFormattedDate(n.getCreatedAt().format(formatter));
			return dto;
		}).collect(Collectors.toList());

		model.addAttribute("notifications", dtoList);

		return "participants/notification-drawer";
	}

	@GetMapping("/participant/notification/read")
	public String readNotification(@RequestParam("id") Integer notificationId, HttpSession session) {

		NotificationEntity n = notificationRepository.findById(notificationId).orElse(null);

		if (n != null) {
			n.setRead(true);
			notificationRepository.save(n);

			// 🔥 Smart Redirect
			if (n.getRedirectUrl() != null && !n.getRedirectUrl().isEmpty()) {
				return "redirect:" + n.getRedirectUrl();
			}
		}

		return "redirect:/participant/notifications";
	}

	@GetMapping("/participant/notifications/mark-all-read")
	public String markAllAsRead(HttpSession session) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		if (user != null) {
			List<NotificationEntity> unread = notificationRepository.findByUserUserIdAndIsReadFalse(user.getUserId());

			for (NotificationEntity n : unread) {
				n.setRead(true);
			}

			notificationRepository.saveAll(unread);
		}

		return "redirect:/participant/notifications";
	}
}