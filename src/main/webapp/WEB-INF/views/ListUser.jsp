<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- ── Page Identity ── --%>
<c:set var="pageTitle" value="List User" scope="request" />
<c:set var="activePage" value="userList" scope="request" />

<!DOCTYPE html>
<html lang="en" data-page="userList">

<head>
<%@ include file="/WEB-INF/views/components/Head.jsp"%>

<style>
.cv-badge.ACTIVE { background: var(--success); }
.cv-badge.INACTIVE { background: var(--danger); }
.cv-badge.ROLE { background: var(--info); color: #000; }

.profile-pic {
	width: 36px;
	height: 36px;
	border-radius: 50%;
	object-fit: cover;
}
</style>

</head>

<body data-page="userList">

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
						<i class="bi bi-people"></i> Users
					</div>
					<h1 class="cv-page-title">All Users</h1>
				</div>

				<a href="signup" class="btn-cv btn-cv-primary">
					<i class="bi bi-person-plus"></i> New User
				</a>
			</div>

			<!-- Table Card -->
			<div class="cv-card">

				<div class="cv-card__header">
					<i class="bi bi-person-lines-fill"></i>
					<h3>User List</h3>
				</div>

				<div class="cv-card__body">

					<div class="cv-table-wrap">
						<table class="cv-table">

							<thead>
								<tr>
									<th>#</th>
									<th>Name</th>
									<th>Email</th>
									<th>Role</th>
									<th>Gender</th>
									<th>Birth Year</th>
									<th>Profile</th>
									<th>Status</th>
									<th>Action</th>
								</tr>
							</thead>

							<tbody>

								<c:forEach var="user" items="${userList}" varStatus="s">
									<tr>

										<td>${s.count}</td>

										<td>${user.firstName} ${user.lastName}</td>

										<td>${user.email}</td>

										<td>
											<span class="cv-badge ROLE">
												${user.role}
											</span>
										</td>

										<td>${user.gender}</td>

										<td>${user.birthYear}</td>

										<td class="text-center">
											<c:choose>
												<c:when test="${not empty user.profilePicURL}">
													<img src="${user.profilePicURL}" class="profile-pic" />
												</c:when>
												<c:otherwise>
													<img src="https://api.dicebear.com/7.x/initials/svg?seed=${user.firstName}"
														class="profile-pic" />
												</c:otherwise>
											</c:choose>
										</td>

										<td>
											<c:choose>
												<c:when test="${user.active}">
													<span class="cv-badge ACTIVE">Active</span>
												</c:when>
												<c:otherwise>
													<span class="cv-badge INACTIVE">Inactive</span>
												</c:otherwise>
											</c:choose>
										</td>

										<td>

											<a href="viewUser?userId=${user.userId}"
												class="btn-cv btn-cv-info btn-sm">
												<i class="bi bi-eye"></i>
											</a>

											<a href="editUser?userId=${user.userId}"
												class="btn-cv btn-cv-warning btn-sm">
												<i class="bi bi-pencil"></i>
											</a>

											<a href="deleteUser?userId=${user.userId}"
												class="btn-cv btn-cv-danger btn-sm"
												onclick="return confirm('Delete this user?')">
												<i class="bi bi-trash"></i>
											</a>

										</td>

									</tr>
								</c:forEach>

								<c:if test="${empty userList}">
									<tr>
										<td colspan="9" class="text-center text-muted">
											No users found
										</td>
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