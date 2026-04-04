package com.Grownited.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Grownited.entity.NotificationEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.repository.NotificationRepository;

@Service
public class NotificationService {

    @Autowired
    NotificationRepository notificationRepository;

    public void createNotification(
            UserEntity user,
            String message,
            String type,
            String redirectUrl) {

        NotificationEntity n = new NotificationEntity();

        n.setUser(user);
        n.setMessage(message);
        n.setType(type);
        n.setRedirectUrl(redirectUrl);

        notificationRepository.save(n);
    }
}