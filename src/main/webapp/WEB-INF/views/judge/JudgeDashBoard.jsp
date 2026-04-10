<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

			<c:set var="pageTitle" value="Judge Dashboard" scope="request" />
			<c:set var="activePage" value="judgeDashboard" scope="request" />

			<!DOCTYPE html>
			<html lang="en" data-page="judgeDashboard">

			<head>
				<%@ include file="../components/Head.jsp" %>
			</head>

			<body data-page="judgeDashboard">

				<%@ include file="../components/navbar.jsp" %>

					<div class="cv-shell">

						<%@ include file="../components/SidebarJudge.jsp" %>

							<main class="cv-content">

								<!-- HEADER -->
								<div class="cv-page-header">
									<div>
										<div class="cv-page-eyebrow">
											<i class="bi bi-person-badge"></i> Judge Panel
										</div>
										<h1 class="cv-page-title">
											Welcome Judge, <span class="hi">${sessionScope.user.firstName}</span>
										</h1>
										<p class="cv-page-subtitle">Review assigned hackathons and
											evaluate teams.</p>
									</div>
								</div>

								<!-- STATS -->
								<div class="row g-3 mb-4">
									<div class="col-6 col-xl-3">
										<div class="cv-stat">
											<div class="cv-stat__icon cv-stat__icon--cyan">
												<i class="bi bi-journal-code"></i>
											</div>
											<div>
												<div class="cv-stat__val">${fn:length(assignments)}</div>
												<div class="cv-stat__label">Assigned Hackathons</div>
											</div>
										</div>
									</div>
								</div>

								<!-- ASSIGNED HACKATHONS -->
								<div class="cv-section-title">Assigned Hackathons</div>

								<c:choose>

									<c:when test="${not empty assignments}">

										<div class="row g-3">

											<c:forEach items="${assignments}" var="a">

												<div class="col-12 col-sm-6 col-xl-4">

													<div class="cv-card cv-card--lift">

														<div
															class="cv-card__banner cv-card__banner--${a.hackathon.status}">
														</div>

														<div class="cv-card__body">

															<div class="d-flex justify-content-between align-items-start mb-2">
																<span class="cv-badge cv-badge--${fn:toLowerCase(a.hackathon.status)}">
																	${a.hackathon.status}
																</span>
																<span class="cv-badge cv-badge--cyan" style="font-size: 0.7rem;">
																	Assigned: ${a.assignedAt}
																</span>
															</div>

															<div style="font-weight: 700; font-size: 1.1rem; margin-bottom: 0.5rem;">${a.hackathon.title}</div>

															<div class="text-muted-cv" style="font-size: .8rem; margin-bottom: 0.25rem;">
																<i class="bi bi-geo-alt"></i> ${a.hackathon.location}
															</div>
															
															<div class="lifecycle-info mt-3" style="font-size: 0.75rem; color: var(--text-muted);">
																<div class="d-flex justify-content-between mb-1">
																	<span>Reg. Deadline:</span>
																	<span class="text-info">${a.hackathon.registrationEndDate}</span>
																</div>
																<div class="d-flex justify-content-between">
																	<span>Sub. Deadline:</span>
																	<span class="text-danger">${a.hackathon.submissionDeadline != null ? a.hackathon.submissionDeadline : 'TBA'}</span>
																</div>
															</div>

														</div>

														<div class="cv-card__footer">

															<a href="/judge/view-teams?hackathonId=${a.hackathon.hackathonId}"
																class="btn-cv btn-cv--primary btn-cv--sm"> <i
																	class="bi bi-people"></i> View Teams
															</a>

														</div>

													</div>

												</div>

											</c:forEach>

										</div>

									</c:when>

									<c:otherwise>

										<div class="cv-card">
											<div class="cv-empty">
												<i class="bi bi-clipboard-x"></i>
												<h3>No hackathons assigned</h3>
												<p>Admin will assign hackathons to you.</p>
											</div>
										</div>

									</c:otherwise>

								</c:choose>

							</main>
					</div>

					<%@ include file="../components/Footer.jsp" %>
						<%@ include file="../components/Scripts.jsp" %>

			</body>

			</html>