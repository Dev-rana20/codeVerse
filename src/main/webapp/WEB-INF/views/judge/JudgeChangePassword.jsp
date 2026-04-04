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

			<jsp:include page="../AdminCSS.jsp" />
			<style>
				@media (max-width : 600px) {
					.grid-2 {
						grid-template-columns: 1fr;
					}
				}

				.cv-input {
					width: 100%;
					padding: 10px;
					box-sizing: border-box;
					/* VERY IMPORTANT */
				}
			</style>

		</head>

		<body class="cv-scope">

			<div class="auth-left">
				<div class="auth-card dark-form">

					<a href="/" class="auth-brand">CODE<span>VERSE</span></a>

					<h2>Complete Profile</h2>
					<p style="color: #aaa; font-size: 13px;">Set up your profile and
						begin your journey as a judge on CodeVerse</p>

					<form action="/judge/complete-profile" method="post">

						<div class="grid-2">
							<input type="text" name="firstName" class="cv-input" placeholder="First Name" required>
							<input type="text" name="lastName" class="cv-input" placeholder="Last Name" required>
						</div>

						<input type="text" name="contactNum" class="cv-input" placeholder="Contact Number" required>

						<div class="gender-group">
							<label><input type="radio" name="gender" value="Male" required> Male</label> <label><input
									type="radio" name="gender" value="Female"> Female</label> <label><input type="radio"
									name="gender" value="Other"> Other</label>
						</div>

						<div class="grid-2">
							<input type="password" name="newPassword" class="cv-input" placeholder="New Password"
								required> <input type="password" name="confirmPassword" class="cv-input"
								placeholder="Confirm Password" required>
						</div>

						<button type="submit" class="btn-submit">Complete Profile</button>

					</form>
				</div>
			</div>

			<div class="auth-right">
				<p class="auth-tagline">
					Build.<br>Compete.<br> <span>Win.</span>
				</p>

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