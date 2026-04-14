<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<c:set var="pageTitle" value="Submissions" scope="request" />
		<c:set var="activePage" value="submissions" scope="request" />

		<!DOCTYPE html>
		<html lang="en">

		<head>
			<%@ include file="../components/Head.jsp" %>
				<style>
					.cv-card h4 {
						min-height: 60px;
					}
					.btn-completed {
						background: #198754 !important;
						color: white !important;
						border-color: #198754 !important;
						transition: all 0.3s ease;
					}
					.btn-completed:hover {
						background: #157347 !important;
						border-color: #146c43 !important;
						box-shadow: 0 4px 12px rgba(25, 135, 84, 0.3);
						transform: translateY(-2px);
					}
				</style>
		</head>

		<body>

			<%@ include file="../components/navbar.jsp" %>

				<div class="cv-shell">

					<%@ include file="../components/Sidebar.jsp" %>

						<main class="cv-content">


							<!-- Header -->
							<div class="cv-page-header">
								<div class="cv-page-header__left">
									<div class="cv-page-eyebrow">
										<i class="bi bi-cloud-arrow-up fs-6"></i> Submit
									</div>

									<h1 class="cv-page-title">Submissions</h1>

									<p class="cv-page-subtitle">Browse, filter and submit to
										hackathons.</p>
								</div>
							</div>


							<div class="row g-4">

								<c:forEach var="r" items="${registrations}">

									<div class="col-xl-4 col-lg-6 col-12">

										<div class="cv-card h-100">

											<div class="cv-card__body">

												<h4 class="mb-3">${r.hackathon.title}</h4>

												<div class="d-flex justify-content-between align-items-center">

													<span class="cv-badge"> Hackathon </span> 
													
													<c:choose>
														<c:when test="${r.finalSubmitted}">
															<a href="/participant/submissions/${r.hackathon.hackathonId}"
																class="btn-cv btn-cv--sm btn-completed"> 
																<i class="bi bi-check-circle-fill"></i> Completed
															</a>
														</c:when>
														<c:otherwise>
															<a href="/participant/submissions/${r.hackathon.hackathonId}"
																class="btn-cv btn-cv--primary btn-cv--sm"> 
																<i class="bi bi-cloud-arrow-up"></i> Submit
															</a>
														</c:otherwise>
													</c:choose>

												</div>

											</div>

										</div>

									</div>

								</c:forEach>


								<c:if test="${empty registrations}">
									<div class="col-12">
										<div class="cv-empty">
											<i class="bi bi-cloud-slash"></i>
											<p>No hackathons available for submission</p>
										</div>
									</div>
								</c:if>

							</div>


						</main>
				</div>

				<%@ include file="../components/Footer.jsp" %>
					<%@ include file="../components/Scripts.jsp" %>

		</body>

		</html>