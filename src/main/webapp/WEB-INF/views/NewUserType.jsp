<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- ── Page Identity ── --%>
<c:set var="pageTitle" value="New User Type" scope="request" />
<c:set var="activePage" value="addUserType" scope="request" />

<!DOCTYPE html>
<html lang="en" data-page="addUserType">

<head>
<%@ include file="/WEB-INF/views/components/Head.jsp"%>
</head>

<body data-page="addUserType">

	<%-- Navbar --%>
	<%@ include file="/WEB-INF/views/components/navbar.jsp"%>

	<div class="cv-shell">

		<%-- Sidebar --%>
		<%@ include file="/WEB-INF/views/components/SidebarAdmin.jsp"%>

		<main class="cv-content">

			<!-- Page Header -->
			<div class="cv-page-header mb-4">
				<div>
					<div class="cv-page-eyebrow">
						<i class="bi bi-person-badge"></i> User Types
					</div>
					<h1 class="cv-page-title">New User Type</h1>
				</div>

				<a href="listUserType" class="btn-cv btn-cv-ghost"> <i
					class="bi bi-list-ul"></i> View All
				</a>
			</div>

			<!-- Form Card -->
			

					<div class="cv-card" style="max-width: 520px;">

						<div class="cv-card__header">
							<i class="bi bi-plus-circle"></i>
							<h3>Add User Type</h3>
						</div>

						<div class="cv-card__body">
							<form action="saveUserType" method="post">
							

								<div class="cv-form-group">
									<label class="cv-label"> User Type Name <span
										class="req">*</span>
									</label> <input type="text" name="userType" class="cv-input"
										placeholder="e.g. Student, Professional" required>
								</div>

								<div class="cv-actions">
									<button type="submit" class="btn-cv btn-cv-primary">
										<i class="bi bi-save"></i> Save User Type
									</button>

									<a href="listUserType" class="btn-cv btn-cv-ghost"> Cancel
									</a>
								</div>

							</form>
						</div>

					</div>

			

		</main>
	</div>

	<%-- Footer + Scripts --%>
	<%@ include file="/WEB-INF/views/components/Footer.jsp"%>
	<%@ include file="/WEB-INF/views/components/Scripts.jsp"%>

</body>
</html>