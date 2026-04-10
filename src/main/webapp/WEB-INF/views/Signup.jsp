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

		<c:if test="${not empty error}">
			<div class="alert alert-danger" role="alert" style="color: #ff5252; background: rgba(255,82,82,0.1); padding: 10px; border-radius: 8px; margin-bottom: 20px; font-size: 13px; border: 1px solid rgba(255,82,82,0.2);">
				<i class="bi bi-exclamation-triangle-fill" aria-hidden="true"></i> ${error}
			</div>
		</c:if>

		<form action="register" method="post" enctype="multipart/form-data">

			<div class="grid-2">
				<div>
					<label for="firstName" class="sr-only">First Name</label>
					<input type="text" id="firstName" name="firstName" class="cv-input" placeholder="First Name" required aria-label="First Name">
				</div>
				<div>
					<label for="lastName" class="sr-only">Last Name</label>
					<input type="text" id="lastName" name="lastName" class="cv-input" placeholder="Last Name" required aria-label="Last Name">
				</div>
			</div>

			<label for="email" class="sr-only">Email</label>
			<input type="email" id="email" name="email" class="cv-input" placeholder="Email" required aria-label="Email">

			<label for="password" class="sr-only">Password</label>
			<input type="password" id="password" name="password" class="cv-input" placeholder="Password" required aria-label="Password">

			<div class="gender-group">
				<label><input type="radio" name="gender" value="MALE" required> Male</label>
				<label><input type="radio" name="gender" value="FEMALE"> Female</label>
				<label><input type="radio" name="gender" value="OTHER"> Other</label>
			</div>

			<div class="grid-2">
				<div>
					<label for="birthYear" class="sr-only">Birth Year</label>
					<input type="number" id="birthYear" name="birthYear" class="cv-input" placeholder="Birth Year" required aria-label="Birth Year">
				</div>
				<div>
					<label for="contactNum" class="sr-only">Contact Number</label>
					<input type="text" id="contactNum" name="contactNum" class="cv-input" placeholder="Contact Number" required aria-label="Contact Number">
				</div>
			</div>

			<label for="qualification" class="sr-only">Qualification</label>
			<input type="text" id="qualification" name="qualification" class="cv-input" placeholder="Qualification" aria-label="Qualification">

			<label for="userTypeId" class="sr-only">User Type</label>
			<select id="userTypeId" name="userTypeId" class="cv-select" aria-label="Select User Type">
				<option value="-1" disabled selected>Select User Type</option>
				<c:forEach items="${allUserType}" var="ut">
					<option value="${ut.userTypeId}">${ut.userType}</option>
				</c:forEach>
			</select>

			<div class="grid-2">
				<div>
					<label for="city" class="sr-only">City</label>
					<input type="text" id="city" name="city" class="cv-input" placeholder="City" aria-label="City">
				</div>
				<div>
					<label for="state" class="sr-only">State</label>
					<input type="text" id="state" name="state" class="cv-input" placeholder="State" aria-label="State">
				</div>
			</div>

			<label for="country" class="sr-only">Country</label>
			<input type="text" id="country" name="country" class="cv-input" value="India" aria-label="Country">

			<label for="profilePic" style="font-size:13px;">Profile Picture</label>
			<input type="file" id="profilePic" name="profilePic" class="cv-input">

			<button type="submit" class="btn-submit" aria-label="Create your account">
				<i class="bi bi-person-plus" aria-hidden="true"></i> Create Account
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