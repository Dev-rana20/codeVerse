<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
			<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
				<c:set var="pageTitle" value="Hackathon Details" scope="request" />
				<c:set var="activePage" value="hackathons" scope="request" />

				<c:set var="monthNum" value="${fn:substring(hack.registrationStartDate, 5, 7)}" />

				<c:choose>
					<c:when test="${monthNum == '01'}">
						<c:set var="monthName" value="JAN" />
					</c:when>
					<c:when test="${monthNum == '02'}">
						<c:set var="monthName" value="FEB" />
					</c:when>
					<c:when test="${monthNum == '03'}">
						<c:set var="monthName" value="MAR" />
					</c:when>
					<c:when test="${monthNum == '04'}">
						<c:set var="monthName" value="APR" />
					</c:when>
					<c:when test="${monthNum == '05'}">
						<c:set var="monthName" value="MAY" />
					</c:when>
					<c:when test="${monthNum == '06'}">
						<c:set var="monthName" value="JUN" />
					</c:when>
					<c:when test="${monthNum == '07'}">
						<c:set var="monthName" value="JUL" />
					</c:when>
					<c:when test="${monthNum == '08'}">
						<c:set var="monthName" value="AUG" />
					</c:when>
					<c:when test="${monthNum == '09'}">
						<c:set var="monthName" value="SEP" />
					</c:when>
					<c:when test="${monthNum == '10'}">
						<c:set var="monthName" value="OCT" />
					</c:when>
					<c:when test="${monthNum == '11'}">
						<c:set var="monthName" value="NOV" />
					</c:when>
					<c:otherwise>
						<c:set var="monthName" value="DEC" />
					</c:otherwise>
				</c:choose>

				<!DOCTYPE html>
				<html lang="en">

				<head>
					<%@ include file="../components/Head.jsp" %>
				</head>
				<style>
					.poster-bg {
						background: #4FA5A0;
						padding: 40px;
						display: flex;
						justify-content: center;
					}

					.poster {
						width: 600px;
						background: #F7F9F9;
						border-radius: 10px;
						padding: 40px 30px;
						position: relative;
						box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
						text-align: center;
					}

					/* HEADER */
					.poster-header {
						background: linear-gradient(180deg, #159A8C, #1FB3A5);
						padding: 15px;
						border-radius: 0 0 50% 50%;
						color: white;
					}

					.festival-tag {
						font-size: 14px;
					}

					/* TITLE */
					.poster-title h1 {
						font-size: 40px;
						font-weight: 800;
						margin: 20px 0;
						color: #222;
					}

					/* SOCIAL */
					.social-icons {
						position: absolute;
						left: -25px;
						top: 150px;
						display: flex;
						flex-direction: column;
						gap: 10px;
					}

					.icon {
						width: 35px;
						height: 35px;
						background: #1FB3A5;
						color: white;
						border-radius: 50%;
						display: flex;
						align-items: center;
						justify-content: center;
					}

					/* INFO CARD */
					.info-card {
						background: #111;
						color: white;
						padding: 15px;
						border-radius: 8px;
						margin: 30px auto;
					}

					.browser-bar {
						display: flex;
						gap: 5px;
						margin-bottom: 10px;
					}

					.browser-bar span {
						width: 10px;
						height: 10px;
						background: #999;
						border-radius: 50%;
					}

					/* DATE BADGE */
					.date-badge {
						position: absolute;
						right: -30px;
						top: 160px;
						background: #159A8C;
						color: white;
						padding: 15px;
						border-radius: 10px;
						text-align: center;
					}

					.date-badge h2 {
						font-size: 28px;
					}

					/* EXTRA */
					.poster-extra {
						margin-top: 20px;
						font-weight: bold;
					}

					/* BUTTON */
					.cv-btn {
						padding: 10px 20px;
						background: #00ffe0;
						border: none;
						border-radius: 8px;
						cursor: pointer;
					}

					.date-badge h4 {
						font-weight: 700;
						letter-spacing: 1px;
					}

					.poster-title h1 {
						font-size: 36px;
						line-height: 1.2;
					}

					.cv-btn-small {
						width: auto !important;
						display: inline-block;
						padding: 8px 16px;
						font-size: 14px;
					}

					.team-box {
						padding: 15px;
						border: 1px solid #eee;
						border-radius: 8px;
						margin-bottom: 12px;
					}

					.team-box h4 {
						margin: 0;
						margin-bottom: 5px;
					}

					.team-members {
						margin-top: 8px;
						font-size: 13px;
						color: #666;
					}

					.cv-hack-right .cv-card {
						margin-bottom: 15px;
					}
				</style>

				<body>


					<%@ include file="../components/navbar.jsp" %>



						<div class="cv-shell">
							<%@ include file="../components/Sidebar.jsp" %>

								<main class="cv-content">

									<c:if test="${not empty success}">
										<div class="alert alert-success cv-msg"
											style="padding: 10px; background: #d4edda; color: #155724; margin-bottom: 10px; border-radius: 5px;">
											${success}</div>
									</c:if>

									<c:if test="${not empty error}">
										<div class="alert alert-danger cv-msg"
											style="padding: 10px; background: #f8d7da; color: #721c24; margin-bottom: 10px; border-radius: 5px;">
											${error}</div>
									</c:if>

									<div class="cv-hack-container">

										<!-- 🔥 POSTER SECTION -->
										<div class="cv-hack-hero poster-mode">
											<div class="cv-hack-overlay"></div>

											<div class="cv-hack-hero-content">
												<h1>${hack.title}</h1>
												<span class="cv-badge">${hack.status}</span>
											</div>

										</div>

										<!-- 🔥 MAIN BODY -->
										<div class="cv-hack-body">

											<!-- LEFT CONTENT -->
											<div class="cv-hack-left">

												<!-- OVERVIEW -->
												<div class="cv-card">
													<div class="cv-section-title">Overview</div>

													<div class="cv-grid-2">
														<div>
															<strong>Event Type:</strong> ${hack.eventType}
														</div>
														<div>
															<strong>Payment:</strong> ${hack.payment}
														</div>
														<c:if test="${fn:toUpperCase(hack.payment) == 'PAID'}">
															<div>
																<strong>Fee:</strong> ₹ ${hack.fee}
															</div>
														</c:if>
														<div>
															<strong>Location:</strong> ${hack.location}
														</div>
														<div>
															<strong>Team Size:</strong> ${hack.minTeamSize} -
															${hack.maxTeamSize}
														</div>
													</div>
												</div>

												<!-- DATES -->
												<div class="cv-card">
													<div class="cv-section-title">Timeline</div>

													<div class="cv-grid-2">
														<div>
															<p class="cv-muted mb-1" style="font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.5px;">Registration</p>
															<strong>Starts:</strong> ${hack.registrationStartDate}<br>
															<strong>Ends:</strong> ${hack.registrationEndDate}
														</div>
														<div>
															<p class="cv-muted mb-1" style="font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.5px;">Event Period</p>
															<strong>Starts:</strong> ${hack.eventStartDate != null ? hack.eventStartDate : 'TBA'}<br>
															<strong>Ends:</strong> ${hack.eventEndDate != null ? hack.eventEndDate : 'TBA'}
														</div>
													</div>
													
													<div class="mt-3 pt-3" style="border-top: 1px dashed var(--border-color);">
														<p class="cv-muted mb-1" style="font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.5px;">Submission Deadline</p>
														<div class="d-flex align-items-center gap-2">
															<i class="bi bi-alarm text-danger"></i>
															<strong class="text-danger">${hack.submissionDeadline != null ? hack.submissionDeadline : 'TBA'}</strong>
														</div>
													</div>
												</div>

												<!-- DESCRIPTION -->
												<div class="cv-card">
													<div class="cv-section-title">Description</div>
													<p class="cv-desc">${description.hackathonDetailsText}</p>
													<c:if test="${not empty description.hackathonDetailsURL}">
														<a href="${description.hackathonDetailsURL}" target="_blank"
															class="btn-cv btn-cv--primary btn-cv--block"> View Full Details </a>
													</c:if>

												</div>

											</div>

											<!-- RIGHT SIDE -->
											<div class="cv-hack-right">

												<div class="cv-hack-right">

													<div class="cv-card cv-register-card">

														<h3>Join this Hackathon 🚀</h3>
														<p class="cv-muted">Register now and start building with
															your team.</p>

														<c:choose>

															<c:when test="${isRegistered}">
																<div class="alert alert-success">✅ You are already
																	registered</div>
															</c:when>

															<c:otherwise>
                                                                <c:choose>
                                                                    <c:when test="${fn:toLowerCase(hack.status) == 'close'}">
                                                                        <div class="alert alert-danger">Registration is closed for this hackathon.</div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <c:choose>
                                                                            <c:when test="${fn:toUpperCase(hack.payment) == 'PAID'}">
                                                                                <form action="/hackathons/${hack.hackathonId}/checkout"
                                                                                    method="get">
                                                                                    <div class="mb-3">
                                                                                        <span class="badge bg-warning text-dark">Required Fee: ₹ ${hack.fee}</span>
                                                                                    </div>
                                                                                    <button
                                                                                        class="btn-cv btn-cv--primary btn-cv--block">
                                                                                        Pay & Register</button>
                                                                                </form>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <form action="/hackathons/${hack.hackathonId}/register"
                                                                                    method="post">
                                                                                    <button
                                                                                        class="btn-cv btn-cv--primary btn-cv--block">
                                                                                        Register Now</button>
                                                                                </form>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </c:otherwise>
                                                                </c:choose>
															</c:otherwise>

														</c:choose>

													</div>


													<!-- TEAM SECTION -->
													<c:if test="${isRegistered}">

														<div class="cv-card">

															<div class="cv-section-title">Available Teams</div>

															<c:if test="${empty teams}">
																<p class="cv-muted">No teams created yet</p>
															</c:if>


															<c:forEach var="t" items="${teams}">

																<div class="team-box">

																	<h4>${t.teamName}</h4>

																	<small> Leader: ${t.teamLeader.firstName}
																		${t.teamLeader.lastName} </small>

																	<div class="team-members">Members:
																		${fn:length(t.members)} / ${hack.maxTeamSize}
																	</div>

																	<form action="/team/requestJoin" method="post">

																		<input type="hidden" name="teamId"
																			value="${t.hackathonTeamId}" />

																		<button
																			class="btn-cv btn-cv--primary btn-cv--sm">

																			Request to Join</button>

																	</form>

																</div>

															</c:forEach>

														</div>


														<c:choose>

															<c:when test="${hasCreatedTeam}">

																<div class="alert alert-info">✅ You already created a
																	team</div>

															</c:when>

															<c:otherwise>

																<a href="/participant/team-register?hackathonId=${hack.hackathonId}"
																	class="btn-cv btn-cv--ghost btn-cv--block"> Create
																	Team </a>

															</c:otherwise>

														</c:choose>

													</c:if>


													<a href="/hackathons" class="cv-btn-outline"> ← Back to
														Hackathons </a>

												</div>

											</div>

										</div>
										<div id="poster" class="poster-bg">

											<div class="poster">

												<!-- HEADER -->
												<div class="poster-header">
													<p class="festival-tag">&lt; CodeVerse Hackathon &gt;</p>
												</div>

												<!-- TITLE -->
												<div class="poster-title">
													<h1>${hack.title}</h1>
												</div>

												<!-- SOCIAL (optional branding) -->
												<div class="social-icons">
													<div class="icon">
														<i class="bi bi-facebook"></i>
													</div>
													<div class="icon">
														<i class="bi bi-instagram"></i>
													</div>
													<div class="icon">
														<i class="bi bi-twitter"></i>
													</div>
												</div>

												<!-- INFO CARD -->
												<div class="info-card">
													<div class="browser-bar">
														<span></span> <span></span> <span></span>
													</div>

													<div class="card-content">
														<h3>${hack.eventType}•${hack.location}</h3>
														<p>${description.hackathonDetailsText}</p>
													</div>
												</div>

												<!-- DATE BADGE -->
												<div class="date-badge">
													<h2>${fn:substring(hack.registrationStartDate, 8, 10)}</h2>
													<h4>${monthName}</h4>
													<p>${hack.registrationStartDate}</p>
												</div>

												<!-- EXTRA INFO -->
												<div class="poster-extra">Team: ${hack.minTeamSize} -
													${hack.maxTeamSize}</div>

											</div>

										</div>

										<!-- DOWNLOAD BUTTON -->
										<div style="text-align: center; margin-top: 20px;">
											<button onclick="downloadPoster()" class="cv-btn">Download
												Poster</button>
										</div>
								</main>
						</div>

						<%@ include file="../components/Footer.jsp" %>
							<%@ include file="../components/Scripts.jsp" %>
								<script
									src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>


								<script>
									function downloadPoster() {
										html2canvas(document.getElementById("poster")).then(canvas => {
											const link = document.createElement("a");
											link.download = "codeverse-poster.png";
											link.href = canvas.toDataURL();
											link.click();
										});
									}
								</script>
								<script>
									setTimeout(() => {
										const success = document.querySelector('.alert-success');
										const error = document.querySelector('.alert-danger');

										if (success) {
											success.style.transition = "0.5s";
											success.style.opacity = "0";
											setTimeout(() => success.remove(), 500);
										}

										if (error) {
											error.style.transition = "0.5s";
											error.style.opacity = "0";
											setTimeout(() => error.remove(), 500);
										}
									}, 3000);
								</script>
				</body>

				</html>