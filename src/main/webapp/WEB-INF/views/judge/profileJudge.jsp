<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- ── Page Metadata ── --%>
<c:set var="pageTitle" value="User Profile" scope="request" />
<c:set var="activePage" value="dashboard" scope="request" />
<c:set var="pageSubtitle" value="View and edit your profile information"
	scope="request" />

<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="../components/Head.jsp"%>
<style>
/* ─── PROFILE CARD ───────────────────────── */
.profile-card {
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

.profile-card:hover {
	border-color: rgba(0, 255, 224, 0.2);
	box-shadow: 0 0 30px rgba(0, 255, 224, 0.08);
}

/* ─── PROFILE IMAGE ───────────────────────── */
.profile-pic {
	width: 110px;
	height: 110px;
	border-radius: 50%;
	object-fit: cover;
	border: 2px solid #00ffe0;
	box-shadow: 0 0 20px rgba(0, 255, 224, 0.2);
}

/* ─── LABEL ───────────────────────── */
.form-label {
	font-size: 0.7rem;
	color: #6b7280;
	font-family: 'Space Mono', monospace;
	text-transform: uppercase;
	letter-spacing: 0.08em;
	margin-bottom: 5px;
}

/* ─── INPUT & SELECT ───────────────────────── */
.form-control, .form-select {
	background: #090c12;
	border: 1px solid rgba(255, 255, 255, 0.08);
	border-radius: 12px;
	color: #e8eaf6;
	padding: 10px 12px;
	font-size: 0.85rem;
	font-family: 'Space Mono', monospace;
	transition: all 0.2s ease;
}

/* focus glow */
.form-control:focus, .form-select:focus {
	background: #090c12;
	color: #fff;
	border-color: #00ffe0;
	box-shadow: 0 0 0 2px rgba(0, 255, 224, 0.15);
}

/* readonly (email) */
.form-control[readonly] {
	opacity: 0.6;
	cursor: not-allowed;
}

/* ─── FILE INPUT ───────────────────────── */
input[type="file"].form-control {
	border-style: dashed;
	color: #6b7280;
	cursor: pointer;
}

input[type="file"].form-control:hover {
	border-color: #00ffe0;
}

/* ─── BUTTON ───────────────────────── */
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

/* ─── SPACING FIX ───────────────────────── */
.mb-3 {
	margin-bottom: 14px !important;
}
</style>
</head>

<body>
	<%@ include file="../components/navbar.jsp"%>

	<c:set var="activePage" value="profile" scope="request" />
	<%@ include file="../components/SidebarJudge.jsp"%>
	<div class="container py-5">
		<div class="profile-card">
			<div class="text-center mb-4">
				<c:choose>
					<c:when test="${not empty user.profilePicURL}">
						<img src="${user.profilePicURL}" alt="Profile Picture"
							class="profile-pic">
					</c:when>
					<c:otherwise>
						<img src="assets/default-profile.png" alt="Profile Picture"
							class="profile-pic">
					</c:otherwise>
				</c:choose>
			</div>

			<form action="updateProfile" method="post"
				enctype="multipart/form-data">
				<div class="mb-3">
					<label for="firstName" class="form-label">First Name</label> <input
						type="text" class="form-control" id="firstName" name="firstName"
						value="${user.firstName}" required>
				</div>
				<div class="mb-3">
					<label for="lastName" class="form-label">Last Name</label> <input
						type="text" class="form-control" id="lastName" name="lastName"
						value="${user.lastName}" required>
				</div>
				<div class="mb-3">
					<label for="email" class="form-label">Email</label> <input
						type="email" class="form-control" id="email" name="email"
						value="${user.email}" readonly>
				</div>
				<div class="mb-3">
					<label for="gender" class="form-label">Gender</label> <select
						class="form-select" name="gender" id="gender">
						<option value="Male" ${user.gender=='Male' ? 'selected' : '' }>Male</option>
						<option value="Female" ${user.gender=='Female' ? 'selected' : '' }>Female
						</option>
						<option value="Other" ${user.gender=='Other' ? 'selected' : '' }>Other
						</option>
					</select>
				</div>
				<div class="mb-3">
					<label for="birthYear" class="form-label">Birth Year</label> <input
						type="number" class="form-control" id="birthYear" name="birthYear"
						value="${user.birthYear}">
				</div>
				<div class="mb-3">
					<label for="contactNum" class="form-label">Contact Number</label> <input
						type="text" class="form-control" id="contactNum" name="contactNum"
						value="${user.contactNum}">
				</div>
				<div class="mb-3">
					<label for="profilePic" class="form-label">Profile Picture</label>
					<input type="file" class="form-control" id="profilePic"
						name="profilePic">
				</div>

				<button type="submit" class="btn btn-primary">Update
					Profile</button>
			</form>
		</div>
	</div>

	<%@ include file="../components/Footer.jsp"%>
	<%@ include file="../components/Scripts.jsp"%>
</body>

</html>