<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<c:set var="pageTitle" value="Leaderboard" scope="request" />
		<c:set var="activePage" value="leaderboard" scope="request" />

		<!DOCTYPE html>
		<html lang="en">

		<head>
			<%@ include file="../components/Head.jsp" %>
				<meta charset="UTF-8">
		</head>

		<body>

			<%@ include file="../components/navbar.jsp" %>

				<div class="cv-shell">

					<%@ include file="../components/Sidebar.jsp" %>

						<main class="cv-content">

							<!-- PAGE HEADER -->
							<div class="cv-page-header">
								<div>
									<h1 class="cv-page-title">🏆 Leaderboard</h1>
									<p class="cv-page-subtitle">Top performing teams in this
										hackathon</p>
								</div>
							</div>

							<!-- TABLE CARD -->
							<div class="cv-card">

								<div class="cv-card__header" style="display:flex;justify-content:space-between;align-items:center;">
									<h3>Rankings</h3>
									<a href="/leaderboard/export?hackathonId=${hackathonId}"
										class="btn-cv btn-cv--ghost btn-cv--sm">
										<i class="bi bi-download"></i> Export CSV
									</a>
								</div>

								<div class="cv-card__body">

									<div class="table-responsive">
										<table class="cv-table text-center">

											<thead>
												<tr>
													<th>#</th>
													<th>Team</th>
													<th>Innovation</th>
													<th>Technical</th>
													<th>UI/UX</th>
													<th>Functionality</th>
													<th>Presentation</th>
													<th>Impact</th>
													<th>Total</th>
													<th>Remarks</th>
												</tr>
											</thead>

											<tbody>

												<c:forEach items="${leaderboard}" var="e" varStatus="s">

													<tr>

														<td>
															<c:choose>
																<c:when test="${s.index == 0}">
																	<i class="bi bi-trophy-fill text-warning"></i>
																</c:when>
																<c:when test="${s.index == 1}">
																	<i class="bi bi-award-fill text-secondary"></i>
																</c:when>
																<c:when test="${s.index == 2}">
																	<i class="bi bi-award text-bronze"></i>
																</c:when>
																<c:otherwise>
																	#${s.index + 1}
																</c:otherwise>
															</c:choose>
														</td>

														<!-- Team Name (FIXED DTO FIELD) -->
														<td style="font-weight: 600;">${e.teamName}</td>

														<!-- Scores -->
														<td>${e.innovation}</td>
														<td>${e.technical}</td>
														<td>${e.uiUx}</td>
														<td>${e.functionality}</td>
														<td>${e.presentation}</td>
														<td>${e.impact}</td>

														<!-- Total -->
														<td><b>${e.totalScore}</b></td>

														<!-- Remarks -->
														<td><span style="font-size: 0.85rem; color: gray;">
																${e.remarks} </span></td>

													</tr>

												</c:forEach>

												<c:if test="${empty leaderboard}">
													<tr>
														<td colspan="10">No evaluations yet</td>
													</tr>
												</c:if>

											</tbody>

										</table>
									</div>

								</div>
							</div>

						</main>
				</div>

				<%@ include file="../components/Footer.jsp" %>
					<%@ include file="../components/Scripts.jsp" %>

		</body>

		</html>