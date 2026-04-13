<%--============================================================CODEVERSE — Dashboard (Demo / Reference Page) Path:
	src/main/webapp/WEB-INF/views/participant/dashboard.jsp Controller sets: model.addAttribute("pageTitle", "Dashboard"
	); model.addAttribute("activePage", "dashboard" ); session.setAttribute("userName", user.getName());
	session.setAttribute("userEmail", user.getEmail()); session.setAttribute("notifCount", notifCount); HOW TO BUILD ANY
	NEW PAGE — copy this file, then: 1. Change pageTitle + activePage 2. Replace everything inside <main
	class="cv-content">
	3. Done. Navbar, sidebar, footer are automatic.
	============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%-- ── Step 1: Set page identity ──────────────────────────── --%>
<c:set var="pageTitle" value="Dashboard" scope="request" />
<c:set var="activePage" value="dashboard" scope="request" />

<!DOCTYPE html>
<html lang="en" data-page="dashboard">
<%-- data-page on <html> or

							<body> is read by codeverse.js to
								auto-mark the correct sidebar link as active.
								--%>

<head>
<%@ include file="../components/Head.jsp"%>
</head>

<body data-page="dashboard">

	<%-- ── Step 2: Navbar (always first inside body) ──────────── --%>
	<%@ include file="../components/navbar.jsp"%>

	<%-- ── Step 3: Shell wraps sidebar + main content ─────────── --%>
	<div class="cv-shell">

		<%-- Step 4: Sidebar --%>
		<%@ include file="../components/Sidebar.jsp"%>

		<%-- ── Step 5: Your page content goes here
																────────────────── --%>
		<main class="cv-content">

			<c:if test="${not empty success}">
				<div class="alert alert-success cv-msg" role="alert">
					<i class="bi bi-check-circle-fill" aria-hidden="true"></i>
					${success}
				</div>
			</c:if>

			<c:if test="${not empty error}">
				<div class="alert alert-danger cv-msg" role="alert">
					<i class="bi bi-exclamation-triangle-fill" aria-hidden="true"></i>
					${error}
				</div>
			</c:if>

			<%-- PAGE HEADER --%>
			<div class="cv-page-header">
				<div class="cv-page-header__left">
					<div class="cv-page-eyebrow">
						<i class="bi bi-grid-1x2" aria-hidden="true"></i> Overview
					</div>
					<h1 class="cv-page-title">
						Welcome back, <span class="hi"> <c:out
								value="${sessionScope.user.firstName}" />
						</span>
					</h1>
					<p class="cv-page-subtitle">Here's what's happening on
						CodeVerse today.</p>
				</div>
				<div class="cv-page-header__actions">
					<a href="/hackathons" class="btn-cv btn-cv--primary"
						aria-label="Explore Hackathons"> <i
						class="bi bi-lightning-charge-fill" aria-hidden="true"></i>
						Explore Hackathons
					</a>
				</div>
			</div>

			<%-- FLASH MESSAGES (set as session/request attr
																			from controller) --%>
			<c:if test="${not empty successMsg}">
				<div class="cv-alert cv-alert--success" data-cv-dismiss="5000"
					role="alert">
					<i class="bi bi-check-circle-fill" aria-hidden="true"></i>${successMsg}
				</div>
			</c:if>
			<c:if test="${not empty errorMsg}">
				<div class="cv-alert cv-alert--error" data-cv-dismiss="5000"
					role="alert">
					<i class="bi bi-exclamation-triangle-fill" aria-hidden="true"></i>${errorMsg}
				</div>
			</c:if>

			<%-- ── STAT CARDS
																				────────────────────────────────────────
																				--%>
			<div class="row g-3 mb-4 cv-stagger">
				<div class="col-6 col-xl-3 cv-fade-up">
					<div class="cv-stat">
						<div class="cv-stat__icon cv-stat__icon--orange">
							<i class="bi bi-bell" aria-hidden="true"></i>
						</div>
						<div>
							<div class="cv-stat__val">
								<c:out value="${fn:length(notifications)}" default="0" />
							</div>
							<div class="cv-stat__label">Unread Notifications</div>
						</div>
					</div>
				</div>
				<div class="col-6 col-xl-3 cv-fade-up">
					<div class="cv-stat">
						<div class="cv-stat__icon cv-stat__icon--purple">
							<i class="bi bi-journal-code"></i>
						</div>
						<div>
							<div class="cv-stat__val">
								<c:out value="${hackathonCount}" default="0" />
							</div>
							<div class="cv-stat__label">Hackathons</div>
						</div>
					</div>
				</div>
				<div class="col-6 col-xl-3 cv-fade-up">
					<div class="cv-stat">
						<div class="cv-stat__icon cv-stat__icon--gold">
							<i class="bi bi-send-check"></i>
						</div>
						<div>
							<div class="cv-stat__val">
								<c:out value="${submissionsCount}" default="0" />
							</div>
							<div class="cv-stat__label">Submissions</div>
						</div>
					</div>
				</div>
				<div class="col-6 col-xl-3 cv-fade-up">
					<div class="cv-stat">
						<div class="cv-stat__icon cv-stat__icon--info">
							<i class="bi bi-people"></i>
						</div>
						<div>
							<div class="cv-stat__val">
								<c:out value="${fn:length(myRegistrations)}" default="0" />
							</div>
							<div class="cv-stat__label">Active Teams</div>
						</div>
					</div>
				</div>
			</div>

			<%-- ── UPCOMING DEADLINE COUNTDOWN
																					────────────────────── --%>
			<c:if test="${not empty upcomingHackathon}">
				<div class="cv-countdown mb-4 cv-fade-up"
					data-cv-countdown="${submissionDeadlineMillis}"
					data-cv-cd-d="#cdDays" data-cv-cd-h="#cdHrs" data-cv-cd-m="#cdMin"
					data-cv-cd-s="#cdSec">
					<div>
						<div class="cv-countdown__label">
							<i class="bi bi-hourglass-split me-1 text-warn"></i>Submission
							Deadline
						</div>
						<div class="cv-countdown__name">${upcomingHackathon.title}</div>
					</div>
					<div class="cv-countdown__timer">
						<div class="cv-cd-unit">
							<div class="cv-cd-num" id="cdDays">--</div>
							<div class="cv-cd-lbl">Days</div>
						</div>
						<div class="cv-cd-unit">
							<div class="cv-cd-num" id="cdHrs">--</div>
							<div class="cv-cd-lbl">Hrs</div>
						</div>
						<div class="cv-cd-unit">
							<div class="cv-cd-num" id="cdMin">--</div>
							<div class="cv-cd-lbl">Min</div>
						</div>
						<div class="cv-cd-unit">
							<div class="cv-cd-num" id="cdSec">--</div>
							<div class="cv-cd-lbl">Sec</div>
						</div>
					</div>
				</div>
			</c:if>

			<%-- ── MAIN GRID
																						──────────────────────────────────────────
																						--%>
			<div class="row g-4">

				<%-- LEFT: Recent hackathons
																								--%>
				<div class="col-12 col-lg-8">

					<div class="cv-section-title">Open Hackathons</div>

					<c:choose>
						<c:when test="${not empty hackathonList}">
							<div class="row g-3 cv-stagger">
								<c:forEach var="h" items="${hackathonList}" varStatus="s">
									<c:if test="${s.index < 4}">
										<div class="col-12 col-sm-6 cv-fade-up">
											<div class="cv-card cv-card--lift">
												<div
													class="cv-card__banner cv-card__banner--${fn:toLowerCase(h.status)}">
												</div>
												<div class="cv-card__body">
													<div class="d-flex gap-2 mb-2 flex-wrap">
														<span
															class="cv-badge cv-badge--${fn:toLowerCase(h.status)}">
															<span class="cv-badge__dot"></span>${h.status}
														</span> <span
															class="cv-badge cv-badge--${h.payment == 'Free' ? 'free' : 'paid'}">
															${h.payment} </span>
													</div>
													<div
														style="font-size: .95rem; font-weight: 700; margin-bottom: .3rem">
														${h.title}</div>
													<div
														style="font-family: var(--font-mono); font-size: .72rem; color: var(--text-muted)">
														<i class="bi bi-geo-alt-fill text-accent me-1"></i>${h.location}
														&nbsp;&bull;&nbsp; <i class="bi bi-people me-1"></i>${h.minTeamSize}–${h.maxTeamSize}
													</div>
													<div
														style="font-family: var(--font-mono); font-size: .72rem; color: var(--text-muted); margin-top: .3rem">
														<i class="bi bi-gift-fill text-accent me-1"></i> 1st:
														₹${h.firstPrize != null ? h.firstPrize : 'TBA'} | 2nd:
														₹${h.secondPrize != null ? h.secondPrize : 'TBA'} | 3rd:
														₹${h.thirdPrize != null ? h.thirdPrize : 'TBA'}
													</div>
													<div
														style="font-family: var(--font-mono); font-size: .72rem; color: var(--text-muted); margin-top: .3rem">
														<i class="bi bi-person-fill text-accent me-1"></i>
														${participantCounts[h.hackathonId] != null ? participantCounts[h.hackathonId] : 0}
														participants
													</div>
												</div>
												<div class="cv-card__footer">
													<a href="hackathonDetail/${h.hackathonId}"
														class="btn-cv btn-cv--primary btn-cv--sm"> <i
														class="bi bi-arrow-right-circle"></i> View
													</a>

												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
							<div class="mt-3 text-end">
								<a href="/hackathons" class="btn-cv btn-cv--ghost btn-cv--sm">
									View all hackathons <i class="bi bi-arrow-right"></i>
								</a>
							</div>
						</c:when>
						<c:otherwise>
							<div class="cv-card">
								<div class="cv-empty">
									<i class="bi bi-calendar-x"></i>
									<h3>No open hackathons</h3>
									<p>Check back soon — new events are added regularly.</p>
								</div>
							</div>
						</c:otherwise>
					</c:choose>

					<%-- My
																										Registrations
																										Table --%>
					<div class="cv-section-title mt-4">My Registrations</div>
					<div class="cv-table-wrap cv-fade-up">
						<c:choose>
							<c:when test="${not empty myRegistrations}">
								<div class="table-responsive">
									<table class="cv-table">
										<thead>
											<tr>
												<th>#</th>
												<th>Hackathon</th>
												<th>Team</th>
												<th>Event Dates</th>
												<th>Sub. Deadline</th>
												<th>Action</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="r" items="${myRegistrations}" varStatus="s">

												<tr>
													<td class="font-mono text-muted-cv"
														style="font-size: .78rem">${s.count}</td>

													<td style="font-weight: 600">${r.hackathon.title}</td>

													<td><c:out value="${r.teamName}" default="—" /></td>

													<td class="font-mono" style="font-size: .75rem">
														<div class="text-accent">${r.hackathon.eventStartDate != null ? r.hackathon.eventStartDate : 'TBA'}</div>
														<div class="text-muted-cv">${r.hackathon.eventEndDate != null ? r.hackathon.eventEndDate : 'TBA'}</div>
													</td>

													<td class="font-mono text-danger" style="font-size: .75rem">
														${r.hackathon.submissionDeadline != null ? r.hackathon.submissionDeadline : 'TBA'}
													</td>

													<!-- Actions -->
													<td>
														<div class="d-flex gap-2">
															<a
																href="/participant/submissions/${r.hackathon.hackathonId}"
																class="btn-cv btn-cv--ghost btn-cv--sm"
																title="Submit Project"> <i class="bi bi-upload"></i>
															</a>

															<c:if
																test="${fn:toLowerCase(r.hackathon.status) == 'completed'}">
																<a
																	href="/participant/certificate/${r.hackathon.hackathonId}"
																	class="btn-cv btn-cv--warning btn-cv--sm"
																	title="Download Certificate" target="_blank"> <i
																	class="bi bi-patch-check-fill"></i>
																</a>
															</c:if>
														</div>
													</td>

													<!-- ✅ Cancel Button -->
													<td>
														<form
															action="/hackathons/${r.hackathon.hackathonId}/cancel"
															method="post" style="display: inline">

															<button class="btn-cv btn-cv--danger btn-cv--sm"
																onclick="return confirm('Cancel registration?')">

																<i class="bi bi-x-circle"></i> Cancel
															</button>

														</form>
													</td>

												</tr>

											</c:forEach>
										</tbody>
									</table>
								</div>
							</c:when>

							<c:otherwise>
								<div class="cv-empty">
									<i class="bi bi-clipboard-x"></i>
									<h3>No registrations yet</h3>
									<p>Register for a hackathon to get started.</p>
									<a href="/hackathons" class="btn-cv btn-cv--primary mt-3">
										Browse Hackathons </a>
								</div>
							</c:otherwise>

						</c:choose>
					</div>

				</div>
				<%-- end col-lg-8 --%>

				<%-- RIGHT: Profile
																										+ XP + Quick
																										links --%>
				<div class="col-12 col-lg-4">

					<%-- My Team Status (Quick Access) --%>
					<div class="cv-card mb-3 cv-fade-up">
						<div class="cv-card__header">
							<i class="bi bi-people-fill"></i>
							<h2>Current Team</h2>
							<div class="cv-card__header-actions">
								<c:choose>
									<c:when test="${not empty latestTeam}">
										<span class="cv-badge cv-badge--success">Joined</span>
									</c:when>
									<c:otherwise>
										<span class="cv-badge cv-badge--danger">No Team</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="cv-card__body">
							<c:choose>
								<c:when test="${not empty latestTeam}">
									<div
										style="font-size: 0.9rem; font-weight: 700; margin-bottom: 0.25rem;">
										${latestTeam.team.teamName}</div>
									<div class="text-muted-cv"
										style="font-size: 0.75rem; margin-bottom: 1rem;">
										Registered for: ${latestTeam.team.hackathon.title}</div>
									<div class="cv-kv-list mt-2">
										<div class="cv-kv-item">
											<span class="cv-kv-label">Role</span> <span
												class="cv-kv-val text-accent">${latestTeam.roleTitle}</span>
										</div>
										<div class="cv-kv-item">
											<span class="cv-kv-label">Status</span> <span
												class="cv-kv-val">${latestTeam.status}</span>
										</div>
									</div>
								</c:when>
								<c:otherwise>
									<p class="text-muted-cv" style="font-size: 0.8rem;">You are
										not currently part of any team. Join or create one to
										participate.</p>
								</c:otherwise>
							</c:choose>

							<c:if
								test="${fn:toLowerCase(latestTeam.team.hackathon.status) == 'completed'}">
								<a
									href="/participant/certificate/${latestTeam.team.hackathon.hackathonId}"
									class="btn-cv btn-cv--warning btn-cv--block mt-2"
									target="_blank"> <i class="bi bi-patch-check-fill"></i>
									Download Certificate
								</a>
							</c:if>

							<a href="/participant/team"
								class="btn-cv btn-cv--primary btn-cv--block mt-2"> <i
								class="bi bi-people"></i> Manage Teams
							</a>
						</div>
					</div>
					<a href="/profile" class="btn-cv btn-cv--ghost btn-cv--block mt-3">
						<i class="bi bi-pencil-square"></i> Edit Profile
					</a>


					<%-- Quick
																													Links
																													--%>
					<div class="cv-card mb-3 cv-fade-up">
						<div class="cv-card__header">
							<i class="bi bi-grid"></i>
							<h2>Quick Links</h2>
						</div>
						<div>
							<a href="/participant/team" class="cv-nav-item"><i
								class="bi bi-people"></i><span>My Team</span><i
								class="bi bi-chevron-right ms-auto"
								style="font-size: .7rem; color: var(--text-muted)"></i></a> <a
								href="/participant/submissions" class="cv-nav-item"><i
								class="bi bi-code-slash"></i><span>Submissions</span><i
								class="bi bi-chevron-right ms-auto"
								style="font-size: .7rem; color: var(--text-muted)"></i></a> <a
								href="/leaderboardList" class="cv-nav-item"><i
								class="bi bi-bar-chart-line"></i><span>Leaderboard</span><i
								class="bi bi-chevron-right ms-auto"
								style="font-size: .7rem; color: var(--text-muted)"></i></a> <a
								href="/faq" class="cv-nav-item"><i
								class="bi bi-question-circle"></i><span>Help &amp; FAQ</span><i
								class="bi bi-chevron-right ms-auto"
								style="font-size: .7rem; color: var(--text-muted)"></i></a>
						</div>
					</div>

					<%-- Announcements
																														--%>
					<c:if test="${not empty announcements}">
						<div class="cv-section-title">Announcements</div>
						<div class="d-flex flex-column gap-2">
							<c:forEach var="ann" items="${announcements}">
								<div class="cv-announce">
									<div class="cv-announce__title">${ann.title}</div>
									<div class="cv-announce__meta">
										<i class="bi bi-calendar2 me-1" aria-hidden="true"></i>
										<fmt:formatDate value="${ann.postedOn}" pattern="dd MMM yyyy" />
									</div>
									<div class="cv-announce__body">${ann.body}</div>
								</div>
							</c:forEach>
						</div>
					</c:if>

				</div>
				<%-- end
																											col-lg-4
																											--%>

			</div>
			<%-- end row --%>

		</main>
		<%-- end cv-content --%>
	</div>
	<%-- end cv-shell --%>

	<%-- ── Step 6: Footer + Scripts (always last) ─────────────── --%>
	<%@ include file="../components/Footer.jsp"%>
	<%@ include file="../components/Scripts.jsp"%>

</body>

</html>