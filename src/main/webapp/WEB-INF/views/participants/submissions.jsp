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
		
			<c:if test="${not empty error}">
				<div class="alert alert-danger"
					style="padding: 10px; background: #f8d7da; color: #721c24; margin-bottom: 20px; border-radius: 5px;">
					${error}</div>
			</c:if>

			<c:if test="${not empty success}">
				<div class="alert alert-success"
					style="padding: 10px; background: #d4edda; color: #155724; margin-bottom: 20px; border-radius: 5px;">
					${success}</div>
			</c:if>

			<div class="row g-4">

				<!-- 🔥 1. COMPACT FINAL STATUS (TOP) -->
				<div class="col-12">
					<div class="cv-card mb-0">
						<div class="cv-card__body d-flex flex-wrap justify-content-between align-items-center py-2 px-3">
							
							<div class="d-flex align-items-center gap-3">
								<h3 class="mb-0 fs-5">Final Project Status:</h3>
								<c:choose>
									<c:when test="${not empty finalSubmission}">
										<div class="d-flex gap-2">
											<c:if test="${not empty finalSubmission.githubLink}">
												<a href="${finalSubmission.githubLink}" target="_blank" class="btn-cv btn-cv--sm btn-cv--outline-primary"> 
													<i class="bi bi-github"></i> GitHub
												</a>
											</c:if>
											<c:if test="${not empty finalSubmission.fileUrl}">
												<a href="${finalSubmission.fileUrl}" target="_blank" class="btn-cv btn-cv--sm btn-cv--outline-success"> 
													<i class="bi bi-file-earmark-zip"></i> Files
												</a>
											</c:if>
											<c:if test="${not empty finalSubmission.videoUrl}">
												<a href="${finalSubmission.videoUrl}" target="_blank" class="btn-cv btn-cv--sm btn-cv--outline-warning"> 
													<i class="bi bi-play-circle"></i> Video
												</a>
											</c:if>
										</div>
									</c:when>
									<c:otherwise>
										<span class="cv-badge cv-badge--danger">Not Submitted</span>
									</c:otherwise>
								</c:choose>
							</div>

							<div class="d-flex align-items-center gap-3">
								<a href="/leaderboard?hackathonId=${team.hackathon.hackathonId}" class="btn-cv btn-cv--primary btn-cv--sm"> 
									🏆 Leaderboard 
								</a>
							</div>

						</div>
					</div>
				</div>

				<!-- ⚡ 2. QUICK ACTIONS (SIDE-BY-SIDE) -->
				<div class="col-lg-6">
					<div class="cv-card h-100">
						<div class="cv-card__header py-2">
							<h3 class="fs-6 mb-0">Upload Your Work</h3>
						</div>
						<div class="cv-card__body p-3">
							<c:choose>
								<c:when test="${not empty finalSubmission}">
									<div class="text-center py-4">
										<i class="bi bi-lock-fill display-6 text-muted mb-2"></i>
										<p class="text-muted mb-0">Uploads are closed because the final project has been submitted.</p>
									</div>
								</c:when>
								<c:otherwise>
									<form action="${pageContext.request.contextPath}/team/upload" method="post" enctype="multipart/form-data">
										<input type="hidden" name="teamId" value="${team.hackathonTeamId}" />
										
										<div class="row g-2">
											<div class="col-12">
												<input type="text" name="link" class="cv-input py-1 px-2 mb-1" style="font-size: 0.85rem;" placeholder="GitHub / Project Link" />
											</div>
											<div class="col-md-6">
												<label class="form-label small mb-0" style="font-size: 0.75rem;">Project File (10MB)</label>
												<input type="file" name="projectFile" class="cv-input py-1 px-2" style="font-size: 0.8rem;" accept=".zip,.pdf,.docx" />
											</div>
											<div class="col-md-6">
												<label class="form-label small mb-0" style="font-size: 0.75rem;">Demo Video (50MB)</label>
												<input type="file" name="projectVideo" class="cv-input py-1 px-2" style="font-size: 0.8rem;" accept="video/*" />
											</div>
											<div class="col-12">
												<textarea name="description" class="cv-input py-1 px-2 mt-1" style="font-size: 0.85rem; height: 60px;" placeholder="What did you work on?" required></textarea>
											</div>
										</div>
										<button class="btn-cv btn-cv--primary btn-cv--sm mt-2 w-100">Upload Work</button>
									</form>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>

				<div class="col-lg-6">
					<c:if test="${team.teamLeader.userId == sessionScope.user.userId}">
						<div class="cv-card h-100">
							<div class="cv-card__header py-2">
								<h3 class="fs-6 mb-0">Final Submission</h3>
							</div>
							<div class="cv-card__body p-3">
								<c:choose>
									<c:when test="${not empty finalSubmission}">
										<div class="text-center py-4">
											<div class="display-6 text-success mb-2"><i class="bi bi-patch-check-fill"></i></div>
											<p class="text-success fw-bold mb-0">Project Completed</p>
											<small class="text-muted">Final submission has been received by judges.</small>
										</div>
									</c:when>
									<c:otherwise>
										<form action="/team/finalSubmit" method="post" enctype="multipart/form-data">
											<input type="hidden" name="teamId" value="${team.hackathonTeamId}" />
											
											<div class="row g-2">
												<div class="col-12">
													<input type="text" name="finalLink" class="cv-input py-1 px-2 mb-1" style="font-size: 0.85rem;" placeholder="Final GitHub Link" />
												</div>
												<div class="col-md-6">
													<label class="form-label small mb-0" style="font-size: 0.75rem;">Final ZIP (10MB)</label>
													<input type="file" name="projectFile" class="cv-input py-1 px-2" style="font-size: 0.8rem;" accept=".zip" />
												</div>
												<div class="col-md-6">
													<label class="form-label small mb-0" style="font-size: 0.75rem;">Final Video (50MB)</label>
													<input type="file" name="projectVideo" class="cv-input py-1 px-2" style="font-size: 0.8rem;" accept="video/*" />
												</div>
												<div class="col-12">
													<textarea name="description" class="cv-input py-1 px-2 mt-1" style="font-size: 0.85rem; height: 60px;" placeholder="Final project summary..." required></textarea>
												</div>
											</div>
											<button class="btn-cv btn-cv--danger btn-cv--sm mt-2 w-100">Submit to Judges</button>
										</form>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</c:if>
					<c:if test="${team.teamLeader.userId != sessionScope.user.userId}">
						<div class="cv-card h-100 d-flex align-items-center justify-content-center text-center p-4">
							<div>
								<i class="bi bi-shield-lock display-4 text-muted mb-3 d-block"></i>
								<p class="text-muted mb-0">Only the Team Leader can perform the Final Submission.</p>
							</div>
						</div>
					</c:if>
				</div>

				<!-- 📜 3. TEAM MEMBERS WORK (FULL WIDTH BOTTOM) -->
				<div class="col-12">
					<div class="cv-section-title mt-2 mb-3">Submission History & Team Activity</div>
					
					<div class="row g-3">
						<c:forEach var="s" items="${submissions}">
							<div class="col-md-6 col-xl-4">
								<div class="cv-card mb-0 p-3 h-100 shadow-sm border-0" style="background: rgba(255,255,255,0.03);">
									<div class="d-flex justify-content-between align-items-start">
										<div>
											<div class="fw-bold fs-6">${s.user.firstName} ${s.user.lastName}</div>
											<div class="small text-muted mb-2">${s.user.email}</div>
										</div>
										<c:if test="${s.user.userId == sessionScope.user.userId || team.teamLeader.userId == sessionScope.user.userId}">
											<form action="${pageContext.request.contextPath}/team/deleteSubmission" method="post">
												<input type="hidden" name="submissionId" value="${s.submissionId}" />
												<button class="btn btn-link text-danger p-0" onclick="return confirm('Delete this submission?')">
													<i class="bi bi-trash"></i>
												</button>
											</form>
										</c:if>
									</div>

									<div class="d-flex gap-3 mt-1">
										<c:if test="${not empty s.githubLink}">
											<a href="${s.githubLink}" target="_blank" class="small color-primary text-decoration-none">
												<i class="bi bi-github"></i> Repos
											</a>
										</c:if>
										<c:if test="${not empty s.fileUrl}">
											<a href="${s.fileUrl}" target="_blank" class="small color-success text-decoration-none">
												<i class="bi bi-file-earmark-zip"></i> File
											</a>
										</c:if>
										<c:if test="${not empty s.videoUrl}">
											<a href="${s.videoUrl}" target="_blank" class="small color-warning text-decoration-none">
												<i class="bi bi-play-circle"></i> Video
											</a>
										</c:if>
									</div>

									<c:if test="${not empty s.description}">
										<div class="mt-2 p-2 rounded small" style="background: rgba(0,0,0,0.2); color: #ccc;">
											${s.description}
										</div>
									</c:if>
								</div>
							</div>
						</c:forEach>

						<c:if test="${empty submissions}">
							<div class="col-12 text-center py-5">
								<i class="bi bi-folder2-open display-1 text-muted mb-3 d-block"></i>
								<p class="text-muted">No activity recorded for this team yet.</p>
							</div>
						</c:if>
					</div>
				</div>

			</div>

		</main>
	</div>

	<%@ include file="../components/Footer.jsp"%>
	<%@ include file="../components/Scripts.jsp"%>

</body>
</html>