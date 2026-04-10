package com.Grownited.service;

import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class RateLimiterService {

    // Action -> IP -> LastTimestamp
    private final Map<String, Map<String, Long>> actionLimitMap = new ConcurrentHashMap<>();
    
    // Default cooldown: 1 minute
    private static final long DEFAULT_COOLDOWN_MS = 60000;

    /**
     * Checks if the given IP is allowed to perform the specified action.
     * @param ip The IP address of the requester.
     * @param action The sensitive action key (e.g. "AUTH", "RESET_PWD").
     * @return true if allowed, false if throttled.
     */
    public boolean isAllowed(String ip, String action) {
        return isAllowed(ip, action, DEFAULT_COOLDOWN_MS);
    }

    public boolean isAllowed(String ip, String action, long cooldownMs) {
        Map<String, Long> ipMap = actionLimitMap.computeIfAbsent(action, k -> new ConcurrentHashMap<>());
        Long lastTime = ipMap.get(ip);
        
        if (lastTime != null && (System.currentTimeMillis() - lastTime < cooldownMs)) {
            return false;
        }
        return true;
    }

    /**
     * Records an attempt for the given IP and action.
     */
    public void recordAttempt(String ip, String action) {
        Map<String, Long> ipMap = actionLimitMap.computeIfAbsent(action, k -> new ConcurrentHashMap<>());
        ipMap.put(ip, System.currentTimeMillis());
    }
}
