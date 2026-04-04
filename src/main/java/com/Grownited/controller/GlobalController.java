package com.Grownited.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.Grownited.entity.UserEntity;
import com.Grownited.repository.NotificationRepository;

import jakarta.servlet.http.HttpSession;

@ControllerAdvice
public class GlobalController {

    @Autowired
    NotificationRepository notificationRepository;

    @ModelAttribute
    public void addNotifCount(HttpSession session, Model model) {

        UserEntity user = (UserEntity) session.getAttribute("user");

        if (user != null) {
            long notifCount = notificationRepository
                    .countByUserUserIdAndIsReadFalse(user.getUserId());

            model.addAttribute("notifCount", notifCount);
        }
    }
}
