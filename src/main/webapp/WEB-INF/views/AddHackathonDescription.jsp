<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- ── Step 1: Page Identity ── --%>
<c:set var="pageTitle" value="Add Description" scope="request" />
<c:set var="activePage" value="hackathonDesc" scope="request" />

<!DOCTYPE html>
<html lang="en" data-page="hackathonDesc">

<head>
<%@ include file="/WEB-INF/views/components/Head.jsp"%>
</head>

<body data-page="hackathonDesc">

	<%-- ── Navbar ── --%>
	<%@ include file="/WEB-INF/views/components/navbar.jsp"%>

	<div class="cv-shell">

		<%-- ── Sidebar ── --%>
		<%@ include file="/WEB-INF/views/components/SidebarAdmin.jsp"%>

		<main class="cv-content">

			<!-- Page Header -->
			<div class="cv-page-header mb-4">
				<div>
					<div class="cv-page-eyebrow">
						<i class="bi bi-file-richtext"></i> Hackathons
					</div>
					<h1 class="cv-page-title">Add Hackathon Description</h1>
				</div>

				<a href="listHackathon" class="btn-cv btn-cv-ghost"> <i
					class="bi bi-list-ul"></i> View All
				</a>
			</div>

			<!-- Form Card -->
			<div class="row">
				<div class="col-md-8 mx-auto">
					<div class="cv-card">

						<div class="cv-card__header">
							<i class="bi bi-pencil-square"></i>
							<h3>Description Details</h3>
						</div>

						<div class="cv-card__body">
							<form action="saveHackathonDescription" method="post"
								enctype="multipart/form-data">
							

								<div class="cv-form-group">
									<label class="cv-label">Select Hackathon <span
										class="req">*</span></label> <select name="hackathonId"
										class="cv-select" required>
										<option value="">-- Choose a Hackathon --</option>
										<c:forEach items="${hackathons}" var="h">
											<option value="${h.hackathonId}">${h.title}</option>
										</c:forEach>
									</select>
								</div>

								<div class="cv-form-group">
									<label class="cv-label">Hackathon Details</label>
									<textarea name="hackathonDetailsText" class="cv-textarea"
										rows="8" placeholder="Enter full hackathon description..."></textarea>
								</div>

								<div class="cv-form-group">
									<label class="cv-label">Hackathon Pamphlet / Poster</label> <input
										type="file" name="hackathonDetails" class="cv-input"
										accept="image/*,.pdf"> <span class="cv-field-hint">
										Accepted: images and PDF. Max 5MB. </span>
								</div>

								<div class="cv-actions mt-3">
									<button type="submit" class="btn-cv btn-cv-primary">
										<i class="bi bi-save"></i> Save Description
									</button>
									<a href="listHackathon" class="btn-cv btn-cv-ghost"> Cancel
									</a>
								</div>

							</form>
						</div>

					</div>
				</div>
			</div>

		</main>
	</div>

	<%-- ── Footer + Scripts ── --%>
	<%@ include file="/WEB-INF/views/components/Footer.jsp"%>
	<%@ include file="/WEB-INF/views/components/Scripts.jsp"%>

</body>
</html>