package com.Grownited.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.Grownited.entity.UserEntity;
import com.Grownited.repository.NotificationRepository;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@ControllerAdvice
public class GlobalController {

	@Autowired
	NotificationRepository notificationRepository;

	@ModelAttribute
	public void addNotifCount(HttpSession session, Model model) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		if (user != null) {
			long notifCount = notificationRepository.countByUserUserIdAndIsReadFalse(user.getUserId());

			model.addAttribute("notifCount", notifCount);
		}
	}

	@ExceptionHandler(MaxUploadSizeExceededException.class)
	public String handleMaxSizeException(MaxUploadSizeExceededException exc, HttpServletRequest request,
			RedirectAttributes ra) {
		ra.addFlashAttribute("error", "File too large! Maximum allowed size is 55MB per file and 60MB per request.");
		String referer = request.getHeader("Referer");
		return "redirect:" + (referer != null ? referer : "/participant/submissions");
	}
}
