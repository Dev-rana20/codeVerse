package com.Grownited.filter;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Component;

import com.Grownited.entity.UserEntity;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * AuthFilter — enforces authentication AND role-based access control (RBAC).
 *
 * Route categories
 * ──────────────────────────────────────────────────────────────────────────
 *  PUBLIC       → no session required
 *  ADMIN-only   → role must be "ADMIN"
 *  JUDGE-only   → role must be "JUDGE"
 *  Authenticated → any valid session (ADMIN / JUDGE / PARTICIPANT)
 * ──────────────────────────────────────────────────────────────────────────
 */
@Component
public class AuthFilter implements Filter {

    // ── Public routes (no login required) ────────────────────────────────
    private static final List<String> PUBLIC_URLS = List.of(
        "/login",
        "/signup",
        "/register",
        "/authenticate",
        "/forgetPassword",
        "/resetPassword",
        "/verifyOtp",
        "/updatePassword",
        "/"
    );

    // ── Admin-only route prefixes ─────────────────────────────────────────
    // Any URI that *starts with* one of these strings requires ADMIN role.
    private static final List<String> ADMIN_PREFIXES = List.of(
        "/admin-dashboard",
        "/admin/",          // covers /admin/invite-judge, /admin/assign-judge, …
        "/listHackathon",
        "/newHackathon",
        "/saveHackathon",
        "/deleteHackathon",
        "/addHackathonDescription",
        "/saveHackathonDescription",
        "/editHackathon",
        "/updateHackathon"
    );

    // ── Judge-only route prefixes ─────────────────────────────────────────
    private static final List<String> JUDGE_PREFIXES = List.of(
        "/judge/dashboard",
        "/judge/complete-profile",
        "/judge/view-teams",
        "/judge/evaluate",
        "/judge/submit-evaluation"
    );

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req = (HttpServletRequest)  request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        // 1. Always allow static assets and public pages ──────────────────
        if (isPublic(uri)) {
            // Special Case: /register is ONLY public for POST (signup), not GET (which could clash)
            if (uri.equals("/register") && !req.getMethod().equalsIgnoreCase("POST")) {
                // fall through to check authentication
            } else {
                chain.doFilter(request, response);
                return;
            }
        }

        // 2. Require authentication ────────────────────────────────────────
        HttpSession session = req.getSession(false);
        UserEntity  user    = (session != null)
                              ? (UserEntity) session.getAttribute("user")
                              : null;

        if (user == null) {
            res.sendRedirect("/login");
            return;
        }

        // ── Security Cache Headers for Authenticated Pages ──
        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        res.setHeader("Pragma", "no-cache");
        res.setHeader("Expires", "0");


        String role = (user.getRole() != null) ? user.getRole() : "";

        // 3. Admin-only routes ────────────────────────────────────────────
        if (isAdminRoute(uri)) {
            if (!"ADMIN".equalsIgnoreCase(role)) {
                res.sendRedirect("/login?access=denied");
                return;
            }
        }

        // 4. Judge-only routes ────────────────────────────────────────────
        else if (isJudgeRoute(uri)) {
            if (!"JUDGE".equalsIgnoreCase(role) && !"ADMIN".equalsIgnoreCase(role)) {
                res.sendRedirect("/login?access=denied");
                return;
            }
        }

        // 5. Authenticated — allow any valid role to proceed ──────────────
        chain.doFilter(request, response);
    }

    // ── Helpers ───────────────────────────────────────────────────────────

    private boolean isPublic(String uri) {
        if (uri.contains("/assets/") || uri.contains("/css/") ||
            uri.contains("/js/")     || uri.contains("/images/") ||
            uri.contains("/favicon")) {
            return true;
        }
        for (String pub : PUBLIC_URLS) {
            if (uri.equals(pub) || uri.startsWith(pub + "?")) {
                return true;
            }
        }
        return false;
    }

    private boolean isAdminRoute(String uri) {
        for (String prefix : ADMIN_PREFIXES) {
            if (uri.equals(prefix) || uri.startsWith(prefix)) {
                return true;
            }
        }
        return false;
    }

    private boolean isJudgeRoute(String uri) {
        for (String prefix : JUDGE_PREFIXES) {
            if (uri.equals(prefix) || uri.startsWith(prefix)) {
                return true;
            }
        }
        return false;
    }
}

