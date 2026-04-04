<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<c:set var="pageTitle" value="Leaderboard" scope="request" />
		<c:set var="activePage" value="leaderboard" scope="request" />

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
								<div>
									<h1 class="cv-page-title">🏆 Leaderboard</h1>
									<p class="cv-page-subtitle">Select hackathon to view
										leaderboard</p>
								</div>
							</div>


							<!-- SELECT HACKATHON -->
							<div class="cv-card">

								<div class="cv-card__header">
									<h3>Select Hackathon</h3>
								</div>

								<div class="cv-card__body">

									<form action="/leaderboard" method="get">

										<div class="row align-items-end">

											<div class="col-md-8">
												<label class="form-label">Hackathon</label> <select name="hackathonId"
													class="form-select" required>

													<option value="">Select Hackathon</option>

													<c:forEach var="h" items="${hackathons}">
														<option value="${h.hackathonId}">${h.title}</option>
													</c:forEach>

												</select>
											</div>

											<div class="col-md-4">

												<button class="btn-cv btn-cv--primary w-100">

													<i class="bi bi-trophy"></i> View Leaderboard

												</button>

											</div>

										</div>

									</form>

								</div>

							</div>


							<!-- OPTIONAL: SHOW QUICK LINKS -->
							<div class="row g-4 mt-3">

								<c:forEach var="h" items="${hackathons}">

									<div class="col-lg-4 col-md-6">

										<div class="cv-card h-100">

											<div class="cv-card__body d-flex flex-column">

												<h5>${h.title}</h5>

												<div class="mt-auto">

													<a href="/leaderboard?hackathonId=${h.hackathonId}"
														class="btn-cv btn-cv--primary btn-cv--sm"> <i
															class="bi bi-trophy"></i> View Leaderboard

													</a>

												</div>

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