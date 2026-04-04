<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<c:set var="pageTitle" value="My Teams" scope="request" />
		<c:set var="activePage" value="team" scope="request" />

		<!DOCTYPE html>
		<html lang="en">

		<head>
			<%@ include file="../components/Head.jsp" %>
		</head>

		<body>

			<%@ include file="../components/navbar.jsp" %>

				<div class="cv-shell">
					<%@ include file="../components/Sidebar.jsp" %>

						<main class="cv-content">

							<!-- PAGE HEADER -->
							<div class="cv-page-header">
								<div class="cv-page-header__left">
									<div class="cv-page-eyebrow">
										<i class="bi bi-collection"></i> Explore
									</div>

									<h1 class="cv-page-title">My Team</h1>
									<p class="cv-page-subtitle">Manage your team memberships and
										invitations.</p>
								</div>
							</div>

							<%-- ALERTS --%>
								<c:if test="${not empty success}">
									<div class="alert alert-success cv-msg">${success}</div>
								</c:if>

								<c:if test="${not empty error}">
									<div class="alert alert-danger cv-msg">${error}</div>
								</c:if>


								<div class="row g-4">



									<%-- MY TEAMS (ACCEPTED) --%>
										<div class="col-lg-8 col-12">
											<div class="cv-card h-100">

												<div class="cv-card__header">
													<i class="bi bi-people-fill"></i>
													<h2>My Teams</h2>
												</div>

												<div class="cv-card__body">
													<c:set var="hasAccepted" value="false" />

													<c:forEach var="tm" items="${myTeams}">
														<c:if test="${tm.status == 'ACCEPTED'}">

															<c:set var="hasAccepted" value="true" />

															<div class="cv-card mb-3 p-3">

																<div
																	style="display: flex; justify-content: space-between; align-items: start;">

																	<div>
																		<h4>${tm.team.teamName}</h4>

																		<p style="color: #666; margin: 5px 0;">
																			Hackathon:
																			${tm.team.hackathon.title}</p>

																		<p style="color: #666; margin: 5px 0;">Leader:
																			${tm.team.teamLeader.firstName}
																			${tm.team.teamLeader.lastName}</p>

																		<span class="cv-badge">
																			${tm.roleTitle} </span>

																	</div>

																	<a href="/team/details/${tm.team.hackathonTeamId}"
																		class="btn-cv btn-cv--primary btn-cv--sm"> <i
																			class="bi bi-eye"></i> View Team
																	</a>

																</div>

															</div>

														</c:if>
													</c:forEach>


													<c:if test="${!hasAccepted}">
														<div class="cv-empty">
															<i class="bi bi-people"></i>
															<p>You haven't joined any teams yet</p>
														</div>
													</c:if>

												</div>

											</div>
										</div>

										<%-- PENDING INVITATIONS --%>
											<div class="col-lg-4 col-12">
												<div class="cv-card h-100">
													<div class="cv-card__header">
														<i class="bi bi-envelope"></i>
														<h2>Pending Invitations</h2>
													</div>

													<div class="cv-card__body">
														<c:set var="hasPending" value="false" />

														<c:forEach var="tm" items="${myTeams}">
															<c:if test="${tm.status == 'PENDING'}">
																<c:set var="hasPending" value="true" />

																<div class="cv-card mb-3 p-3">
																	<h4>${tm.team.teamName}</h4>

																	<p style="color: #666; margin: 5px 0;">Hackathon:
																		${tm.team.hackathon.title}</p>

																	<p style="color: #666; margin: 5px 0;">Leader:
																		${tm.team.teamLeader.firstName}
																		${tm.team.teamLeader.lastName}</p>

																	<div
																		style="margin-top: 10px; display: flex; gap: 10px;">

																		<form method="post" action="/team/accept">
																			<input type="hidden" name="teamId"
																				value="${tm.team.hackathonTeamId}" />

																			<button
																				class="btn-cv btn-cv--primary btn-cv--sm">
																				<i class="bi bi-check2"></i> Accept
																			</button>
																		</form>

																		<form method="post" action="/team/reject">
																			<input type="hidden" name="teamId"
																				value="${tm.team.hackathonTeamId}" />

																			<button
																				class="btn-cv btn-cv--ghost btn-cv--sm">
																				<i class="bi bi-x"></i> Reject
																			</button>
																		</form>

																	</div>
																</div>

															</c:if>
														</c:forEach>

														<c:if test="${!hasPending}">
															<div class="cv-empty">
																<i class="bi bi-inbox"></i>
																<p>No pending invitations</p>
															</div>
														</c:if>

													</div>
												</div>
											</div>

								</div>

						</main>

				</div>

				<%@ include file="../components/Footer.jsp" %>
					<%@ include file="../components/Scripts.jsp" %>

		</body>

		</html>