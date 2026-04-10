<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- ── Page Identity ── --%>
<c:set var="pageTitle" value="New Category" scope="request" />
<c:set var="activePage" value="newCategory" scope="request" />

<!DOCTYPE html>
<html lang="en" data-page="newCategory">

<head>
<%@ include file="/WEB-INF/views/components/Head.jsp"%>
</head>

<body data-page="newCategory">

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
						<i class="bi bi-tags"></i> Categories
					</div>
					<h1 class="cv-page-title">New Category</h1>
				</div>

				<a href="listCategory" class="btn-cv btn-cv-ghost"> <i
					class="bi bi-list-ul"></i> View All
				</a>
			</div>

			<!-- Form Card -->
			

					<div class="cv-card" style="max-width: 520px;">

						<div class="cv-card__header">
							<i class="bi bi-plus-circle"></i>
							<h3>Add Category</h3>
						</div>

						<div class="cv-card__body">
							<form action="saveCategory" method="post">
								

								<div class="cv-form-group">
									<label class="cv-label"> Category Name <span
										class="req">*</span>
									</label> <input type="text" name="categoryName" class="cv-input"
										placeholder="Enter category name" required>
								</div>

								<div class="cv-actions">
									<button type="submit" class="btn-cv btn-cv-primary">
										<i class="bi bi-save"></i> Save Category
									</button>

									<a href="listCategory" class="btn-cv btn-cv-ghost"> Cancel
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