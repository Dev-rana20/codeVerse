<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

		<!DOCTYPE html>
		<html lang="en">

		<head>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<title>CodeVerse — Sign Up</title>

			<!-- Fonts -->
			<link
				href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap"
				rel="stylesheet" />

			<!-- Icons -->
			<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
				rel="stylesheet" />

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

					<form action="updatePassword" method="post">
						<input type="hidden" name="email" value="${email}">

						<div class="mb-3">
							<label>New Password</label> <input type="password" name="Password" class="form-control"
								required>
						</div>

						<div class="mb-3">
							<label>Confirm Password</label> <input type="password" name="confirmPassword"
								class="form-control" required>
						</div>
						<c:if test="${not empty error}">
							<div class="alert alert-danger">${error}</div>
						</c:if>

						<button type="submit" class="btn-submit">
							Update Password</button>

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