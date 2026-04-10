<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- ── Page Identity ── --%>
<c:set var="pageTitle" value="List Category" scope="request" />
<c:set var="activePage" value="listCategory" scope="request" />

<!DOCTYPE html>
<html lang="en" data-page="listCategory">

<head>
<%@ include file="/WEB-INF/views/components/Head.jsp"%>

<style>
.cv-badge.ACTIVE {
	background: var(--success);
}

.cv-badge.INACTIVE {
	background: var(--danger);
}
</style>

</head>

<body data-page="listCategory">

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
						<i class="bi bi-tags"></i> Category
					</div>
					<h1 class="cv-page-title">All Categories</h1>
				</div>

				<a href="newCategory" class="btn-cv btn-cv-primary"> <i
					class="bi bi-plus-circle"></i> New Category
				</a>
			</div>

			<!-- Table Card -->
			<div class="cv-card">

				<div class="cv-card__header">
					<i class="bi bi-list-ul"></i>
					<h3>Category List</h3>
				</div>

				<div class="cv-card__body">

					<div class="cv-table-wrap">
						<table class="cv-table">

							<thead>
								<tr>
									<th>#</th>
									<th>Category Name</th>
									<th>Status</th>
									<th>Action</th>
								</tr>
							</thead>

							<tbody>

								<c:if test="${empty categoryList}">
									<tr>
										<td colspan="4" class="text-center text-muted">No
											categories found</td>
									</tr>
								</c:if>

								<c:forEach var="cat" items="${categoryList}" varStatus="i">
									<tr>
										<td>${i.index + 1}</td>

										<td>${cat.categoryName}</td>

										<td><c:choose>
												<c:when test="${cat.active}">
													<span class="cv-badge ACTIVE">Active</span>
												</c:when>
												<c:otherwise>
													<span class="cv-badge INACTIVE">Inactive</span>
												</c:otherwise>
											</c:choose></td>

										<td><a href="editCategory?id=${cat.categoryId}"
											class="btn-cv btn-cv-warning btn-sm"> <i
												class="bi bi-pencil"></i>
										</a> <a href="deleteCategory?id=${cat.categoryId}"
											class="btn-cv btn-cv-danger btn-sm"
											onclick="return confirm('Delete this category?')"> <i
												class="bi bi-trash"></i>
										</a></td>
									</tr>
								</c:forEach>

							</tbody>

						</table>
					</div>

				</div>

			</div>

		</main>
	</div>

	<%-- Footer + Scripts --%>
	<%@ include file="/WEB-INF/views/components/Footer.jsp"%>
	<%@ include file="/WEB-INF/views/components/Scripts.jsp"%>

</body>
</html>