<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

			<c:set var="pageTitle" value="Hackathons" scope="request" />
			<c:set var="activePage" value="hackathons" scope="request" />

			<!DOCTYPE html>
			<html lang="en" data-page="hackathons">

			<head>
				<%@ include file="../components/Head.jsp" %>
			</head>

			<body data-page="hackathons">

				<%@ include file="../components/navbar.jsp" %>


					<div class="cv-shell">

						<%@ include file="../components/Sidebar.jsp" %>



							<main class="cv-content">

								<c:if test="${not empty success}">
									<div class="alert alert-success cv-msg" role="alert">
										<i class="bi bi-check-circle-fill" aria-hidden="true"></i> ${success}</div>
								</c:if>

								<c:if test="${not empty error}">
									<div class="alert alert-danger" role="alert">
										<i class="bi bi-exclamation-triangle-fill" aria-hidden="true"></i> ${error}</div>
								</c:if>

								<!-- PAGE HEADER -->
								<div class="cv-page-header">
									<div class="cv-page-header__left">
										<div class="cv-page-eyebrow">
											<i class="bi bi-collection" aria-hidden="true"></i> Explore
										</div>
										<h1 class="cv-page-title">All Hackathons</h1>
										<p class="cv-page-subtitle">Browse, filter and register for
											challenges.</p>
									</div>
								</div>

								<!-- FILTER BAR -->
								<div class="cv-card mb-3">
									<div class="cv-card__body">

										<div class="d-flex gap-2 flex-nowrap" style="overflow-x: auto">

											<div class="position-relative" style="min-width: 220px;">
												<i
													class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-2 text-muted" aria-hidden="true"></i>
												<input type="text" id="searchInput" class="cv-input ps-4"
													placeholder="Search hackathons..." aria-label="Search hackathons by title">
											</div>

											<select class="cv-select" id="filterStatus" aria-label="Filter by Status">
												<option value="">All Status</option>
												<option value="open">Open</option>
												<option value="ongoing">Ongoing</option>
												<option value="upcoming">Upcoming</option>
												<option value="close">Closed</option>
											</select> <select class="cv-select" id="filterType" aria-label="Filter by Event Type">
												<option value="">All Types</option>
												<option value="online">Online</option>
												<option value="offline">Offline</option>
												<option value="hybrid">Hybrid</option>
											</select> <select class="cv-select" id="filterPayment" aria-label="Filter by Payment">
												<option value="">Free & Paid</option>
												<option value="free">Free</option>
												<option value="paid">Paid</option>
											</select> <select class="cv-select" id="filterTeam" aria-label="Filter by Team Size">
												<option value="">Team Size</option>
												<option value="solo">Solo</option>
												<option value="duo">Duo</option>
												<option value="small">3-4</option>
												<option value="large">5+</option>
											</select>

											<div class="ms-auto text-muted font-mono small" aria-live="polite">
												<span id="visibleCount">0</span>/<span id="totalCount">0</span>
												<span class="sr-only"> hackathons showing</span>
											</div>

										</div>

									</div>
								</div>

								<!-- HACKATHON GRID -->
								<c:choose>
									<c:when test="${not empty hackathonList}">

										<div class="row g-3" id="hackGrid">

											<c:forEach var="hack" items="${hackathonList}">

												<div class="col-12 col-md-6 col-xl-4 hack-card-wrap"
													data-title="${hack.title}" data-status="${hack.status}"
													data-type="${hack.eventType}" data-payment="${hack.payment}"
													data-minteam="${hack.minTeamSize}"
													data-maxteam="${hack.maxTeamSize}">

													<div class="cv-card cv-card--lift h-100">

														<div class="cv-card__banner cv-card__banner--${hack.status}">
														</div>

														<div class="cv-card__body">

															<div class="d-flex gap-2 mb-2 flex-wrap">
																<span class="cv-badge cv-badge--${hack.status}"> <span
																		class="cv-badge__dot"></span>${hack.status}
																</span> <span
																	class="cv-badge cv-badge--${hack.payment == 'Free' ? 'free' : 'paid'}">
																	${hack.payment} </span>
															</div>

															<div style="font-weight: 700">${hack.title}</div>

															<div class="text-muted-cv font-mono small mt-1">
																<i class="bi bi-people"></i>
																${hack.minTeamSize}-${hack.maxTeamSize} members
															</div>

														</div>

														<div class="cv-card__footer">
															<a href="/hackathonDetail/${hack.hackathonId}"
																class="btn-cv btn-cv--primary btn-cv--sm"> View </a>

															<c:choose>
																<c:when
																	test="${fn:toLowerCase(hack.status) == 'open' || fn:toLowerCase(hack.status) == 'upcoming'}">
																	<a href="/hackathonDetail/${hack.hackathonId}"
																		class="btn-cv btn-cv--ghost btn-cv--sm">
																		Register </a>
																</c:when>
																<c:otherwise>
																	<span
																		class="cv-pill cv-pill--closed ms-auto">Closed</span>
																</c:otherwise>
															</c:choose>
														</div>

													</div>

												</div>

											</c:forEach>

										</div>

										<!-- NO RESULTS -->
										<div id="noResults" style="display: none; margin-top: 1rem">
											<div class="cv-card">
												<div class="cv-empty">
													<i class="bi bi-funnel"></i>
													<h3>No matches found</h3>
													<p>Try adjusting your filters.</p>
												</div>
											</div>
										</div>

									</c:when>

									<c:otherwise>
										<div class="cv-card">
											<div class="cv-empty">
												<i class="bi bi-calendar-x"></i>
												<h3>No hackathons available</h3>
												<p>Check back later.</p>
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