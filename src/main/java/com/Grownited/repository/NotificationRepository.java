package com.Grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Grownited.entity.NotificationEntity;

public interface NotificationRepository 
        extends JpaRepository<NotificationEntity, Integer>{

    List<NotificationEntity> findByUserUserIdOrderByCreatedAtDesc(Integer userId);

    long countByUserUserIdAndIsReadFalse(Integer userId);
    
    List<NotificationEntity>
    findTop5ByUserUserIdOrderByCreatedAtDesc(Integer userId);

    List<NotificationEntity> findByUserUserIdAndIsReadFalse(Integer userId);
}