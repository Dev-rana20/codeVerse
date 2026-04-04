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
								<div class="row g-3">

									<c:forEach items="${teams}" var="t">

										<div class="col-12 col-sm-6 col-xl-4">

											<div class="cv-card cv-card--lift">

												<!-- Optional banner (you can customize color if needed) -->
												<div class="cv-card__banner cv-card__banner--primary"></div>

												<div class="cv-card__body">

													<!-- Team Name -->
													<div style="font-weight: 750;font-size: 1.25rem;">${t.teamName}
													</div>

													<!-- Optional subtitle -->
													<div class="text-muted-cv" style="font-size: .75rem;">
														Team ID: ${t.hackathonTeamId}</div>

												</div>

												<div class="cv-card__footer">

													<a href="/judge/evaluate?teamId=${t.hackathonTeamId}"
														class="btn-cv btn-cv--primary btn-cv--sm"> <i
															class="bi bi-pencil-square"></i> Evaluate

													</a>

												</div>

											</div>

										</div>

									</c:forEach>

								</div>

							</main>
					</div>

					<%@ include file="../components/Footer.jsp" %>
						<%@ include file="../components/Scripts.jsp" %>

			</body>

			</html>