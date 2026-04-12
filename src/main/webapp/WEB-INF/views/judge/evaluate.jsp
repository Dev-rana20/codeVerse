<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Evaluate Team" scope="request" />
<c:set var="activePage" value="evaluate" scope="request" />
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="../components/Head.jsp" %>
</head>
<body>

	<%@ include file="../components/navbar.jsp" %>

	<div class="cv-shell">
		<%@ include file="../components/SidebarJudge.jsp" %>

		<main class="cv-content">

			<div class="cv-page-header">
				<div class="cv-page-header__left">
					<div class="cv-page-eyebrow"><i class="bi bi-clipboard2-check"></i> Judging</div>
					<h1 class="cv-page-title">Evaluate Team</h1>
					<p class="cv-page-subtitle">Score each criterion from 0 to 10.</p>
				</div>
				<div class="cv-page-header__actions">
					<a href="javascript:history.back()" class="btn-cv btn-cv--ghost">
						<i class="bi bi-arrow-left"></i> Back
					</a>
				</div>
			</div>

			<c:if test="${not empty successMsg}">
				<div class="cv-alert cv-alert--success">
					<i class="bi bi-check-circle-fill"></i> ${successMsg}
				</div>
			</c:if>
			<c:if test="${not empty errorMsg}">
				<div class="cv-alert cv-alert--error">
					<i class="bi bi-exclamation-triangle-fill"></i> ${errorMsg}
				</div>
			</c:if>

			<div class="cv-card">
			<div class="cv-card__header">
				<i class="bi bi-people-fill"></i>
				<div>
					<h3>${team.teamName}</h3>
					<div class="team-members-list mt-1">
						<c:forEach var="tm" items="${team.members}">
							<c:if test="${tm.status == 'ACCEPTED'}">
								<span class="cv-badge cv-badge--secondary" style="font-size: 0.75rem; background: var(--border-color); border: 1px solid var(--border-color);">
									<i class="bi bi-person"></i> ${tm.member.firstName} ${tm.member.lastName}
									<c:if test="${tm.roleTitle == 'LEADER'}"> <small>(Leader)</small></c:if>
								</span>
							</c:if>
						</c:forEach>
					</div>
				</div>
				<div class="cv-card__header-actions">
					<c:set var="isPastDeadline" value="${not empty team.hackathon.submissionDeadline and java.time.LocalDate.now().isAfter(team.hackathon.submissionDeadline)}" />
					<c:choose>
						<c:when test="${isPastDeadline}">
							<span class="cv-badge cv-badge--danger"><i class="bi bi-clock-history"></i> Deadline Passed</span>
						</c:when>
						<c:otherwise>
							<span class="cv-badge cv-badge--success"><i class="bi bi-clock"></i> Active</span>
						</c:otherwise>
					</c:choose>
					
					<c:choose>
						<c:when test="${not empty team.finalSubmissionLink}">
							<a href="${team.finalSubmissionLink}" target="_blank" class="btn-cv btn-cv--sm btn-cv--primary">
								<i class="bi bi-box-arrow-up-right"></i> View Final Submission
							</a>
						</c:when>
						<c:otherwise>
							<span class="cv-badge cv-badge--closed">No Final Submission</span>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<%-- ── Submissions Panel ── --%>
			<div class="cv-card__body" style="border-bottom: 1px solid var(--border-color); margin-bottom: 1.5rem; padding-bottom: 1.25rem;">
				<p class="cv-label" style="margin-bottom: 0.75rem;"><i class="bi bi-github"></i> Project Submissions</p>

				<%-- Final submission row --%>
				<c:choose>
					<c:when test="${not empty finalSubs}">
						<c:forEach var="fs" items="${finalSubs}">
							<div class="cv-alert" style="margin-bottom: 0.5rem; display:flex; align-items:flex-start; gap:0.75rem;">
								<span class="cv-badge" style="background:var(--primary);">FINAL</span>
								<div style="flex-grow: 1;">
									<div style="display:flex; flex-wrap:wrap; align-items:center; gap:0.75rem;">
										<a href="${fs.githubLink}" target="_blank" style="color:var(--primary);">
											<i class="bi bi-link-45deg"></i> ${fs.githubLink}
										</a>
										<c:if test="${not empty fs.fileUrl}">
											<a href="${fs.fileUrl}" target="_blank" class="btn-cv btn-cv--sm btn-cv--ghost" style="font-size:0.75rem; padding:0.15rem 0.5rem; border: 1px solid var(--border-color);">
												<i class="bi bi-file-earmark-arrow-down"></i> File
											</a>
										</c:if>
										<c:if test="${not empty fs.videoUrl}">
											<a href="${fs.videoUrl}" target="_blank" class="btn-cv btn-cv--sm btn-cv--ghost" style="font-size:0.75rem; padding:0.15rem 0.5rem; border: 1px solid var(--border-color);">
												<i class="bi bi-play-circle"></i> Video
											</a>
										</c:if>
									</div>
									<c:if test="${not empty fs.description}">
										<p style="margin:0.25rem 0 0; font-size:0.85rem; color:var(--text-muted);">${fs.description}</p>
									</c:if>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<p style="color:var(--text-muted); font-size:0.875rem;">No final submission yet.</p>
					</c:otherwise>
				</c:choose>

				<%-- Member submissions --%>
				<c:if test="${not empty memberSubs}">
					<p class="cv-label" style="margin: 1rem 0 0.5rem;"><i class="bi bi-person-lines-fill"></i> Member Work Uploads</p>
					<c:forEach var="ms" items="${memberSubs}">
						<div style="display:flex; align-items:flex-start; gap:0.75rem; margin-bottom:0.75rem; padding-bottom: 0.5rem; border-bottom: 1px dashed var(--border-color);">
							<span class="cv-badge" style="background:var(--secondary); flex-shrink:0;">
								${ms.user.firstName}
							</span>
							<div style="flex-grow: 1;">
								<div style="display:flex; flex-wrap:wrap; align-items:center; gap:0.75rem;">
									<a href="${ms.githubLink}" target="_blank" style="color:var(--primary); font-size:0.9rem;">
										<i class="bi bi-link-45deg"></i> ${ms.githubLink}
									</a>
									<c:if test="${not empty ms.fileUrl}">
										<a href="${ms.fileUrl}" target="_blank" class="btn-cv btn-cv--sm btn-cv--ghost" style="font-size:0.75rem; padding: 0.15rem 0.5rem; border: 1px solid var(--border-color);">
											<i class="bi bi-file-earmark-arrow-down"></i> File
										</a>
									</c:if>
									<c:if test="${not empty ms.videoUrl}">
										<a href="${ms.videoUrl}" target="_blank" class="btn-cv btn-cv--sm btn-cv--ghost" style="font-size:0.75rem; padding: 0.15rem 0.5rem; border: 1px solid var(--border-color);">
											<i class="bi bi-play-circle"></i> Video
										</a>
									</c:if>
								</div>
								<c:if test="${not empty ms.description}">
									<p style="margin:0.25rem 0 0; font-size:0.82rem; color:var(--text-muted);">${ms.description}</p>
								</c:if>
							</div>
						</div>
					</c:forEach>
				</c:if>
			</div>

			<div class="cv-card__body">
				<form action="/judge/submit-evaluation" method="post">
						
						<input type="hidden" name="teamId" value="${team.hackathonTeamId}" />

						<div class="cv-grid-2" style="margin-bottom:1.25rem;">

							<div class="cv-form-group">
								<label class="cv-label" for="innovation">Innovation (0–10)</label>
								<input type="number" id="innovation" name="innovation"
									min="0" max="10" class="cv-input" placeholder="0" required />
							</div>

							<div class="cv-form-group">
								<label class="cv-label" for="technical">Technical (0–10)</label>
								<input type="number" id="technical" name="technical"
									min="0" max="10" class="cv-input" placeholder="0" required />
							</div>

							<div class="cv-form-group">
								<label class="cv-label" for="uiUx">UI / UX (0–10)</label>
								<input type="number" id="uiUx" name="uiUx"
									min="0" max="10" class="cv-input" placeholder="0" required />
							</div>

							<div class="cv-form-group">
								<label class="cv-label" for="functionality">Functionality (0–10)</label>
								<input type="number" id="functionality" name="functionality"
									min="0" max="10" class="cv-input" placeholder="0" required />
							</div>

							<div class="cv-form-group">
								<label class="cv-label" for="presentation">Presentation (0–10)</label>
								<input type="number" id="presentation" name="presentation"
									min="0" max="10" class="cv-input" placeholder="0" required />
							</div>

							<div class="cv-form-group">
								<label class="cv-label" for="impact">Impact (0–10)</label>
								<input type="number" id="impact" name="impact"
									min="0" max="10" class="cv-input" placeholder="0" required />
							</div>

						</div>

						<div class="cv-form-group">
							<label class="cv-label" for="remarks">Remarks</label>
							<textarea id="remarks" name="remarks" class="cv-textarea"
								placeholder="Optional feedback for the team…"></textarea>
						</div>

						<div class="cv-card__footer" style="margin-top:0.5rem;">
							<button type="submit" class="btn-cv btn-cv--primary">
								<i class="bi bi-check2-circle"></i> Submit Evaluation
							</button>
							<a href="javascript:history.back()" class="btn-cv btn-cv--ghost">Cancel</a>
						</div>

					</form>
				</div>
			</div>

		</main>
	</div>

	<%@ include file="../components/Footer.jsp" %>
	<%@ include file="../components/Scripts.jsp" %>

</body>
</html>
