<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Submissions" scope="request" />
<c:set var="activePage" value="submissions" scope="request" />

<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="../components/Head.jsp"%>
</head>

<body>

	<%@ include file="../components/navbar.jsp"%>

	<div class="cv-shell">

		<%@ include file="../components/Sidebar.jsp"%>

		<main class="cv-content">

			<div class="row g-4">

				<!-- 🔥 FINAL SUBMISSION (FULL WIDTH TOP) -->
				<div class="col-12">

					<div class="cv-card">

						<div
							class="cv-card__header d-flex justify-content-between align-items-center">

							<h3>Final Submitted Project</h3>

							<a href="/leaderboard?hackathonId=${team.hackathon.hackathonId}"
								class="btn-cv btn-cv--primary btn-cv--sm"> 🏆 View
								Leaderboard </a>

						</div>

						<div class="cv-card__body">

							<c:choose>

								<c:when test="${not empty finalSubmission}">

									<div>
										<a href="${finalSubmission.githubLink}" target="_blank"
											class="text-decoration-underline fw-semibold"> <i
											class="bi bi-box-arrow-up-right"></i> View Final Project
										</a>
									</div>

									<div style="font-size: .8rem; color: gray;" class="mt-2">
										Submitted by: ${finalSubmission.user.firstName}
										${finalSubmission.user.lastName}</div>

								</c:when>

								<c:otherwise>
									<span class="cv-badge cv-badge--danger"> Not Submitted
										Yet </span>
								</c:otherwise>

							</c:choose>

						</div>

					</div>

				</div>

				<!-- 🔹 LEFT: MEMBER SUBMISSIONS -->
				<div class="col-lg-8">

					<div class="cv-section-title">Team Members Work</div>

					<c:forEach var="s" items="${submissions}">
						<div class="cv-card mb-2 p-3">

							<div style="font-weight: 600;">${s.user.firstName}
								${s.user.lastName}</div>

							<div style="font-size: .8rem; color: gray;">
								${s.user.email}</div>

							<div class="mt-2">
								<a href="${s.githubLink}" target="_blank"
									class="text-decoration-underline fw-semibold"> <i
									class="bi bi-github"></i> View GitHub Repository
								</a>
							</div>
							<c:if test="${not empty s.description}">
								<div class="mt-2" style="font-size: .9rem; color: #555;">
									${s.description}</div>
							</c:if>

							<div class="mt-2 text-end">

								<c:if
									test="${s.user.userId == sessionScope.user.userId 
						|| team.teamLeader.userId == sessionScope.user.userId}">

									<form
										action="${pageContext.request.contextPath}/team/deleteSubmission"
										method="post" style="display: inline">

										<input type="hidden" name="submissionId"
											value="${s.submissionId}" />

										<button class="btn btn-sm btn-danger"
											onclick="return confirm('Delete this submission?')">
											Delete</button>

									</form>

								</c:if>

							</div>

						</div>
					</c:forEach>

				</div>

				<!-- 🔹 RIGHT: UPLOAD + FINAL SUBMIT -->
				<div class="col-lg-4">

					<div class="cv-card mb-3">
						<div class="cv-card__header">
							<h3>Upload Your Work</h3>
						</div>

						<div class="cv-card__body">

							<form action="${pageContext.request.contextPath}/team/upload"
								method="post">

								<input type="hidden" name="teamId"
									value="${team.hackathonTeamId}" /> <input type="text"
									name="link" class="cv-input"
									placeholder="Enter GitHub / Project Link" required />

								<textarea name="description" class="cv-input mt-2"
									placeholder="Describe your work" required></textarea>

								<button class="btn-cv btn-cv--primary mt-2">Upload</button>

							</form>

						</div>
					</div>

					<c:if test="${team.teamLeader.userId == sessionScope.user.userId}">
						<div class="cv-card">

							<div class="cv-card__header">
								<h3>Final Submission</h3>
							</div>

							<div class="cv-card__body">

								<c:choose>

									<c:when test="${not empty finalSubmission}">
										<p style="color: green;">Already submitted ✅</p>
									</c:when>

									<c:otherwise>
										<form action="/team/finalSubmit" method="post">

											<input type="hidden" name="teamId"
												value="${team.hackathonTeamId}" /> <input type="text"
												name="finalLink" class="cv-input"
												placeholder="Final Project Link" required />
											<textarea name="description" class="cv-input mt-2"
												placeholder="Describe your work" required></textarea>

											<button class="btn-cv btn-cv--danger mt-2">Submit to
												Judges</button>

										</form>
									</c:otherwise>

								</c:choose>

							</div>

						</div>
					</c:if>

				</div>

			</div>

		</main>
	</div>

	<%@ include file="../components/Footer.jsp"%>
	<%@ include file="../components/Scripts.jsp"%>

</body>
</html>