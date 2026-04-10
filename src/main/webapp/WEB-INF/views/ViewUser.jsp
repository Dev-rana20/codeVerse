<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%-- Page Identity --%>
<c:set var="pageTitle" value="User Details" scope="request" />
<c:set var="activePage" value="users" scope="request" />

<!DOCTYPE html>
<html lang="en" data-page="users">

<head>
<%@ include file="/WEB-INF/views/components/Head.jsp"%>
</head>

<body data-page="users">

	<%@ include file="/WEB-INF/views/components/navbar.jsp"%>

	<div class="cv-shell">

		<%@ include file="/WEB-INF/views/components/SidebarAdmin.jsp"%>

		<main class="cv-content">

			<!-- Page Header -->
			<div class="cv-page-header mb-4">
				<div>
					<div class="cv-page-eyebrow">
						<i class="bi bi-person"></i> Users
					</div>
					<h1 class="cv-page-title">User Details</h1>
				</div>

				<div>
					<a href="listUser" class="btn-cv btn-cv-ghost"> <i
						class="bi bi-arrow-left"></i> Back
					</a> <a href="editUser?userId=${user.userId}"
						class="btn-cv btn-cv-warning"> <i class="bi bi-pencil"></i>
						Edit
					</a>
				</div>
			</div>

			<!-- User Card -->
			<div class="cv-card">

				<div class="cv-card__body">

					<div class="row g-4">

						<!-- Profile -->
						<div class="col-md-3 text-center">

							<c:choose>
								<c:when test="${not empty user.profilePicURL}">
									<img src="${user.profilePicURL}" class="cv-avatar-lg">
								</c:when>
								<c:otherwise>
									<img
										src="https://api.dicebear.com/7.x/initials/svg?seed=${user.firstName}"
										class="cv-avatar-lg">
								</c:otherwise>
							</c:choose>

							<div class="mt-3">
								<span class="cv-badge"> ${user.role} </span>
							</div>

						</div>

						<!-- Details -->
						<div class="col-md-9">

							<div class="row g-3">

								<div class="col-md-6">
									<b>User ID:</b> ${user.userId}
								</div>

								<div class="col-md-6">
									<b>Full Name:</b> ${user.firstName} ${user.lastName}
								</div>

								<div class="col-md-6">
									<b>Email:</b> ${user.email}
								</div>

								<div class="col-md-6">
									<b>Gender:</b> ${user.gender}
								</div>

								<div class="col-md-6">
									<b>Birth Year:</b> ${user.birthYear}
								</div>

								<div class="col-md-6">
									<b>Contact:</b> ${user.contactNum}
								</div>

								<div class="col-md-6">
									<b>Created At:</b> ${user.createdAt}
								</div>

								<div class="col-md-6">
									<b>Status:</b>
									<c:choose>
										<c:when test="${user.active}">
											<span class="cv-badge" style="background: var(--success)">
												Active </span>
										</c:when>
										<c:otherwise>
											<span class="cv-badge" style="background: var(--danger)">
												Inactive </span>
										</c:otherwise>
									</c:choose>
								</div>

								<div class="col-md-6">
									<b>Country:</b> ${userDetail.country}
								</div>

								<div class="col-md-6">
									<b>State:</b> ${userDetail.state}
								</div>

								<div class="col-md-6">
									<b>City:</b> ${userDetail.city}
								</div>

							</div>

						</div>

					</div>

				</div>

			</div>

		</main>
	</div>

	<%@ include file="/WEB-INF/views/components/Footer.jsp"%>
	<%@ include file="/WEB-INF/views/components/Scripts.jsp"%>

</body>
</html>