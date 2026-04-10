<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- ── Page Identity ── --%>
<c:set var="pageTitle" value="User Types" scope="request" />
<c:set var="activePage" value="userTypeList" scope="request" />

<!DOCTYPE html>
<html lang="en" data-page="userTypeList">

<head>
<%@ include file="/WEB-INF/views/components/Head.jsp"%>
</head>

<body data-page="userTypeList">

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
						<i class="bi bi-card-list"></i> User Management
					</div>
					<h1 class="cv-page-title">User Types</h1>
				</div>

				<a href="newUserType" class="btn-cv btn-cv-primary"> <i
					class="bi bi-plus-circle"></i> New Type
				</a>
			</div>

			<!-- Table Card -->
			<div class="cv-card">

				<div class="cv-card__header">
					<i class="bi bi-list-ul"></i>
					<h3>All User Types</h3>
				</div>

				<div class="cv-card__body">

					<div class="cv-table-wrap">
						<table class="cv-table text-center">

							<thead>
								<tr>
									<th>#</th>
									<th>User Type</th>
									<th>Action</th>
								</tr>
							</thead>

							<tbody>

								<c:forEach var="u" items="${userTypeList}" varStatus="i">
									<tr>

										<td>${i.count}</td>

										<td><span class="cv-badge"
											style="background: var(--primary)"> ${u.userType} </span></td>

										<td><a href="editUserType?id=${u.userTypeId}"
											class="btn-cv btn-cv-warning btn-sm"> <i
												class="bi bi-pencil"></i>
										</a> <a href="deleteUserType?id=${u.userTypeId}"
											class="btn-cv btn-cv-danger btn-sm"
											onclick="return confirm('Delete this user type?')"> <i
												class="bi bi-trash"></i>
										</a></td>

									</tr>
								</c:forEach>

								<c:if test="${empty userTypeList}">
									<tr>
										<td colspan="3" class="text-center text-muted">No User
											Types Found</td>
									</tr>
								</c:if>

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