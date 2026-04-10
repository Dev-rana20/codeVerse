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

		<h2>Verify OTP</h2>
		<p style="color:#aaa; font-size:13px;">Join CodeVerse and start competing</p>

		<form action="verifyOtp" method="post">

		<c:if test="${not empty error}">
			<div class="alert alert-danger" role="alert" style="color: #ff5252; background: rgba(255,82,82,0.1); padding: 10px; border-radius: 8px; margin-bottom: 20px; font-size: 13px; border: 1px solid rgba(255,82,82,0.2);">
				<i class="bi bi-exclamation-triangle-fill" aria-hidden="true"></i> ${error}
			</div>
		</c:if>
		
		<c:if test="${not empty success}">
			<div class="alert alert-success" role="alert" style="color: #00ffe0; background: rgba(0,255,224,0.1); padding: 10px; border-radius: 8px; margin-bottom: 20px; font-size: 13px; border: 1px solid rgba(0,255,224,0.2);">
				<i class="bi bi-check-circle-fill" aria-hidden="true"></i> ${success}
			</div>
		</c:if>

								<input type="hidden" name="email" value="${email}">
								<div class="mb-3">
									<label for="otp">Enter OTP</label> <input type="text" id="otp" name="otp"
										class="form-control" required aria-label="Enter One Time Password">
								</div>

								<button type="submit" class="btn-submit">
									Verify OTP</button>

							</form>

		<div class="auth-switch">
			Already have an account? <a href="login">Login</a>
		</div>

	</div>
</div>

<div class="auth-right">
	<p class="auth-tagline">Build.<br>Compete.<br><span>Win.</span></p>

	<div class="auth-feature">
		<i class="bi bi-lightning-charge-fill" aria-hidden="true"></i>
		<div>Real Hackathons</div>
	</div>

	<div class="auth-feature">
		<i class="bi bi-people-fill" aria-hidden="true"></i>
		<div>Team Up</div>
	</div>

	<div class="auth-feature">
		<i class="bi bi-trophy-fill" aria-hidden="true"></i>
		<div>Win Prizes</div>
	</div>
</div>

</body>
</html>