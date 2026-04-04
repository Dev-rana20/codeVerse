<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
			<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>



				<%-- CodeVerse — User Home Page Requires: UserBean / session attributes: userName, userEmail,
					userAvatar, userPoints, userRank Hackathon list forwarded as request attribute: hackathonList
					(List<HackathonBean>)
					Registration list: myRegistrations (List<RegistrationBean>)
						--%>

						<!DOCTYPE html>
						<html lang="en">

						<head>
							<meta charset="UTF-8" />
							<meta name="viewport" content="width=device-width, initial-scale=1.0" />
							<title>CodeVerse — Dashboard</title>

							<!-- Google Fonts -->
							<link rel="preconnect" href="https://fonts.googleapis.com" />
							<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
							<link
								href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap"
								rel="stylesheet" />

							<!-- Bootstrap 5 -->
							<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
								rel="stylesheet" />

							<!-- Bootstrap Icons -->
							<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
								rel="stylesheet" />
							<link rel="stylesheet" href="assets/css/userHome.css">


						</head>

						<body>

							<%-- ══════════════════════════════════════ NAVBAR ══════════════════════════════════════
								--%>

								<jsp:include page="navbar.jsp"></jsp:include>
								<%-- ══════════════════════════════════════ MAIN LAYOUT
									══════════════════════════════════════ --%>
									<div class="container py-4">
										<div class="row g-4">

											<%-- ── MAIN CONTENT COLUMN ─────────────────────────────── --%>
												<div class="col-12 col-lg-8">

													<%-- HERO --%>
														<section class="cv-hero">
															<div class="hero-greeting fade-up">
																<span class="hi">Welcome back,</span>
																${sessionScope.user.firstName}
																<span style="color:var(--accent)">_</span>
															</div>
															<p class="hero-sub fade-up">
																<i class="bi bi-geo-alt me-1"></i>
																<c:out value="${sessionScope.user.email}"
																	default="participant@codeverse.io" />
																&nbsp;&bull;&nbsp;
																<c:out value="${sessionScope.userCollege}"
																	default="—" />
															</p>
														</section>

														<%-- STAT ROW --%>
															<div class="row g-3 mb-4">
																<div class="col-6 col-sm-3 fade-up">
																	<div class="stat-card">
																		<div class="stat-icon cyan"><i
																				class="bi bi-trophy"></i></div>
																		<div>
																			<div class="stat-val">
																				<c:out
																					value="${sessionScope.userPoints}"
																					default="0" />
																			</div>
																			<div class="stat-label">Points</div>
																		</div>
																	</div>
																</div>
																<div class="col-6 col-sm-3 fade-up">
																	<div class="stat-card">
																		<div class="stat-icon purple"><i
																				class="bi bi-journal-code"></i></div>
																		<div>
																			<div class="stat-val">
																				<c:out
																					value="${fn:length(myRegistrations)}"
																					default="0" />
																			</div>
																			<div class="stat-label">Hackathons</div>
																		</div>
																	</div>
																</div>
																<div class="col-6 col-sm-3 fade-up">
																	<div class="stat-card">
																		<div class="stat-icon gold"><i
																				class="bi bi-send-check"></i></div>
																		<div>
																			<div class="stat-val">
																				<c:out value="${submissionsCount}"
																					default="0" />
																			</div>
																			<div class="stat-label">Submitted</div>
																		</div>
																	</div>
																</div>
																<div class="col-6 col-sm-3 fade-up">
																	<div class="stat-card">
																		<div class="stat-icon red"><i
																				class="bi bi-star-half"></i></div>
																		<div>
																			<div class="stat-val">#
																				<c:out value="${sessionScope.userRank}"
																					default="—" />
																			</div>
																			<div class="stat-label">Rank</div>
																		</div>
																	</div>
																</div>
															</div>

															<%-- UPCOMING DEADLINE COUNTDOWN --%>
																<c:if test="${not empty upcomingHackathon}">
																	<div class="countdown-wrap fade-up mb-4">
																		<div>
																			<div class="countdown-label"><i
																					class="bi bi-alarm me-1"></i>Deadline
																				approaching</div>
																			<div class="countdown-name">
																				${upcomingHackathon.title}</div>
																		</div>
																		<div class="countdown-timer" id="countdown"
																			data-deadline="${upcomingHackathon.deadlineMillis}">
																			<div class="cd-unit">
																				<div class="cd-num" id="cd-d">--</div>
																				<div class="cd-lbl">Days</div>
																			</div>
																			<div class="cd-unit">
																				<div class="cd-num" id="cd-h">--</div>
																				<div class="cd-lbl">Hrs</div>
																			</div>
																			<div class="cd-unit">
																				<div class="cd-num" id="cd-m">--</div>
																				<div class="cd-lbl">Min</div>
																			</div>
																			<div class="cd-unit">
																				<div class="cd-num" id="cd-s">--</div>
																				<div class="cd-lbl">Sec</div>
																			</div>
																		</div>
																	</div>
																</c:if>

																<%-- OPEN HACKATHONS --%>
																	<div class="mb-4">
																		<div class="section-title">Open Hackathons</div>
																		<div class="row g-3">
																			<c:choose>
																				<c:when
																					test="${not empty hackathonList}">
																					<c:forEach var="hack"
																						items="${hackathonList}"
																						varStatus="loop">
																						<c:if test="${loop.index < 6}">
																							<div
																								class="col-12 col-sm-6 fade-up">
																								<div class="hack-card">
																									<div
																										class="hack-card-banner ${hack.status}">
																									</div>
																									<div
																										class="hack-card-body">
																										<span
																											class="hack-badge ${hack.status}">
																											<span
																												class="dot"></span>
																											<c:out
																												value="${hack.status}" />
																										</span>
																										<div
																											class="hack-title">
																											<c:out
																												value="${hack.title}" />
																										</div>
																										<div
																											class="hack-org">
																											<i
																												class="bi bi-building me-1"></i>
																											<c:out
																												value="${hack.organizer}" />
																										</div>
																										<div
																											class="hack-meta">
																											<div
																												class="hack-meta-item">
																												<i
																													class="bi bi-calendar3"></i>
																												<fmt:formatDate
																													value="${hack.startDate}"
																													pattern="dd MMM" />
																												&nbsp;–&nbsp;
																												<fmt:formatDate
																													value="${hack.endDate}"
																													pattern="dd MMM yyyy" />
																											</div>
																											<div
																												class="hack-meta-item">
																												<i
																													class="bi bi-people"></i>
																												<c:out
																													value="${hack.teamSize}" />
																												members
																											</div>
																											<div
																												class="hack-meta-item">
																												<i
																													class="bi bi-cash-stack"></i>
																												<c:out
																													value="${hack.prize}"
																													default="TBA" />
																											</div>
																										</div>
																									</div>
																									<div
																										class="hack-card-footer">
																										<a href="hackathonDetail.jsp?id=${hack.hackathonId}"
																											class="btn-cv-primary">View
																											Details</a>
																										<c:choose>
																											<c:when
																												test="${hack.registered}">
																												<a href="submissions.jsp?id=${hack.hackathonId}"
																													class="btn-cv-ghost">My
																													Submission</a>
																											</c:when>
																											<c:otherwise>
																												<a href="RegisterServlet?id=${hack.hackathonId}"
																													class="btn-cv-ghost">Register</a>
																											</c:otherwise>
																										</c:choose>
																									</div>
																								</div>
																							</div>
																						</c:if>
																					</c:forEach>
																				</c:when>
																				<c:otherwise>
																					<div class="col-12">
																						<div class="box-wrap">
																							<div class="empty-state">
																								<i
																									class="bi bi-calendar-x"></i>
																								<p>No open hackathons
																									right now. Check
																									back soon!</p>
																							</div>
																						</div>
																					</div>
																				</c:otherwise>
																			</c:choose>
																		</div>
																		<c:if test="${fn:length(hackathonList) > 6}">
																			<div class="mt-3 text-center">
																				<a href="hackathons.jsp"
																					class="btn-cv-ghost">View all
																					hackathons &rarr;</a>
																			</div>
																		</c:if>
																	</div>

																	<%-- MY REGISTRATIONS TABLE --%>
																		<div class="mb-4 fade-up">
																			<div class="section-title">My Registrations
																			</div>
																			<div class="box-wrap">
																				<c:choose>
																					<c:when
																						test="${not empty myRegistrations}">
																						<div class="table-responsive">
																							<table class="cv-table">
																								<thead>
																									<tr>
																										<th>#</th>
																										<th>Hackathon
																										</th>
																										<th>Team</th>
																										<th>Registered
																											On</th>
																										<th>Status</th>
																										<th>Action</th>
																									</tr>
																								</thead>
																								<tbody>
																									<c:forEach var="reg"
																										items="${myRegistrations}"
																										varStatus="s">
																										<tr>
																											<td
																												style="font-family:var(--font-mono);color:var(--text-muted);font-size:0.78rem">
																												${s.count}
																											</td>
																											<td
																												style="font-weight:600">
																												<c:out
																													value="${reg.hackathonTitle}" />
																											</td>
																											<td
																												style="font-family:var(--font-mono);font-size:0.8rem;color:var(--text-muted)">
																												<c:out
																													value="${reg.teamName}"
																													default="—" />
																											</td>
																											<td
																												style="font-family:var(--font-mono);font-size:0.75rem;color:var(--text-muted)">
																												<fmt:formatDate
																													value="${reg.registeredOn}"
																													pattern="dd MMM yyyy" />
																											</td>
																											<td>
																												<span
																													class="status-pill ${reg.status}">
																													<c:out
																														value="${reg.status}" />
																												</span>
																											</td>
																											<td>
																												<a href="submissions.jsp?hackId=${reg.hackathonId}"
																													class="btn-cv-ghost"
																													style="font-size:0.68rem;padding:0.25rem 0.6rem">
																													<i
																														class="bi bi-upload me-1"></i>Submit
																												</a>
																											</td>
																										</tr>
																									</c:forEach>
																								</tbody>
																							</table>
																						</div>
																					</c:when>
																					<c:otherwise>
																						<div class="empty-state">
																							<i
																								class="bi bi-clipboard-x"></i>
																							<p>You haven't registered
																								for any hackathons yet.
																							</p>
																							<a href="hackathons.jsp"
																								class="btn-cv-primary mt-3 d-inline-block">Explore
																								Hackathons</a>
																						</div>
																					</c:otherwise>
																				</c:choose>
																			</div>
																		</div>

												</div><%-- end main col --%>


													<%-- ── SIDEBAR COLUMN ─────────────────────────────────────── --%>
														<div class="col-12 col-lg-4">

															<%-- PROFILE CARD --%>
																<div class="profile-card mb-4 fade-up">
																	<div class="profile-avatar">
																		<c:choose>
																			<c:when
																				test="${not empty sessionScope.user.profilePicURL}">
																				<img src="${sessionScope.user.profilePicURL}"
																					alt="avatar" />
																			</c:when>
																			<c:otherwise>
																				<img src="https://api.dicebear.com/7.x/initials/svg?seed=${sessionScope.user.firstName}&backgroundColor=0f1420&textColor=00ffe0"
																					alt="avatar" />
																			</c:otherwise>
																		</c:choose>
																	</div>
																	<div class="profile-name">
																		<c:out value="${sessionScope.user.firstName}" />
																	</div>
																	<div class="profile-email">
																		<c:out value="${sessionScope.user.email}" />
																	</div>

																	<div class="rank-badge">
																		<i class="bi bi-shield-check"></i>
																		Rank #
																		<c:out value="${sessionScope.userRank}"
																			default="—" />
																	</div>

																	<div>
																		<div
																			style="font-size:0.65rem;font-family:var(--font-mono);color:var(--text-muted);text-align:left;margin-bottom:0.3rem;text-transform:uppercase;letter-spacing:0.08em">
																			XP Progress
																		</div>
																		<div class="cv-progress">
																			<div class="cv-progress-bar" id="xpBar"
																				style="width: ${(sessionScope.userPoints % 500) / 5}%">
																			</div>
																		</div>
																		<div
																			style="display:flex;justify-content:space-between;margin-top:0.3rem">
																			<span
																				style="font-size:0.68rem;font-family:var(--font-mono);color:var(--text-muted)">
																				${sessionScope.userPoints} pts
																			</span>
																			<span
																				style="font-size:0.68rem;font-family:var(--font-mono);color:var(--text-muted)">
																				next tier: ${500 -
																				(sessionScope.userPoints % 500)} pts
																			</span>
																		</div>
																	</div>

																	<div class="profile-divider"></div>

																	<div class="profile-stat-row">
																		<span class="label">College</span>
																		<span class="val"
																			style="color:var(--text-primary);font-size:0.75rem">
																			<c:out value="${sessionScope.userCollege}"
																				default="—" />
																		</span>
																	</div>
																	<div class="profile-stat-row">
																		<span class="label">Skill Tags</span>
																		<span class="val"
																			style="color:var(--text-primary);font-size:0.72rem">
																			<c:out value="${sessionScope.userSkills}"
																				default="—" />
																		</span>
																	</div>
																	<div class="profile-stat-row">
																		<span class="label">Member since</span>
																		<span class="val">
																			<fmt:formatDate
																				value="${sessionScope.joinedDate}"
																				pattern="MMM yyyy" />
																		</span>
																	</div>

																	<div class="profile-divider"></div>
																	<a href="editProfile.jsp"
																		class="btn-cv-primary w-100 text-center">Edit
																		Profile</a>
																</div>

																<%-- ANNOUNCEMENTS --%>
																	<div class="mb-4 fade-up">
																		<div class="section-title">Announcements</div>
																		<div class="d-flex flex-column gap-2">
																			<c:choose>
																				<c:when
																					test="${not empty announcements}">
																					<c:forEach var="ann"
																						items="${announcements}">
																						<div class="announce-card">
																							<div class="announce-title">
																								<c:out
																									value="${ann.title}" />
																							</div>
																							<div class="announce-meta">
																								<i
																									class="bi bi-calendar2 me-1"></i>
																								<fmt:formatDate
																									value="${ann.postedOn}"
																									pattern="dd MMM yyyy" />
																								&nbsp;&bull;&nbsp;
																								<c:out
																									value="${ann.hackathonName}" />
																							</div>
																							<div class="announce-body">
																								<c:out
																									value="${ann.body}" />
																							</div>
																						</div>
																					</c:forEach>
																				</c:when>
																				<c:otherwise>
																					<div class="box-wrap">
																						<div class="empty-state"
																							style="padding:1.5rem">
																							<i class="bi bi-megaphone"
																								style="font-size:1.8rem"></i>
																							<p>No announcements yet.</p>
																						</div>
																					</div>
																				</c:otherwise>
																			</c:choose>
																		</div>
																	</div>

																	<%-- QUICK LINKS --%>
																		<div class="fade-up">
																			<div class="section-title">Quick Links</div>
																			<div class="box-wrap">
																				<div
																					style="display:flex;flex-direction:column;gap:0">
																					<c:set var="links" value="${{
              'bi-people,My Team,myTeam',
              'bi-code-slash,My Submissions,submissions.jsp',
              'bi-bar-chart-line,Leaderboard,leaderboard.jsp',
              'bi-question-circle,Help & FAQ,faq.jsp',
              'bi-gear,Account Settings,settings.jsp'
            }}" />
																					<%-- Static quick links since JSTL
																						doesn't support inline arrays
																						--%>
																						<a href="/participants/myTeam"
																							class="quick-link-row">
																							<i class="bi bi-people"></i>
																							My Team <i
																								class="bi bi-chevron-right ms-auto"
																								style="font-size:0.7rem;color:var(--text-muted)"></i>
																						</a>
																						<a href="submissions.jsp"
																							class="quick-link-row">
																							<i
																								class="bi bi-code-slash"></i>
																							My Submissions <i
																								class="bi bi-chevron-right ms-auto"
																								style="font-size:0.7rem;color:var(--text-muted)"></i>
																						</a>
																						<a href="leaderboard.jsp"
																							class="quick-link-row">
																							<i
																								class="bi bi-bar-chart-line"></i>
																							Leaderboard <i
																								class="bi bi-chevron-right ms-auto"
																								style="font-size:0.7rem;color:var(--text-muted)"></i>
																						</a>
																						<a href="faq.jsp"
																							class="quick-link-row"
																							style="border-bottom:none">
																							<i
																								class="bi bi-question-circle"></i>
																							Help & FAQ <i
																								class="bi bi-chevron-right ms-auto"
																								style="font-size:0.7rem;color:var(--text-muted)"></i>
																						</a>
																				</div>
																			</div>
																		</div>

														</div><%-- end sidebar --%>

										</div><%-- end row --%>
									</div><%-- end container --%>





										<script src="assets/js/userHome.js"></script>
						</body>

						</html>