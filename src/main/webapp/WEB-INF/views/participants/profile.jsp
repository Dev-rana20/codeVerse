<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- ── Page Metadata ── --%>
<c:set var="pageTitle" value="User Profile" scope="request" />
<c:set var="activePage" value="profile" scope="request" />
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

	<%-- ── Role-aware sidebar ── --%>
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
			<div class="alert alert-success alert-dismissible fade show"
				role="alert"
				style="max-width: 520px; margin: 0 auto 20px; border-radius: 12px; background: rgba(0, 255, 224, 0.1); border: 1px solid rgba(0, 255, 224, 0.2); color: #00ffe0; font-family: 'Space Mono', monospace; font-size: 0.8rem;">
				<i class="bi bi-check-circle-fill me-2"></i> ${success}
				<button type="button" class="btn-close btn-close-white"
					data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</c:if>

		<c:if test="${not empty error}">
			<div class="alert alert-danger alert-dismissible fade show"
				role="alert"
				style="max-width: 520px; margin: 0 auto 20px; border-radius: 12px; background: rgba(255, 82, 82, 0.1); border: 1px solid rgba(255, 82, 82, 0.2); color: #ff5252; font-family: 'Space Mono', monospace; font-size: 0.8rem;">
				<i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
				<button type="button" class="btn-close btn-close-white"
					data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</c:if>

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

				<!-- UserDetail Fields -->
				<div class="mb-3">
					<label for="qualification" class="form-label">Qualification</label>
					<input type="text" class="form-control" id="qualification"
						name="qualification" value="${userDetail.qualification}">
				</div>
				<div class="row">
					<div class="col-md-6 mb-3">
						<label for="city" class="form-label">City</label> <input
							type="text" class="form-control" id="city" name="city"
							value="${userDetail.city}">
					</div>
					<div class="col-md-6 mb-3">
						<label for="state" class="form-label">State</label> <input
							type="text" class="form-control" id="state" name="state"
							value="${userDetail.state}">
					</div>
				</div>
				<div class="mb-3">
					<label for="country" class="form-label">Country</label> <input
						type="text" class="form-control" id="country" name="country"
						value="${userDetail.country}">
				</div>
				<div class="mb-3">
					<label for="workExperience" class="form-label">Work
						Experience</label> <input type="text" class="form-control"
						id="workExperience" name="workExperience"
						value="${userDetail.workExperience}">
				</div>

				<div class="mb-3">
					<label for="bio" class="form-label">Bio (Professional
						Summary)</label>
					<textarea class="form-control" id="bio" name="bio" rows="4"
						maxlength="1000" placeholder="Tell us about yourself...">${userDetail.bio}</textarea>
				</div>

				<div class="mb-3">
					<label for="githubLink" class="form-label">GitHub Portfolio
						URL</label>
					<div class="input-group">
						<span class="input-group-text bg-dark border-secondary text-muted"><i
							class="bi bi-github"></i></span> <input type="text" class="form-control"
							id="githubLink" name="githubLink"
							value="${userDetail.githubLink}"
							placeholder="https://github.com/username">
					</div>
				</div>

				<div class="mb-3">
					<label for="skills" class="form-label">Technical Skills
						(Comma separated)</label> <input type="text" class="form-control"
						id="skills" name="skills" value="${userDetail.skills}"
						placeholder="e.g. Java, React, TensorFlow">
					<div class="mt-2 d-flex flex-wrap gap-1" id="skillTags">
						<%-- JS will populate tags here if needed, or just show them from the field --%>
					</div>
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

		<%-- PAST PARTICIPATION SECTION --%>
		<div class="profile-card mt-4" style="max-width: 650px;">
			<div class="cv-page-eyebrow mb-2">
				<i class="bi bi-award-fill"></i> Past Participation
			</div>
			<h2 style="font-size: 1.1rem; font-weight: 700; margin-bottom: 1rem;">Hackathon
				History</h2>

			<div class="cv-table-wrap">
				<c:choose>
					<c:when test="${not empty registrations}">
						<table class="cv-table">
							<thead>
								<tr>
									<th>Event</th>
									<th>Date</th>
									<th>Status</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="reg" items="${registrations}">
									<tr>
										<td style="font-weight: 600;">${reg.hackathon.title}</td>
										<td class="font-mono" style="font-size: 0.75rem;">${reg.registrationDate}</td>
										<td><span
											class="cv-badge cv-badge--${fn:toLowerCase(reg.hackathon.status)}">
												${reg.hackathon.status} </span></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:when>
					<c:otherwise>
						<div class="text-center py-4 text-muted-cv"
							style="font-size: 0.8rem;">
							<i class="bi bi-calendar-x d-block mb-2"
								style="font-size: 1.5rem;"></i> No hackathon history yet. Join
							an event!
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

	<%@ include file="../components/Footer.jsp"%>
	<%@ include file="../components/Scripts.jsp"%>
</body>

</html>