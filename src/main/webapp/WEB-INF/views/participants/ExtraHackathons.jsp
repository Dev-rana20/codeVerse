<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

			<!DOCTYPE html>
			<html lang="en">

			<head>
				<meta charset="UTF-8" />
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />
				<title>CodeVerse — ${hackathon.title}</title>

				<!-- Google Fonts -->
				<link rel="preconnect" href="https://fonts.googleapis.com" />
				<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
				<link
					href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap"
					rel="stylesheet" />

				<!-- Bootstrap 5 -->
				<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

				<!-- Bootstrap Icons -->
				<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
					rel="stylesheet" />

				<style>
					/* ───────────────────────────────────────
       CSS VARIABLES & RESET
    ─────────────────────────────────────── */
					:root {
						--bg-base: #090c12;
						--bg-card: #0f1420;
						--bg-card-hover: #141928;
						--border: rgba(255, 255, 255, 0.07);
						--accent: #00ffe0;
						--accent-dim: rgba(0, 255, 224, 0.12);
						--accent2: #7b5cff;
						--accent2-dim: rgba(123, 92, 255, 0.12);
						--danger: #ff4b6e;
						--danger-dim: rgba(255, 75, 110, 0.12);
						--warn: #ffb347;
						--success: #22c55e;
						--success-dim: rgba(34, 197, 94, 0.12);
						--text-primary: #e8eaf6;
						--text-muted: #6b7280;
						--font-display: 'Syne', sans-serif;
						--font-mono: 'Space Mono', monospace;
						--radius: 14px;
						--radius-sm: 8px;
						--transition: 0.22s cubic-bezier(.4, 0, .2, 1);
					}

					*,
					*::before,
					*::after {
						box-sizing: border-box;
						margin: 0;
						padding: 0;
					}

					html {
						scroll-behavior: smooth;
					}

					body {
						background: var(--bg-base);
						color: var(--text-primary);
						font-family: var(--font-display);
						min-height: 100vh;
						overflow-x: hidden;
					}

					/* noise overlay */
					body::before {
						content: '';
						position: fixed;
						inset: 0;
						background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.03'/%3E%3C/svg%3E");
						pointer-events: none;
						z-index: 0;
						opacity: 0.5;
					}

					/* ───────────────────────────────────────
       NAVBAR
    ─────────────────────────────────────── */
					.cv-navbar {
						position: sticky;
						top: 0;
						z-index: 100;
						background: rgba(9, 12, 18, 0.85);
						backdrop-filter: blur(18px);
						-webkit-backdrop-filter: blur(18px);
						border-bottom: 1px solid var(--border);
						padding: 0.75rem 0;
					}

					.cv-navbar .brand {
						font-family: var(--font-mono);
						font-size: 1.25rem;
						font-weight: 700;
						color: var(--accent);
						letter-spacing: -0.5px;
						text-decoration: none;
					}

					.cv-navbar .brand span {
						color: var(--text-primary);
					}

					.nav-link-cv {
						color: var(--text-muted) !important;
						font-size: 0.85rem;
						font-weight: 600;
						letter-spacing: 0.04em;
						text-transform: uppercase;
						transition: color var(--transition);
						padding: 0.4rem 0.8rem !important;
					}

					.nav-link-cv:hover {
						color: var(--accent) !important;
					}

					.avatar-btn {
						width: 36px;
						height: 36px;
						border-radius: 50%;
						border: 2px solid var(--accent);
						overflow: hidden;
						cursor: pointer;
						transition: box-shadow var(--transition);
					}

					.avatar-btn:hover {
						box-shadow: 0 0 0 3px var(--accent-dim);
					}

					.avatar-btn img {
						width: 100%;
						height: 100%;
						object-fit: cover;
					}

					/* ───────────────────────────────────────
       BACK BAR
    ─────────────────────────────────────── */
					.back-bar {
						padding: 0.9rem 0;
						border-bottom: 1px solid var(--border);
					}

					.back-link {
						display: inline-flex;
						align-items: center;
						gap: 0.45rem;
						font-family: var(--font-mono);
						font-size: 0.78rem;
						font-weight: 700;
						color: var(--text-muted);
						text-decoration: none;
						letter-spacing: 0.05em;
						transition: color var(--transition);
					}

					.back-link:hover {
						color: var(--accent);
					}

					/* ───────────────────────────────────────
       HERO
    ─────────────────────────────────────── */
					.cv-detail-hero {
						position: relative;
						padding: 3rem 0 2.5rem;
						overflow: hidden;
					}

					.cv-detail-hero::after {
						content: '';
						position: absolute;
						top: -100px;
						right: -150px;
						width: 600px;
						height: 600px;
						border-radius: 50%;
						background: radial-gradient(circle, rgba(123, 92, 255, 0.07) 0%, transparent 70%);
						pointer-events: none;
					}

					.hero-title {
						font-size: clamp(1.8rem, 5vw, 3rem);
						font-weight: 800;
						letter-spacing: -0.04em;
						line-height: 1.1;
						margin-bottom: 0.8rem;
					}

					.hero-desc {
						font-size: 0.95rem;
						color: var(--text-muted);
						max-width: 680px;
						line-height: 1.65;
						margin-bottom: 1.4rem;
					}

					/* chip strip */
					.chip-strip {
						display: flex;
						flex-wrap: wrap;
						gap: 0.45rem;
						margin-bottom: 1.6rem;
					}

					.chip {
						display: inline-flex;
						align-items: center;
						gap: 0.3rem;
						font-family: var(--font-mono);
						font-size: 0.65rem;
						font-weight: 700;
						letter-spacing: 0.07em;
						text-transform: uppercase;
						padding: 0.25rem 0.65rem;
						border-radius: 20px;
						background: rgba(255, 255, 255, 0.05);
						border: 1px solid var(--border);
						color: var(--text-muted);
					}

					.chip.status-open {
						background: var(--accent-dim);
						border-color: rgba(0, 255, 224, 0.2);
						color: var(--accent);
					}

					.chip.status-live {
						background: rgba(0, 180, 255, 0.12);
						border-color: rgba(0, 180, 255, 0.2);
						color: #00b4ff;
					}

					.chip.status-closed {
						background: rgba(255, 255, 255, 0.05);
						color: var(--text-muted);
					}

					.chip.status-upcoming {
						background: var(--accent2-dim);
						border-color: rgba(123, 92, 255, 0.2);
						color: var(--accent2);
					}

					.chip.chip-free {
						background: var(--success-dim);
						border-color: rgba(34, 197, 94, 0.2);
						color: var(--success);
					}

					.chip.chip-paid {
						background: rgba(255, 179, 71, 0.12);
						border-color: rgba(255, 179, 71, 0.2);
						color: var(--warn);
					}

					.chip .dot {
						width: 5px;
						height: 5px;
						border-radius: 50%;
						background: currentColor;
					}

					.chip.status-live .dot {
						animation: pulse-dot 1.2s ease-in-out infinite;
					}

					@keyframes pulse-dot {

						0%,
						100% {
							opacity: 1
						}

						50% {
							opacity: 0.3
						}
					}

					/* ───────────────────────────────────────
       ALERT MESSAGES
    ─────────────────────────────────────── */
					.cv-alert {
						display: flex;
						align-items: flex-start;
						gap: 0.65rem;
						padding: 0.85rem 1.1rem;
						border-radius: var(--radius-sm);
						font-size: 0.84rem;
						font-family: var(--font-mono);
						margin-bottom: 1rem;
						border: 1px solid transparent;
					}

					.cv-alert i {
						flex-shrink: 0;
						font-size: 1rem;
						margin-top: 0.05rem;
					}

					.cv-alert.success {
						background: var(--success-dim);
						border-color: rgba(34, 197, 94, 0.2);
						color: var(--success);
					}

					.cv-alert.error {
						background: var(--danger-dim);
						border-color: rgba(255, 75, 110, 0.2);
						color: var(--danger);
					}

					.cv-alert.info {
						background: var(--accent-dim);
						border-color: rgba(0, 255, 224, 0.2);
						color: var(--accent);
					}

					/* ───────────────────────────────────────
       JOIN PANEL
    ─────────────────────────────────────── */
					.join-panel {
						background: var(--bg-card);
						border: 1px solid var(--border);
						border-radius: var(--radius);
						padding: 1.3rem 1.5rem;
						display: flex;
						align-items: center;
						justify-content: space-between;
						gap: 1.2rem;
						flex-wrap: wrap;
						margin-bottom: 0.8rem;
					}

					.join-info {
						font-size: 0.87rem;
						color: var(--text-muted);
						font-family: var(--font-mono);
						flex: 1;
					}

					.join-info strong {
						color: var(--text-primary);
					}

					/* ───────────────────────────────────────
       BUTTONS
    ─────────────────────────────────────── */
					.btn-cv-primary {
						background: var(--accent);
						color: #000;
						border: none;
						border-radius: var(--radius-sm);
						font-family: var(--font-mono);
						font-size: 0.78rem;
						font-weight: 700;
						letter-spacing: 0.05em;
						padding: 0.55rem 1.2rem;
						transition: opacity var(--transition), transform var(--transition);
						text-decoration: none;
						display: inline-flex;
						align-items: center;
						gap: 0.4rem;
						cursor: pointer;
						white-space: nowrap;
					}

					.btn-cv-primary:hover {
						opacity: 0.85;
						transform: translateY(-1px);
						color: #000;
					}

					.btn-cv-primary:disabled {
						opacity: 0.35;
						pointer-events: none;
					}

					.btn-cv-danger {
						background: var(--danger);
						color: #fff;
						border: none;
						border-radius: var(--radius-sm);
						font-family: var(--font-mono);
						font-size: 0.78rem;
						font-weight: 700;
						letter-spacing: 0.05em;
						padding: 0.55rem 1.2rem;
						transition: opacity var(--transition), transform var(--transition);
						text-decoration: none;
						display: inline-flex;
						align-items: center;
						gap: 0.4rem;
						cursor: pointer;
						white-space: nowrap;
					}

					.btn-cv-danger:hover {
						opacity: 0.85;
						transform: translateY(-1px);
						color: #fff;
					}

					.btn-cv-ghost {
						background: transparent;
						color: var(--text-muted);
						border: 1px solid var(--border);
						border-radius: var(--radius-sm);
						font-family: var(--font-mono);
						font-size: 0.78rem;
						font-weight: 700;
						letter-spacing: 0.05em;
						padding: 0.55rem 1.2rem;
						transition: border-color var(--transition), color var(--transition);
						text-decoration: none;
						display: inline-flex;
						align-items: center;
						gap: 0.4rem;
						cursor: pointer;
						white-space: nowrap;
					}

					.btn-cv-ghost:hover {
						border-color: var(--accent);
						color: var(--accent);
					}

					.btn-row {
						display: flex;
						gap: 0.6rem;
						flex-wrap: wrap;
					}

					/* ───────────────────────────────────────
       SECTION TITLE
    ─────────────────────────────────────── */
					.section-title {
						font-size: 0.7rem;
						font-family: var(--font-mono);
						letter-spacing: 0.14em;
						text-transform: uppercase;
						color: var(--accent);
						margin-bottom: 1rem;
						display: flex;
						align-items: center;
						gap: 0.6rem;
					}

					.section-title::after {
						content: '';
						flex: 1;
						height: 1px;
						background: var(--border);
					}

					/* ───────────────────────────────────────
       CONTENT CARDS
    ─────────────────────────────────────── */
					.cv-card {
						background: var(--bg-card);
						border: 1px solid var(--border);
						border-radius: var(--radius);
						overflow: hidden;
						height: 100%;
					}

					.cv-card-header {
						padding: 1rem 1.4rem;
						border-bottom: 1px solid var(--border);
						display: flex;
						align-items: center;
						gap: 0.6rem;
					}

					.cv-card-header h2 {
						font-size: 0.88rem;
						font-weight: 700;
						letter-spacing: 0.02em;
						margin: 0;
					}

					.cv-card-header i {
						color: var(--accent);
						font-size: 1rem;
					}

					.cv-card-body {
						padding: 1.3rem 1.4rem;
					}

					/* about / description rich text */
					.desc-area {
						color: var(--text-muted);
						font-size: 0.88rem;
						line-height: 1.75;
					}

					.desc-area p {
						margin-bottom: 0.9rem;
					}

					.desc-area ul,
					.desc-area ol {
						padding-left: 1.3rem;
						margin-bottom: 0.9rem;
					}

					.desc-area li {
						margin-bottom: 0.35rem;
					}

					.desc-area h3,
					.desc-area h4 {
						color: var(--text-primary);
						font-size: 0.9rem;
						font-weight: 700;
						margin: 1.1rem 0 0.45rem;
					}

					.desc-area strong {
						color: var(--text-primary);
					}

					.desc-area a {
						color: var(--accent);
					}

					/* ───────────────────────────────────────
       QUICK INFO LIST
    ─────────────────────────────────────── */
					.kv-list {
						display: flex;
						flex-direction: column;
						gap: 0;
					}

					.kv-item {
						display: flex;
						align-items: flex-start;
						justify-content: space-between;
						gap: 1rem;
						padding: 0.8rem 0;
						border-bottom: 1px solid var(--border);
					}

					.kv-item:last-child {
						border-bottom: none;
					}

					.kv-label {
						font-family: var(--font-mono);
						font-size: 0.7rem;
						color: var(--text-muted);
						text-transform: uppercase;
						letter-spacing: 0.07em;
						flex-shrink: 0;
						padding-top: 0.05rem;
					}

					.kv-label i {
						margin-right: 0.35rem;
						color: var(--accent);
					}

					.kv-val {
						font-size: 0.84rem;
						font-weight: 600;
						color: var(--text-primary);
						text-align: right;
						font-family: var(--font-mono);
					}

					/* ───────────────────────────────────────
       PRIZE CARDS
    ─────────────────────────────────────── */
					.prize-grid {
						display: flex;
						flex-direction: column;
						gap: 0.7rem;
					}

					.prize-card {
						background: var(--bg-base);
						border: 1px solid var(--border);
						border-radius: var(--radius-sm);
						padding: 1rem 1.2rem;
						display: flex;
						gap: 1rem;
						align-items: flex-start;
						transition: border-color var(--transition), background var(--transition);
					}

					.prize-card:hover {
						border-color: rgba(0, 255, 224, 0.2);
						background: var(--bg-card-hover);
					}

					.prize-rank {
						font-family: var(--font-mono);
						font-size: 1.4rem;
						font-weight: 700;
						line-height: 1;
						flex-shrink: 0;
						width: 2rem;
						text-align: center;
					}

					.prize-rank.r1 {
						color: #ffd700;
					}

					.prize-rank.r2 {
						color: #c0c0c0;
					}

					.prize-rank.r3 {
						color: #cd7f32;
					}

					.prize-rank.rx {
						color: var(--text-muted);
					}

					.prize-content {
						flex: 1;
					}

					.prize-title {
						font-size: 0.9rem;
						font-weight: 700;
						margin-bottom: 0.3rem;
					}

					.prize-desc {
						font-size: 0.8rem;
						color: var(--text-muted);
						line-height: 1.5;
						font-family: var(--font-mono);
					}

					/* ───────────────────────────────────────
       TIMELINE STRIP
    ─────────────────────────────────────── */
					.timeline {
						display: flex;
						flex-direction: column;
						gap: 0;
					}

					.tl-item {
						display: flex;
						gap: 1rem;
						padding: 0.9rem 0;
						border-bottom: 1px solid var(--border);
						position: relative;
					}

					.tl-item:last-child {
						border-bottom: none;
					}

					.tl-dot {
						width: 10px;
						height: 10px;
						border-radius: 50%;
						background: var(--border);
						flex-shrink: 0;
						margin-top: 0.35rem;
					}

					.tl-dot.done {
						background: var(--accent);
						box-shadow: 0 0 8px rgba(0, 255, 224, 0.4);
					}

					.tl-dot.current {
						background: var(--accent2);
						box-shadow: 0 0 8px rgba(123, 92, 255, 0.4);
						animation: pulse-dot 1.2s ease-in-out infinite;
					}

					.tl-body {
						flex: 1;
					}

					.tl-label {
						font-size: 0.82rem;
						font-weight: 700;
						margin-bottom: 0.2rem;
					}

					.tl-date {
						font-family: var(--font-mono);
						font-size: 0.7rem;
						color: var(--text-muted);
					}

					/* ───────────────────────────────────────
       TEAM COUNT BAR
    ─────────────────────────────────────── */
					.cv-progress {
						height: 4px;
						background: var(--border);
						border-radius: 2px;
						overflow: hidden;
						margin-top: 0.5rem;
					}

					.cv-progress-bar {
						height: 100%;
						border-radius: 2px;
						background: linear-gradient(90deg, var(--accent), var(--accent2));
						transition: width 1s ease;
					}

					/* ───────────────────────────────────────
       EMPTY STATE
    ─────────────────────────────────────── */
					.empty-state {
						text-align: center;
						padding: 2.5rem 1rem;
						color: var(--text-muted);
					}

					.empty-state i {
						font-size: 2.2rem;
						opacity: 0.2;
						margin-bottom: 0.6rem;
						display: block;
					}

					.empty-state p {
						font-size: 0.82rem;
						font-family: var(--font-mono);
					}

					/* ───────────────────────────────────────
       ANIMATIONS
    ─────────────────────────────────────── */
					.fade-up {
						opacity: 0;
						transform: translateY(20px);
						animation: fadeUp 0.5s ease forwards;
					}

					@keyframes fadeUp {
						to {
							opacity: 1;
							transform: translateY(0);
						}
					}

					.fade-up:nth-child(1) {
						animation-delay: 0.05s
					}

					.fade-up:nth-child(2) {
						animation-delay: 0.10s
					}

					.fade-up:nth-child(3) {
						animation-delay: 0.15s
					}

					.fade-up:nth-child(4) {
						animation-delay: 0.20s
					}

					.fade-up:nth-child(5) {
						animation-delay: 0.25s
					}

					/* ───────────────────────────────────────
       MISC
    ─────────────────────────────────────── */
					a {
						color: inherit;
					}

					::-webkit-scrollbar {
						width: 6px;
					}

					::-webkit-scrollbar-track {
						background: var(--bg-base);
					}

					::-webkit-scrollbar-thumb {
						background: #222c3c;
						border-radius: 3px;
					}

					::-webkit-scrollbar-thumb:hover {
						background: #2e3d52;
					}

					@media (max-width: 768px) {
						.join-panel {
							flex-direction: column;
							align-items: flex-start;
						}

						.cv-detail-hero {
							padding: 2rem 0 1.5rem;
						}
					}
				</style>
			</head>

			<body>

				<%-- ══════════════════════════════════════ NAVBAR ══════════════════════════════════════ --%>
					<nav class="cv-navbar">
						<div class="container">
							<div class="d-flex align-items-center justify-content-between">

								<a href="userHome" class="brand">CODE<span>VERSE</span></a>

								<ul class="nav d-none d-md-flex align-items-center">
									<li><a href="userHome" class="nav-link-cv">Dashboard</a></li>
									<li><a href="hackathons" class="nav-link-cv active">Hackathons</a></li>
									<li><a href="myTeam.jsp" class="nav-link-cv">My Team</a></li>
									<li><a href="submissions.jsp" class="nav-link-cv">Submissions</a></li>
									<li><a href="leaderboard.jsp" class="nav-link-cv">Leaderboard</a></li>
								</ul>

								<div class="d-flex align-items-center gap-3">
									<a href="notifications.jsp" class="position-relative text-decoration-none"
										style="color:var(--text-muted)">
										<i class="bi bi-bell" style="font-size:1.1rem"></i>
										<c:if test="${notifCount > 0}">
											<span
												class="position-absolute top-0 start-100 translate-middle badge rounded-pill"
												style="background:var(--danger);font-size:0.55rem">${notifCount}</span>
										</c:if>
									</a>
									<div class="avatar-btn">
										<c:choose>
											<c:when test="${not empty sessionScope.userAvatar}">
												<img src="${sessionScope.userAvatar}" alt="avatar" />
											</c:when>
											<c:otherwise>
												<img src="https://api.dicebear.com/7.x/initials/svg?seed=${sessionScope.userName}&backgroundColor=0f1420&textColor=00ffe0"
													alt="avatar" />
											</c:otherwise>
										</c:choose>
									</div>
									<a href="LogoutServlet" class="btn-cv-ghost"
										style="font-size:0.7rem;padding:0.35rem 0.7rem">
										<i class="bi bi-box-arrow-right me-1"></i>Logout
									</a>
								</div>

							</div>
						</div>
					</nav>


					<%-- ══════════════════════════════════════ BACK BAR ══════════════════════════════════════ --%>
						<div class="back-bar">
							<div class="container">
								<a href="/participant/home" class="back-link">
									<i class="bi bi-arrow-left"></i> Back to Hackathons
								</a>
							</div>
						</div>


						<%-- ══════════════════════════════════════ MAIN ══════════════════════════════════════ --%>
							<div class="container">

								<%-- HERO SECTION --%>
									<section class="cv-detail-hero">

										<h1 class="hero-title fade-up">${hackathon.title}</h1>
										<p class="hero-desc fade-up">${hackathon.description}</p>

										<%-- CHIP STRIP --%>
											<div class="chip-strip fade-up">
												<span class="chip status-${hackathon.status}">
													<span class="dot"></span>
													${hackathon.status}
												</span>
												<span class="chip"><i
														class="bi bi-tag me-1"></i>${hackathon.eventType}</span>
												<span
													class="chip ${hackathon.payment == 'Free' ? 'chip-free' : 'chip-paid'}">
													<i
														class="bi bi-${hackathon.payment == 'Free' ? 'gift' : 'cash-stack'} me-1"></i>
													${hackathon.payment}
												</span>
												<span class="chip">
													<i class="bi bi-people me-1"></i>
													Team ${hackathon.minTeamSize} – ${hackathon.maxTeamSize}
												</span>
												<span
													class="chip ${registrationOpen ? 'status-open' : 'status-closed'}">
													<i class="bi bi-${registrationOpen ? 'unlock' : 'lock'} me-1"></i>
													${registrationOpen ? 'Registration Open' : 'Registration Closed'}
												</span>
												<span class="chip">
													<i class="bi bi-person-check me-1"></i>
													${teamCount} Teams Joined
												</span>
											</div>

											<%-- FLASH MESSAGES --%>
												<c:if test="${joined == 'true'}">
													<div class="cv-alert success fade-up">
														<i class="bi bi-check-circle-fill"></i>
														You have successfully joined this hackathon.
													</div>
												</c:if>
												<c:if test="${success == 'inviteAccepted'}">
													<div class="cv-alert success fade-up">
														<i class="bi bi-check-circle-fill"></i>
														Invitation accepted. You are now part of this team.
													</div>
												</c:if>
												<c:if test="${success == 'inviteRejected'}">
													<div class="cv-alert info fade-up">
														<i class="bi bi-info-circle-fill"></i>
														Invitation rejected.
													</div>
												</c:if>
												<c:if test="${error == 'alreadyRegistered'}">
													<div class="cv-alert error fade-up">
														<i class="bi bi-exclamation-triangle-fill"></i>
														You are already registered in this hackathon.
													</div>
												</c:if>
												<c:if test="${error == 'registrationClosed'}">
													<div class="cv-alert error fade-up">
														<i class="bi bi-exclamation-triangle-fill"></i>
														Registration is currently closed for this hackathon.
													</div>
												</c:if>
												<c:if test="${error == 'inviteNotFound' || error == 'inviteInvalid'}">
													<div class="cv-alert error fade-up">
														<i class="bi bi-exclamation-triangle-fill"></i>
														Invitation is invalid or no longer available.
													</div>
												</c:if>
												<c:if test="${error == 'teamFull'}">
													<div class="cv-alert error fade-up">
														<i class="bi bi-exclamation-triangle-fill"></i>
														This team is full, so the invitation cannot be accepted.
													</div>
												</c:if>
												<c:if test="${error == 'alreadyInHackathon'}">
													<div class="cv-alert error fade-up">
														<i class="bi bi-exclamation-triangle-fill"></i>
														You are already part of another team in this hackathon.
													</div>
												</c:if>
												<c:if test="${error == 'leaderboardNotReady'}">
													<div class="cv-alert error fade-up">
														<i class="bi bi-exclamation-triangle-fill"></i>
														Leaderboard will be available only after the hackathon is marked
														complete.
													</div>
												</c:if>

												<%-- JOIN PANEL --%>
													<div class="join-panel fade-up">
														<div class="join-info">
															<c:choose>
																<c:when test="${alreadyRegistered}">
																	<i class="bi bi-check2-circle me-1"
																		style="color:var(--success)"></i>
																	<strong>You are already part of this
																		hackathon.</strong>
																</c:when>
																<c:when test="${not empty pendingInvite}">
																	<i class="bi bi-envelope-open me-1"
																		style="color:var(--warn)"></i>
																	<strong>You have a pending team invitation</strong>
																	for this hackathon.
																</c:when>
																<c:when test="${registrationOpen}">
																	<i class="bi bi-unlock me-1"
																		style="color:var(--accent)"></i>
																	Registration is open. <strong>Join now to
																		participate.</strong>
																</c:when>
																<c:otherwise>
																	<i class="bi bi-lock me-1"
																		style="color:var(--text-muted)"></i>
																	You can join only during the registration period.
																</c:otherwise>
															</c:choose>
														</div>

														<div class="btn-row">
															<c:choose>
																<c:when test="${alreadyRegistered}">
																	<a href="/participant/hackathon/${hackathon.hackathonId}/team"
																		class="btn-cv-primary">
																		<i class="bi bi-people-fill"></i> Manage Team
																	</a>
																</c:when>
																<c:when test="${not empty pendingInvite}">
																	<form
																		action="/participant/hackathon/${hackathon.hackathonId}/invite/${pendingInvite.hackathonTeamInviteId}/accept"
																		method="post" style="display:inline">
																		<button type="submit" class="btn-cv-primary">
																			<i class="bi bi-check-lg"></i> Accept
																			Invitation
																		</button>
																	</form>
																	<form
																		action="/participant/hackathon/${hackathon.hackathonId}/invite/${pendingInvite.hackathonTeamInviteId}/reject"
																		method="post" style="display:inline">
																		<button type="submit" class="btn-cv-danger">
																			<i class="bi bi-x-lg"></i> Reject
																		</button>
																	</form>
																</c:when>
																<c:when test="${canJoin}">
																	<form
																		action="/participant/hackathon/${hackathon.hackathonId}/join"
																		method="post" style="display:inline">
																		<button type="submit" class="btn-cv-primary">
																			<i class="bi bi-lightning-charge-fill"></i>
																			Join Hackathon
																		</button>
																	</form>
																</c:when>
																<c:otherwise>
																	<button type="button" class="btn-cv-primary"
																		disabled>
																		<i class="bi bi-lock-fill"></i> Join Hackathon
																	</button>
																</c:otherwise>
															</c:choose>

															<c:if test="${leaderboardAvailable}">
																<a href="/participant/hackathon/${hackathon.hackathonId}/leaderboard"
																	class="btn-cv-ghost">
																	<i class="bi bi-bar-chart-line-fill"></i>
																	Leaderboard
																</a>
															</c:if>
														</div>
													</div>

									</section><%-- end hero --%>


										<%-- ── MAIN GRID ─────────────────────────────────────────────── --%>
											<div class="row g-4 mb-4">

												<%-- About This Hackathon --%>
													<div class="col-12 col-lg-8 fade-up">
														<div class="cv-card">
															<div class="cv-card-header">
																<i class="bi bi-journal-richtext"></i>
																<h2>About This Hackathon</h2>
															</div>
															<div class="cv-card-body">
																<div class="desc-area">
																	<c:choose>
																		<c:when
																			test="${not empty hackathonDescription}">
																			<c:out
																				value="${hackathonDescription.hackathonDetails}"
																				escapeXml="false" />
																		</c:when>
																		<c:otherwise>
																			<div class="empty-state">
																				<i class="bi bi-file-earmark-text"></i>
																				<p>Detailed description is not available
																					yet.</p>
																			</div>
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
													</div>

													<%-- Quick Info + Timeline sidebar --%>
														<div class="col-12 col-lg-4">
															<div class="d-flex flex-column gap-3">

																<%-- Quick Info --%>
																	<div class="cv-card fade-up">
																		<div class="cv-card-header">
																			<i class="bi bi-info-circle"></i>
																			<h2>Quick Info</h2>
																		</div>
																		<div class="cv-card-body">
																			<div class="kv-list">
																				<div class="kv-item">
																					<span class="kv-label"><i
																							class="bi bi-calendar-event"></i>Reg.
																						Start</span>
																					<span
																						class="kv-val">${hackathon.registrationStartDate}</span>
																				</div>
																				<div class="kv-item">
																					<span class="kv-label"><i
																							class="bi bi-calendar-x"></i>Reg.
																						End</span>
																					<span
																						class="kv-val">${hackathon.registrationEndDate}</span>
																				</div>
																				<div class="kv-item">
																					<span class="kv-label"><i
																							class="bi bi-geo-alt"></i>Location</span>
																					<span
																						class="kv-val">${hackathon.location}</span>
																				</div>
																				<div class="kv-item">
																					<span class="kv-label"><i
																							class="bi bi-diagram-3"></i>Event
																						Type</span>
																					<span
																						class="kv-val">${hackathon.eventType}</span>
																				</div>
																				<div class="kv-item">
																					<span class="kv-label"><i
																							class="bi bi-people"></i>Team
																						Size</span>
																					<span
																						class="kv-val">${hackathon.minTeamSize}
																						– ${hackathon.maxTeamSize}
																						members</span>
																				</div>
																				<div class="kv-item">
																					<span class="kv-label"><i
																							class="bi bi-cash"></i>Entry</span>
																					<span
																						class="kv-val">${hackathon.payment}</span>
																				</div>
																				<div class="kv-item">
																					<span class="kv-label"><i
																							class="bi bi-person-badge"></i>Teams
																						Joined</span>
																					<span class="kv-val"
																						style="color:var(--accent)">${teamCount}</span>
																				</div>
																			</div>
																		</div>
																	</div>

																	<%-- Timeline --%>
																		<div class="cv-card fade-up">
																			<div class="cv-card-header">
																				<i class="bi bi-clock-history"></i>
																				<h2>Timeline</h2>
																			</div>
																			<div class="cv-card-body">
																				<div class="timeline">
																					<div class="tl-item">
																						<div class="tl-dot done"></div>
																						<div class="tl-body">
																							<div class="tl-label">
																								Registration Opens</div>
																							<div class="tl-date">
																								${hackathon.registrationStartDate}
																							</div>
																						</div>
																					</div>
																					<div class="tl-item">
																						<div
																							class="tl-dot ${registrationOpen ? 'current' : 'done'}">
																						</div>
																						<div class="tl-body">
																							<div class="tl-label">
																								Registration Closes
																							</div>
																							<div class="tl-date">
																								${hackathon.registrationEndDate}
																							</div>
																						</div>
																					</div>
																					<div class="tl-item">
																						<div
																							class="tl-dot ${hackathon.status == 'live' ? 'current' : ''}">
																						</div>
																						<div class="tl-body">
																							<div class="tl-label">
																								Hackathon Begins</div>
																							<div class="tl-date">
																								${hackathon.startDate}
																							</div>
																						</div>
																					</div>
																					<div class="tl-item">
																						<div class="tl-dot"></div>
																						<div class="tl-body">
																							<div class="tl-label">
																								Submission Deadline
																							</div>
																							<div class="tl-date">
																								${hackathon.endDate}
																							</div>
																						</div>
																					</div>
																					<div class="tl-item">
																						<div class="tl-dot"></div>
																						<div class="tl-body">
																							<div class="tl-label">
																								Results Announced</div>
																							<div class="tl-date"
																								style="color:var(--text-muted)">
																								TBA</div>
																						</div>
																					</div>
																				</div>
																			</div>
																		</div>

															</div>
														</div>

											</div><%-- end grid row --%>


												<%-- PRIZES --%>
													<div class="mb-5 fade-up">
														<div class="section-title">Prizes &amp; Rewards</div>
														<div class="cv-card">
															<div class="cv-card-body">
																<c:choose>
																	<c:when test="${empty prizeList}">
																		<div class="empty-state">
																			<i class="bi bi-trophy"></i>
																			<p>Prize details are not published yet.</p>
																		</div>
																	</c:when>
																	<c:otherwise>
																		<div class="prize-grid">
																			<c:forEach items="${prizeList}" var="p"
																				varStatus="i">
																				<div class="prize-card">
																					<div
																						class="prize-rank ${i.count == 1 ? 'r1' : i.count == 2 ? 'r2' : i.count == 3 ? 'r3' : 'rx'}">
																						<c:choose>
																							<c:when
																								test="${i.count == 1}">
																								🥇</c:when>
																							<c:when
																								test="${i.count == 2}">
																								🥈</c:when>
																							<c:when
																								test="${i.count == 3}">
																								🥉</c:when>
																							<c:otherwise>${i.count}
																							</c:otherwise>
																						</c:choose>
																					</div>
																					<div class="prize-content">
																						<div class="prize-title">
																							${p.prizeTitle}</div>
																						<div class="prize-desc">
																							${p.prizeDescription}</div>
																					</div>
																				</div>
																			</c:forEach>
																		</div>
																	</c:otherwise>
																</c:choose>
															</div>
														</div>
													</div>

							</div><%-- end container --%>


								<%-- ══════════════════════════════════════ FOOTER
									══════════════════════════════════════ --%>
									<footer style="border-top:1px solid var(--border);padding:2rem 0;margin-top:2rem">
										<div
											class="container d-flex align-items-center justify-content-between flex-wrap gap-2">
											<span
												style="font-family:var(--font-mono);font-size:0.72rem;color:var(--text-muted)">
												&copy; 2025 <span style="color:var(--accent)">CodeVerse</span>. All
												rights reserved.
											</span>
											<div style="display:flex;gap:1.2rem">
												<a href="privacy.jsp"
													style="font-size:0.72rem;color:var(--text-muted);font-family:var(--font-mono);text-decoration:none">Privacy</a>
												<a href="terms.jsp"
													style="font-size:0.72rem;color:var(--text-muted);font-family:var(--font-mono);text-decoration:none">Terms</a>
												<a href="contact.jsp"
													style="font-size:0.72rem;color:var(--text-muted);font-family:var(--font-mono);text-decoration:none">Contact</a>
											</div>
										</div>
									</footer>

									<script
										src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
									<script>
										/* animate progress bar if you add team capacity later */
										window.addEventListener('load', () => {
											document.querySelectorAll('.cv-progress-bar[data-width]').forEach(bar => {
												const w = bar.dataset.width;
												bar.style.width = '0%';
												setTimeout(() => {bar.style.width = w;}, 300);
											});
										});
									</script>

			</body>

			</html>