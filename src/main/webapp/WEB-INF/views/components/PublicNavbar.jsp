<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    /* ── Public Navbar Overrides ── */
    .pub-nav { position: sticky; top: 0; z-index: 300; height: 64px; display: flex; align-items: center; background: color-mix(in srgb, var(--bg-base), transparent 15%); backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px); border-bottom: 1px solid var(--border); }
    .pub-nav__inner { width: 100%; max-width: 1280px; margin: 0 auto; display: flex; align-items: center; justify-content: space-between; padding: 0 28px; gap: 24px; }
    .pub-nav__brand { font-family: var(--font-mono); font-size: 1.1rem; font-weight: 700; color: var(--accent); letter-spacing: -0.5px; text-decoration: none; white-space: nowrap; }
    .pub-nav__brand span { color: var(--text-primary); }
    .pub-nav__links { display: flex; align-items: center; gap: 28px; }
    .pub-nav__link { font-family: var(--font-mono); font-size: 0.78rem; font-weight: 600; color: #71717a; text-decoration: none; letter-spacing: 0.04em; transition: color 0.2s ease; }
    .pub-nav__link:hover { color: var(--accent); }
    .pub-nav__sep { width: 1px; height: 22px; background: rgba(255,255,255,0.08); }
    .pub-nav__actions { display: flex; align-items: center; gap: 10px; }
    .pub-nav__login { font-family: var(--font-mono); font-size: 0.78rem; font-weight: 600; color: #a1a1aa; text-decoration: none; padding: 8px 18px; border: 1px solid rgba(255,255,255,0.1); border-radius: 8px; transition: all 0.2s ease; }
    .pub-nav__login:hover { color: #fff; border-color: rgba(255,255,255,0.25); background: rgba(255,255,255,0.04); }
    .pub-nav__signup { font-family: var(--font-mono); font-size: 0.78rem; font-weight: 700; color: #000; background: var(--accent); padding: 8px 18px; border-radius: 8px; text-decoration: none; transition: all 0.2s ease; }
    .pub-nav__signup:hover { background: #00d4b8; color: #000; box-shadow: 0 0 20px rgba(0,255,224,0.3); }
    @media (max-width: 640px) {
        .pub-nav__links { display: none; }
        .pub-nav__sep  { display: none; }
    }
</style>

<nav class="pub-nav" role="navigation" aria-label="Main navigation">
    <div class="pub-nav__inner">
        <%-- Brand --%>
        <a href="<c:url value='/'/>" class="pub-nav__brand">CODE<span>VERSE</span></a>

        <%-- Nav Links --%>
        <div class="pub-nav__links">
            <a href="#discovery" class="pub-nav__link">Discover</a>
            <a href="<c:url value='/faq'/>" class="pub-nav__link">FAQ</a>
            <a href="<c:url value='/contact'/>" class="pub-nav__link">Contact</a>
        </div>

        <%-- Auth Actions --%>
        <div class="pub-nav__sep"></div>
        <div class="pub-nav__actions">
            <%-- Theme Toggle --%>
            <button class="pub-nav__login" data-cv-theme-toggle title="Toggle Theme" style="padding: 8px 12px;" aria-label="Toggle Light and Dark Mode">
                <i class="bi bi-moon-stars-fill show-dark" aria-hidden="true"></i>
                <i class="bi bi-sun-fill show-light" aria-hidden="true"></i>
            </button>
            <a href="<c:url value='/login'/>" class="pub-nav__login">Login</a>
            <a href="<c:url value='/signup'/>" class="pub-nav__signup">Sign Up</a>
        </div>
    </div>
</nav>
