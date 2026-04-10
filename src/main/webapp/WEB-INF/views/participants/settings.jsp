<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Account Settings" scope="request" />
<c:set var="activePage" value="settings" scope="request" />
<c:set var="pageSubtitle"
	value="Manage your account preferences and security" scope="request" />

<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="../components/Head.jsp"%>
<style>
.settings-card {
	max-width: 520px;
	margin: auto;
	background: linear-gradient(145deg, #0f1420, #0b0f18);
	border: 1px solid rgba(255, 255, 255, 0.06);
	border-radius: 18px;
	padding: 28px;
	box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
	backdrop-filter: blur(12px);
	transition: all 0.25s ease;
}

.settings-card:hover {
	border-color: rgba(0, 255, 224, 0.2);
	box-shadow: 0 0 30px rgba(0, 255, 224, 0.08);
}

.form-label {
	font-size: 0.7rem;
	color: #6b7280;
	font-family: 'Space Mono', monospace;
	text-transform: uppercase;
	letter-spacing: 0.08em;
	margin-bottom: 5px;
}

.form-control {
	background: #090c12;
	border: 1px solid rgba(255, 255, 255, 0.08);
	border-radius: 12px;
	color: #e8eaf6;
	padding: 10px 12px;
	font-size: 0.85rem;
	font-family: 'Space Mono', monospace;
	transition: all 0.2s ease;
}

.form-control:focus {
	background: #090c12;
	color: #fff;
	border-color: #00ffe0;
	box-shadow: 0 0 0 2px rgba(0, 255, 224, 0.15);
}

.btn-primary {
	width: 100%;
	background: linear-gradient(135deg, #00ffe0, #7b5cff);
	border: none;
	border-radius: 12px;
	padding: 11px;
	font-size: 0.8rem;
	font-weight: 700;
	font-family: 'Space Mono', monospace;
	letter-spacing: 0.06em;
	color: #000;
	transition: all 0.25s ease;
}

.btn-primary:hover {
	opacity: 0.9;
	transform: translateY(-2px);
	box-shadow: 0 0 20px rgba(0, 255, 224, 0.3);
}

.section-title {
	font-size: 1rem;
	color: #00ffe0;
	font-family: 'Space Mono', monospace;
	font-weight: 700;
	margin-bottom: 20px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.section-title i {
	font-size: 1.2rem;
}

.alert-custom {
	max-width: 520px;
	margin: 0 auto 20px;
	border-radius: 12px;
	font-family: 'Space Mono', monospace;
	font-size: 0.8rem;
}
</style>
</head>

<body>
	<%@ include file="../components/navbar.jsp"%>

	<%-- ── Role-aware sidebar: pick the correct one at runtime ── --%>
	<c:choose>
		<c:when test="${sessionScope.user.role == 'ADMIN'}">
			<jsp:include page="../components/SidebarAdmin.jsp" />
		</c:when>
		<c:when test="${sessionScope.user.role == 'JUDGE'}">
			<jsp:include page="../components/SidebarJudge.jsp" />
		</c:when>
		<c:otherwise>
			<jsp:include page="../components/Sidebar.jsp" />
		</c:otherwise>
	</c:choose>

	<div class="container py-5">
		<c:if test="${not empty success}">
			<div
				class="alert alert-success alert-dismissible fade show alert-custom"
				role="alert"
				style="background: rgba(0, 255, 224, 0.1); border: 1px solid rgba(0, 255, 224, 0.2); color: #00ffe0;">
				<i class="bi bi-check-circle-fill me-2"></i> ${success}
				<button type="button" class="btn-close btn-close-white"
					data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</c:if>

		<c:if test="${not empty error}">
			<div
				class="alert alert-danger alert-dismissible fade show alert-custom"
				role="alert"
				style="background: rgba(255, 82, 82, 0.1); border: 1px solid rgba(255, 82, 82, 0.2); color: #ff5252;">
				<i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
				<button type="button" class="btn-close btn-close-white"
					data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</c:if>

		<div class="settings-card">
			<div class="section-title">
				<i class="bi bi-shield-lock"></i> Password Security
			</div>

			<form action="participant/updatePassword" method="post">
				<div class="mb-3">
					<label for="currentPassword" class="form-label">Current
						Password</label> <input type="password" class="form-control"
						id="currentPassword" name="currentPassword" required>
				</div>
				<div class="mb-4">
					<div class="mb-3">
						<label for="newPassword" class="form-label">New Password</label> <input
							type="password" class="form-control" id="newPassword"
							name="newPassword" required>
					</div>
					<div class="mb-3">
						<label for="confirmPassword" class="form-label">Confirm
							New Password</label> <input type="password" class="form-control"
							id="confirmPassword" name="confirmPassword" required>
					</div>
				</div>

				<button type="submit" class="btn btn-primary">Update
					Password</button>
			</form>
		</div>
	</div>

	<%@ include file="../components/Footer.jsp"%>
	<%@ include file="../components/Scripts.jsp"%>
</body>

</html>
