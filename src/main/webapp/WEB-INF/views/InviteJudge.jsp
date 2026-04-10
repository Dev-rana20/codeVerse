<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Invite Judge" scope="request" />
<c:set var="activePage" value="inviteJudge" scope="request" />

<!DOCTYPE html>
<html lang="en" data-page="judges">

<head>
<%@ include file="/WEB-INF/views/components/Head.jsp"%>
</head>

<body data-page="judges">

	<%@ include file="/WEB-INF/views/components/navbar.jsp"%>

	<div class="cv-shell">

		<%@ include file="/WEB-INF/views/components/SidebarAdmin.jsp"%>

		<main class="cv-content">

			<!-- Page Header -->
			<div class="cv-page-header mb-4">
				<div>
					<div class="cv-page-eyebrow">
						<i class="bi bi-person-plus"></i> Judge Management
					</div>
					<h1 class="cv-page-title">Invite a Judge</h1>
					<p class="cv-page-sub">Send an invitation email to a judge for
						a hackathon.</p>
				</div>
			</div>

			<!-- Alerts -->
			<c:if test="${not empty param.success}">
				<div class="cv-alert cv-alert-success">
					<i class="bi bi-check-circle-fill"></i> Invitation sent
					successfully.
				</div>
			</c:if>

			<c:if test="${not empty param.error}">
				<div class="cv-alert cv-alert-danger">
					<i class="bi bi-exclamation-triangle-fill"></i> ${param.error}
				</div>
			</c:if>

			<!-- Form Card -->
			<div class="cv-card" style="max-width: 520px;">

				<div class="cv-card__header">
					<i class="bi bi-envelope-at"></i>
					<h3>Judge Invitation</h3>
				</div>

				<div class="cv-card__body">

					<form action="/admin/invite-judge" method="post">
					

						<!-- Email -->
						<div class="cv-form-group">
							<label class="cv-label"> Judge Email <span class="req">*</span>
							</label>

							<div class="cv-input-wrap">
								<i class="icon bi bi-envelope"></i> <input type="email"
									name="email" class="cv-input" placeholder="judge@example.com"
									required />
							</div>

							<p class="cv-field-hint">An invitation link will be sent to
								this email.</p>
						</div>

						<!-- Hackathon 
						<div class="cv-form-group">
							<label class="cv-label"> Hackathon <span class="req">*</span>
							</label> <select name="hackathonId" class="cv-select" required>

								<option value="">— Select Hackathon —</option>

								<c:forEach var="h" items="${hackathonList}">
									<option value="${h.hackathonId}">${h.title}</option>
								</c:forEach>

							</select>
						</div>-->

						<!-- Actions -->
						<div class="cv-actions mt-3">

							<button type="submit" class="btn-cv btn-cv-primary">
								<i class="bi bi-send"></i> Send Invitation
							</button>


						</div>

					</form>

				</div>
			</div>

		</main>
	</div>

	<%@ include file="/WEB-INF/views/components/Footer.jsp"%>
	<%@ include file="/WEB-INF/views/components/Scripts.jsp"%>

</body>
</html>