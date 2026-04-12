<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
			<c:set var="pageTitle" value="Team: ${team.teamName}" scope="request" />
			<c:set var="activePage" value="team" scope="request" />

			<!DOCTYPE html>
			<html lang="en">

			<head>
				<%@ include file="../components/Head.jsp" %>
					<style>
						.page-wrapper {
							max-width: 1300px;
							margin: 0 auto;
						}

						/* --- HERO SECTION --- */
						.team-hero-banner {
							position: relative;
							background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
							border-radius: 24px;
							padding: 60px 40px;
							margin-bottom: 40px;
							border: 1px solid rgba(255, 255, 255, 0.05);
							overflow: hidden;
							box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
						}

						.team-hero-banner::before {
							content: '';
							position: absolute;
							inset: 0;
							background: radial-gradient(circle at 70% 30%, rgba(99, 102, 241, 0.15) 0%, transparent 60%);
						}

						.team-hero-content {
							position: relative;
							z-index: 2;
						}

						.team-title {
							font-size: 3rem;
							font-weight: 800;
							letter-spacing: -0.02em;
							margin-bottom: 15px;
							background: linear-gradient(to right, #fff, #94a3b8);
							-webkit-background-clip: text;
							-webkit-text-fill-color: transparent;
						}

						/* --- INFO CARDS --- */
						.details-grid {
							display: grid;
							grid-template-columns: 1fr 340px;
							gap: 30px;
						}

						@media (max-width: 1100px) {
							.details-grid {
								grid-template-columns: 1fr;
							}
						}

						.member-row {
							background: rgba(255, 255, 255, 0.02);
							border: 1px solid rgba(255, 255, 255, 0.05);
							border-radius: 16px;
							padding: 20px;
							display: flex;
							align-items: center;
							gap: 15px;
							margin-bottom: 12px;
							transition: all 0.3s;
						}

						.member-row:hover {
							background: rgba(255, 255, 255, 0.04);
							border-color: rgba(99, 102, 241, 0.2);
							transform: translateX(5px);
						}

						.member-avatar {
							width: 48px;
							height: 48px;
							background: #1e293b;
							border: 1px solid #334155;
							border-radius: 12px;
							display: flex;
							align-items: center;
							justify-content: center;
							color: #94a3b8;
							font-size: 1.25rem;
						}

						/* --- STATUS BOXES --- */
						.side-status-box {
							background: linear-gradient(180deg, rgba(99, 102, 241, 0.05) 0%, rgba(15, 23, 42, 0.5) 100%);
							border: 1px solid rgba(99, 102, 241, 0.1);
							border-radius: 20px;
							padding: 24px;
							margin-bottom: 25px;
						}

						/* --- COMMUNICATION HUB --- */
						.comm-hub {
							background: rgba(15, 23, 42, 0.6);
							backdrop-filter: blur(12px);
							border: 1px solid rgba(255, 255, 255, 0.05);
							border-radius: 24px;
							overflow: hidden;
							display: flex;
							flex-direction: column;
							height: 600px;
						}

						.comm-tabs {
							display: flex;
							background: rgba(0, 0, 0, 0.2);
							padding: 5px;
							border-bottom: 1px solid rgba(255, 255, 255, 0.05);
						}

						.comm-tab {
							flex: 1;
							padding: 12px;
							text-align: center;
							cursor: pointer;
							border-radius: 12px;
							font-size: 0.9rem;
							color: #94a3b8;
							transition: all 0.3s;
							display: flex;
							align-items: center;
							justify-content: center;
							gap: 8px;
						}

						.comm-tab.active {
							background: rgba(99, 102, 241, 0.15);
							color: #818cf8;
							font-weight: 600;
						}

						.comm-feed {
							flex-grow: 1;
							overflow-y: auto;
							padding: 24px;
							display: flex;
							flex-direction: column;
							gap: 16px;
							scroll-behavior: smooth;
						}

						.comm-item {
							max-width: 85%;
							display: flex;
							flex-direction: column;
						}

						.comm-item--me {
							align-self: flex-end;
							align-items: flex-end;
						}

						.comm-item--other {
							align-self: flex-start;
							align-items: flex-start;
						}

						.comm-item__bubble {
							padding: 12px 16px;
							border-radius: 18px;
							font-size: 0.95rem;
							line-height: 1.5;
							position: relative;
						}

						.comm-item--me .comm-item__bubble {
							background: #6366f1;
							color: white;
							border-bottom-right-radius: 4px;
						}

						.comm-item--other .comm-item__bubble {
							background: #1e293b;
							color: #f1f5f9;
							border: 1px solid rgba(255, 255, 255, 0.05);
							border-bottom-left-radius: 4px;
						}

						.comm-item__meta {
							font-size: 0.75rem;
							color: #64748b;
							margin-top: 4px;
							display: flex;
							gap: 8px;
						}

						.comm-item__sender {
							font-weight: 600;
							color: #94a3b8;
						}

						/*公告样式*/
						.comm-item--announcement {
							max-width: 100%;
							align-self: center;
							width: 100%;
						}

						.comm-announcement-card {
							background: linear-gradient(to right, rgba(99, 102, 241, 0.1), rgba(139, 92, 246, 0.1));
							border: 1px solid rgba(99, 102, 241, 0.2);
							border-radius: 16px;
							padding: 16px;
							text-align: center;
							position: relative;
							overflow: hidden;
						}

						.comm-announcement-card::before {
							content: 'IMPORTANT';
							position: absolute;
							top: 10px;
							right: -25px;
							background: #6366f1;
							color: white;
							font-size: 0.6rem;
							font-weight: 800;
							padding: 5px 30px;
							transform: rotate(45deg);
						}

						/*文件样式*/
						.file-card {
							display: flex;
							align-items: center;
							gap: 12px;
							background: rgba(255, 255, 255, 0.03);
							border: 1px solid rgba(255, 255, 255, 0.05);
							padding: 12px;
							border-radius: 12px;
							transition: all 0.2s;
						}

						.file-card:hover {
							border-color: #6366f1;
							background: rgba(99, 102, 241, 0.05);
						}

						.comm-input-area {
							padding: 20px;
							background: rgba(0, 0, 0, 0.1);
							border-top: 1px solid rgba(255, 255, 255, 0.05);
						}

						.comm-form {
							display: flex;
							gap: 12px;
						}

						.comm-input {
							flex-grow: 1;
							background: #0f172a !important;
							border: 1px solid #334155 !important;
							color: white !important;
							border-radius: 14px !important;
							padding: 12px 18px !important;
						}

						.comm-input:focus {
							border-color: #6366f1 !important;
							box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.15) !important;
						}

						.comm-scroll-btn {
							position: absolute;
							bottom: 100px;
							right: 30px;
							width: 40px;
							height: 40px;
							border-radius: 50%;
							background: #6366f1;
							color: white;
							display: none;
							align-items: center;
							justify-content: center;
							cursor: pointer;
							box-shadow: 0 4px 12px rgba(99, 102, 241, 0.4);
							z-index: 10;
						}
					</style>
			</head>

			<body>

				<%@ include file="../components/navbar.jsp" %>

					<div class="cv-shell">
						<%@ include file="../components/Sidebar.jsp" %>

							<main class="cv-content">
								<div class="page-wrapper">

									<c:if test="${not empty success}">
										<div class="alert alert-success cv-msg mb-4">${success}</div>
									</c:if>
									<c:if test="${not empty error}">
										<div class="alert alert-danger cv-msg mb-4">${error}</div>
									</c:if>

									<!-- HERO -->
									<div class="team-hero-banner">
										<div class="team-hero-content">
											<div class="cv-page-eyebrow">
												<i class="bi bi-shield-check"></i> Team Console
											</div>
											<h1 class="team-title">${team.teamName}</h1>
											<div class="d-flex gap-3 align-items-center">
												<span class="text-muted-cv small">
													<i class="bi bi-hash me-1"></i> Hackathon: <span
														class="text-white">${team.hackathon.title}</span>
												</span>
												<div class="cv-badge cv-badge--ongoing">
													<span class="cv-badge__dot"></span> ${fn:length(members)} Members
												</div>
												<c:if test="${not empty team.placement}">
													<div class="cv-badge" style="background: rgba(255, 215, 0, 0.15); color: #ffd700; border: 1px solid rgba(255, 215, 0, 0.3);">
														<i class="bi bi-trophy-fill me-1"></i> ${team.placement == 1 ? '1st' : (team.placement == 2 ? '2nd' : '3rd')} Place
													</div>
												</c:if>
											</div>
										</div>
									</div>

									<div class="details-grid">

										<!-- MAIN CONTENT AREA -->
										<div class="details-left">

											<!-- TEAM MEMBERS -->
											<div class="cv-card mb-4">
												<div class="cv-card__header d-flex justify-content-between">
													<div class="d-flex align-items-center gap-2">
														<i class="bi bi-people-fill text-accent"></i>
														<h3>Team Roster</h3>
													</div>
												</div>
												<div class="cv-card__body">
													<c:forEach var="m" items="${members}">
														<c:if test="${m.status == 'ACCEPTED'}">
															<div class="member-row">
																<div class="member-avatar">
																	<i class="bi bi-person"></i>
																</div>
																<div class="flex-grow-1">
																	<div
																		class="d-flex justify-content-between align-items-start">
																		<div>
																			<h5 class="mb-1 text-white">
																				${m.member.firstName}
																				${m.member.lastName}</h5>
																			<p class="mb-0 text-muted small">
																				${m.member.email}</p>
																		</div>
																		<span
																			class="cv-badge ${m.roleTitle == 'LEADER' ? 'cv-badge--ongoing' : 'cv-badge--upcoming'}">
																			${m.roleTitle}
																		</span>
																	</div>
																</div>
																<c:if
																	test="${team.teamLeader.userId == sessionScope.user.userId and m.member.userId ne team.teamLeader.userId}">
																	<form action="/team/removeMember" method="post">
																		<input type="hidden" name="teamId"
																			value="${team.hackathonTeamId}" />
																		<input type="hidden" name="memberId"
																			value="${m.member.userId}" />
																		<button type="submit"
																			class="btn btn-link text-danger p-0"
																			title="Remove Member">
																			<i class="bi bi-person-x fs-5"></i>
																		</button>
																	</form>
																</c:if>
															</div>
														</c:if>
													</c:forEach>
												</div>
											</div>

											<!-- JOIN REQUESTS (Leader Only) -->
											<c:if test="${team.teamLeader.userId == sessionScope.user.userId}">
												<div class="cv-card mb-4">
													<div class="cv-card__header">
														<i class="bi bi-person-plus-fill text-accent"></i>
														<h3>Enrollment Requests</h3>
													</div>
													<div class="cv-card__body">
														<c:choose>
															<c:when test="${empty requests}">
																<div class="text-center py-4 text-muted small">No
																	pending requests</div>
															</c:when>
															<c:otherwise>
																<c:forEach var="r" items="${requests}">
																	<div class="member-row">
																		<div class="member-avatar text-warning"><i
																				class="bi bi-clock-history"></i></div>
																		<div class="flex-grow-1">
																			<h5 class="mb-1 text-white">
																				${r.member.firstName}
																				${r.member.lastName}</h5>
																			<p class="mb-0 text-muted small">
																				${r.member.email}</p>
																		</div>
																		<div class="d-flex gap-2">
																			<form action="/team/acceptRequest"
																				method="post">
																				<input type="hidden" name="teamId"
																					value="${team.hackathonTeamId}" />
																				<input type="hidden" name="memberId"
																					value="${r.member.userId}" />
																				<button
																					class="btn-cv btn-cv--primary btn-cv--sm">Accept</button>
																			</form>
																			<form action="/team/rejectRequest"
																				method="post">
																				<input type="hidden" name="teamId"
																					value="${team.hackathonTeamId}" />
																				<input type="hidden" name="memberId"
																					value="${r.member.userId}" />
																				<button
																					class="btn-cv btn-cv--danger btn-cv--sm">Reject</button>
																			</form>
																		</div>
																	</div>
																</c:forEach>
															</c:otherwise>
														</c:choose>
													</div>
												</div>

												<!-- INVITE MEMBERS -->
												<div class="cv-card mb-4">
													<div class="cv-card__header">
														<i class="bi bi-envelope-plus-fill text-accent"></i>
														<h3>Invite Contributors</h3>
													</div>
													<div class="cv-card__body">
														<c:choose>
															<c:when test="${empty eligibleUsers}">
																<div class="text-center py-4 text-muted small">No
																	eligible users available to invite</div>
															</c:when>
															<c:otherwise>
																<form action="/team/invite" method="post"
																	class="row g-2">
																	<input type="hidden" name="teamId"
																		value="${team.hackathonTeamId}" />
																	<div class="col-md-9">
																		<select name="memberId"
																			class="form-select bg-dark text-white border-secondary"
																			required>
																			<option value="">-- Search Registry --
																			</option>
																			<c:forEach var="u" items="${eligibleUsers}">
																				<option value="${u.userId}">
																					${u.firstName} ${u.lastName}
																					[${u.email}]</option>
																			</c:forEach>
																		</select>
																	</div>
																	<div class="col-md-3">
																		<button type="submit"
																			class="btn-cv btn-cv--primary w-100">Send
																			Invite</button>
																	</div>
																</form>
															</c:otherwise>
														</c:choose>
													</div>
												</div>
											</c:if>

											<!-- COMMUNICATION HUB -->
											<div class="comm-hub mb-4" id="communicationHub">
												<div class="comm-tabs">
													<div class="comm-tab active" data-target="feed-all">
														<i class="bi bi-chat-dots-fill"></i> Discussions
													</div>
													<div class="comm-tab" data-target="feed-announcements">
														<i class="bi bi-megaphone-fill"></i> Announcements
													</div>
													<div class="comm-tab" data-target="feed-files">
														<i class="bi bi-file-earmark-arrow-up-fill"></i> Shared Files
													</div>
												</div>

												<div class="comm-feed" id="mainFeed">
													<c:choose>
														<c:when test="${empty communications}">
															<div class="text-center py-5 text-muted">
																<i class="bi bi-chat-quote fs-1 d-block mb-3"></i>
																<p>Start the conversation! Only team members can see these messages.</p>
															</div>
														</c:when>
														<c:otherwise>
															<c:forEach var="c" items="${communications}">
																<c:choose>
																	<c:when test="${c.type == 'ANNOUNCEMENT'}">
																		<div class="comm-item comm-item--announcement feed-item" data-type="ANNOUNCEMENT">
																			<div class="comm-announcement-card">
																				<h5 class="text-accent mb-2"><i class="bi bi-megaphone"></i> Team Announcement</h5>
																				<p class="mb-2 text-white">${c.content}</p>
																				<div class="text-muted-cv small">
																					Posted by ${c.sender.firstName} &bull; 
																					<span class="time-ago">${c.createdAt}</span>
																				</div>
																			</div>
																		</div>
																	</c:when>
																	<c:when test="${c.type == 'FILE'}">
																		<div class="comm-item ${c.sender.userId == sessionScope.user.userId ? 'comm-item--me' : 'comm-item--other'} feed-item" data-type="FILE">
																			<div class="comm-item__bubble">
																				<div class="file-card">
																					<div class="member-avatar" style="width: 40px; height: 40px; background: rgba(99, 102, 241, 0.1); color: #818cf8;">
																						<i class="bi bi-file-earmark-code"></i>
																					</div>
																					<div class="flex-grow-1 overflow-hidden">
																						<div class="text-truncate fw-bold small text-white">${c.fileName}</div>
																						<div class="small text-muted">Shared by ${c.sender.firstName}</div>
																					</div>
																					<a href="${c.fileUrl}" target="_blank" class="btn btn-sm btn-link text-accent p-0">
																						<i class="bi bi-download fs-5"></i>
																					</a>
																				</div>
																			</div>
																			<div class="comm-item__meta">
																				<span class="time-ago">${c.createdAt}</span>
																			</div>
																		</div>
																	</c:when>
																	<c:otherwise>
																		<div class="comm-item ${c.sender.userId == sessionScope.user.userId ? 'comm-item--me' : 'comm-item--other'} feed-item" data-type="CHAT">
																			<c:if test="${c.sender.userId != sessionScope.user.userId}">
																				<span class="comm-item__sender small mb-1">${c.sender.firstName}</span>
																			</c:if>
																			<div class="comm-item__bubble">
																				${c.content}
																			</div>
																			<div class="comm-item__meta">
																				<span class="time-ago">${c.createdAt}</span>
																			</div>
																		</div>
																	</c:otherwise>
																</c:choose>
															</c:forEach>
														</c:otherwise>
													</c:choose>
												</div>

												<div class="comm-input-area">
													<!-- Chat Form -->
													<form action="/team/communication/send" method="post" class="comm-form" id="chatForm">
														<input type="hidden" name="teamId" value="${team.hackathonTeamId}" />
														<input type="hidden" name="type" id="messageType" value="CHAT" />
														
														<div class="dropup me-1">
															<button class="btn btn-cv btn-cv--ghost btn-cv--sm px-3" type="button" data-bs-toggle="dropdown" aria-expanded="false">
																<i class="bi bi-plus-circle"></i>
															</button>
															<ul class="dropdown-menu dropdown-menu-dark">
																<li><a class="dropdown-item" href="#" onclick="setMessageType('CHAT')"><i class="bi bi-chat me-2"></i> Normal Chat</a></li>
																<c:if test="${team.teamLeader.userId == sessionScope.user.userId}">
																	<li><a class="dropdown-item" href="#" onclick="setMessageType('ANNOUNCEMENT')"><i class="bi bi-megaphone me-2"></i> Announcement</a></li>
																</c:if>
																<li><hr class="dropdown-divider"></li>
																<li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#fileUploadModal"><i class="bi bi-file-earmark-arrow-up me-2"></i> Upload Resource</a></li>
															</ul>
														</div>

														<input type="text" name="content" class="comm-input" placeholder="Type a message..." required />
														<button type="submit" class="btn btn-cv btn-cv--primary" id="sendBtn">
															<i class="bi bi-send-fill"></i>
														</button>
													</form>
												</div>
											</div>

										</div>

										<!-- SIDEBAR -->
										<div class="details-right">

											<!-- SUBMISSION STATUS -->
											<div class="side-status-box">
												<div class="d-flex align-items-center gap-2 mb-3">
													<i class="bi bi-cloud-arrow-up text-accent"></i>
													<h4 class="mb-0">Project Status</h4>
												</div>
												<c:choose>
													<c:when test="${not empty finalSubmission}">
														<div class="mb-3">
															<span
																class="cv-badge cv-badge--success w-100 py-2 d-block text-center">
																<i class="bi bi-check2-circle"></i> Final Submitted
															</span>
														</div>
															<div class="bg-dark p-3 rounded-4 border border-secondary mb-3">
																<div
																	class="small text-muted mb-1 uppercase tracking-wider">
																	Evaluation</div>
																<c:choose>
																	<c:when test="${isEvaluated or finalSubmission.status == 'EVALUATED'}">
																		<span class="text-success small fw-bold"><i
																				class="bi bi-patch-check"></i> Scoring
																			Complete</span>
																	</c:when>
																	<c:otherwise>
																		<span class="text-warning small fw-bold"><i
																				class="bi bi-hourglass-split"></i>
																			Awaiting
																			Judge</span>
																	</c:otherwise>
																</c:choose>
															</div>
														<c:if test="${not empty finalSubmission.githubLink}">
															<a href="${finalSubmission.githubLink}" target="_blank"
																class="btn-cv btn-cv--ghost btn-cv--sm w-100 mb-2">
																<i class="bi bi-github me-1"></i> Repository
															</a>
														</c:if>
													</c:when>
													<c:otherwise>
														<div class="alert alert-warning py-2 small mb-3">
															<i class="bi bi-exclamation-triangle me-1"></i> No final
															work submitted.
														</div>
														<c:if test="${empty finalSubmission and team.teamLeader.userId == sessionScope.user.userId}">
															<button class="btn-cv btn-cv--primary w-100" type="button"
																data-bs-toggle="collapse"
																data-bs-target="#updateSubmission">
																Submit Final Work
															</button>
														</c:if>
													</c:otherwise>
												</c:choose>

												<c:if test="${empty finalSubmission and team.teamLeader.userId == sessionScope.user.userId}">
													<div class="collapse mt-3" id="updateSubmission">
														<form action="/team/finalSubmit" method="post"
															enctype="multipart/form-data"
															class="p-3 bg-dark border border-secondary rounded-4">
															<input type="hidden" name="teamId"
																value="${team.hackathonTeamId}" />
															<div class="mb-3">
																<label class="form-label small text-muted">Repo
																	URL</label>
																<input type="url" name="finalLink"
																	class="form-control form-control-sm bg-dark text-white border-secondary"
																	placeholder="GitHub link"
																	value="${finalSubmission.githubLink}" required />
															</div>
															<div class="mb-3">
																<label class="form-label small text-muted">Brief
																	Pitch</label>
																<textarea name="description"
																	class="form-control form-control-sm bg-dark text-white border-secondary"
																	rows="3"
																	required>${finalSubmission.description}</textarea>
															</div>
															<div class="mb-3">
																<label class="form-label small text-muted">Build
																	File</label>
																<input type="file" name="projectFile"
																	class="form-control form-control-sm bg-dark text-white border-secondary" />
															</div>
															<button type="submit"
																class="btn-cv btn-cv--primary btn-cv--sm w-100">
																Execute Submit
															</button>
														</form>
													</div>
												</c:if>
											</div>

											<!-- ACTIONS -->
											<div class="cv-card p-3">
												<div class="d-grid gap-2">
													<c:choose>
														<c:when
															test="${team.teamLeader.userId == sessionScope.user.userId}">
															<form action="/team/delete" method="post">
																<input type="hidden" name="teamId"
																	value="${team.hackathonTeamId}" />
																<button
																	class="btn btn-outline-danger w-100 btn-sm rounded-3 py-2"
																	onclick="return confirm('Disband team?')">
																	<i class="bi bi-trash me-1"></i> Disband Team
																</button>
															</form>
														</c:when>
														<c:otherwise>
															<form action="/team/leave" method="post">
																<input type="hidden" name="teamId"
																	value="${team.hackathonTeamId}" />
																<button
																	class="btn btn-outline-danger w-100 btn-sm rounded-3 py-2">
																	<i class="bi bi-box-arrow-right me-1"></i> Leave
																	Team
																</button>
															</form>
														</c:otherwise>
													</c:choose>
													<a href="/hackathonDetail/${team.hackathon.hackathonId}"
														class="btn-cv btn-cv--ghost btn-cv--sm text-center">
														<i class="bi bi-arrow-left me-1"></i> Hackathon Page
													</a>
												</div>
											</div>

										</div>

									</div>
								</div>
							</main>
					</div>

					<%@ include file="../components/Footer.jsp" %>
						<%@ include file="../components/Scripts.jsp" %>

							<script>
								setTimeout(() => {
									const msgs = document.querySelectorAll('.cv-msg');
									msgs.forEach(msg => {
										msg.style.transition = "0.5s";
										msg.style.opacity = "0";
										setTimeout(() => msg.remove(), 500);
									});
								}, 4000);

								// Communication Hub JS
								const commTabs = document.querySelectorAll('.comm-tab');
								const feedItems = document.querySelectorAll('.feed-item');
								const messageTypeInput = document.getElementById('messageType');
								const chatInput = document.querySelector('.comm-input');
								const mainFeed = document.getElementById('mainFeed');

								commTabs.forEach(tab => {
									tab.addEventListener('click', () => {
										commTabs.forEach(t => t.classList.remove('active'));
										tab.classList.add('active');
										
										const filterTarget = tab.getAttribute('data-target');
										filterFeed(filterTarget);
									});
								});

								function filterFeed(target) {
									feedItems.forEach(item => {
										const type = item.getAttribute('data-type');
										if (target === 'feed-all') {
											item.style.display = 'flex';
										} else if (target === 'feed-announcements' && type === 'ANNOUNCEMENT') {
											item.style.display = 'flex';
										} else if (target === 'feed-files' && type === 'FILE') {
											item.style.display = 'flex';
										} else {
											item.style.display = 'none';
										}
									});
								}

								function setMessageType(type) {
									messageTypeInput.value = type;
									if (type === 'ANNOUNCEMENT') {
										chatInput.placeholder = "Write your announcement...";
										chatInput.classList.add('border-primary');
									} else {
										chatInput.placeholder = "Type a message...";
										chatInput.classList.remove('border-primary');
									}
								}

								// Scroll to bottom on load
								if (mainFeed) {
									mainFeed.scrollTop = mainFeed.scrollHeight;
								}
							</script>

							<!-- FILE UPLOAD MODAL (Moved to root for better performance/z-index) -->
							<div class="modal fade" id="fileUploadModal" tabindex="-1">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content bg-dark border-secondary rounded-4" style="box-shadow: 0 0 50px rgba(0,0,0,0.5);">
										<div class="modal-header border-0 pb-0">
											<h5 class="modal-title text-white">Share Resource</h5>
											<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
										</div>
										<div class="modal-body">
											<form action="/team/communication/upload" method="post" enctype="multipart/form-data">
												<input type="hidden" name="teamId" value="${team.hackathonTeamId}" />
												<div class="mb-4">
													<label class="form-label text-muted small">Select File (Max 10MB)</label>
													<input type="file" name="teamFile" class="form-control bg-dark text-white border-secondary" required />
													<div class="form-text text-muted-cv small">Supported: PDF, Images, ZIP, Source Code.</div>
												</div>
												<button type="submit" class="btn-cv btn-cv--primary w-100">Upload and Share</button>
											</form>
										</div>
									</div>
								</div>
							</div>

			</body>

			</html>