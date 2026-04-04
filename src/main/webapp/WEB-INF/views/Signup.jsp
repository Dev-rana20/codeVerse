<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CodeVerse — Sign Up</title>

<!-- Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet"/>

<!-- Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>

<!-- External CSS -->
<link rel="stylesheet" href="<c:url value='/assets/css/codeverse-form.css'/>">

<jsp:include page="AdminCSS.jsp"></jsp:include>

</head>

<body class="cv-scope">

<div class="auth-left">
	<div class="auth-card dark-form">

		<a href="/" class="auth-brand">CODE<span>VERSE</span></a>

		<h2>Create Account</h2>
		<p style="color:#aaa; font-size:13px;">Join CodeVerse and start competing</p>

		<form action="register" method="post" enctype="multipart/form-data">

			<div class="grid-2">
				<input type="text" name="firstName" class="cv-input" placeholder="First Name" required>
				<input type="text" name="lastName" class="cv-input" placeholder="Last Name" required>
			</div>

			<input type="email" name="email" class="cv-input" placeholder="Email" required>
			<input type="password" name="password" class="cv-input" placeholder="Password" required>

			<div class="gender-group">
				<label><input type="radio" name="gender" value="MALE" required> Male</label>
				<label><input type="radio" name="gender" value="FEMALE"> Female</label>
				<label><input type="radio" name="gender" value="OTHER"> Other</label>
			</div>

			<div class="grid-2">
				<input type="number" name="birthYear" class="cv-input" placeholder="Birth Year" required>
				<input type="text" name="contactNum" class="cv-input" placeholder="Contact Number" required>
			</div>

			<input type="text" name="qualification" class="cv-input" placeholder="Qualification">

			<select name="userTypeId" class="cv-select">
				<option value="-1" disabled selected>Select User Type</option>
				<c:forEach items="${allUserType}" var="ut">
					<option value="${ut.userTypeId}">${ut.userType}</option>
				</c:forEach>
			</select>

			<div class="grid-2">
				<input type="text" name="city" class="cv-input" placeholder="City">
				<input type="text" name="state" class="cv-input" placeholder="State">
			</div>

			<input type="text" name="country" class="cv-input" value="India">

			<label style="font-size:13px;">Profile Picture</label>
			<input type="file" name="profilePic" class="cv-input">

			<button type="submit" class="btn-submit">
				<i class="bi bi-person-plus"></i> Create Account
			</button>

		</form>

		<div class="auth-switch">
			Already have an account? <a href="login">Login</a>
		</div>

	</div>
</div>

<div class="auth-right">
	<p class="auth-tagline">Build.<br>Compete.<br><span>Win.</span></p>

	<div class="auth-feature">
		<i class="bi bi-lightning-charge-fill"></i>
		<div>Real Hackathons</div>
	</div>

	<div class="auth-feature">
		<i class="bi bi-people-fill"></i>
		<div>Team Up</div>
	</div>

	<div class="auth-feature">
		<i class="bi bi-trophy-fill"></i>
		<div>Win Prizes</div>
	</div>
</div>

</body>
</html>