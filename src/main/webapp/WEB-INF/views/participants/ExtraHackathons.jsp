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
				<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet" />

				<!-- Bootstrap 5 -->
				<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

				<!-- Bootstrap Icons -->
				<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

				<!-- CodeVerse Global CSS -->
				<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Codeverse.css" />
			</head>
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