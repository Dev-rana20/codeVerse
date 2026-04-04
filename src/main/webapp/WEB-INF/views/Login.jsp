<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CodeVerse — Login</title>

<!-- Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet"/>

<!-- Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>

<jsp:include page="AdminCSS.jsp"></jsp:include>

<style>
body {
	display: flex;
	min-height: 100vh;
	background: #0a0e18;
	color: #fff;
	font-family: 'Syne', sans-serif;
}

/* LEFT */
.auth-left {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 2rem;
}

/* RIGHT PANEL */
.auth-right {
	width: 45%;
	background: linear-gradient(145deg, #0a0e18, #111827);
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	position: relative;
	padding: 2rem;
}

.auth-tagline {
	font-size: 34px;
	font-weight: 800;
	text-align: center;
	line-height: 1.2;
}

.auth-tagline span {
	color: #00ffe0;
}

/* CARD */
.auth-card {
	background: #111827;
	border-radius: 14px;
	padding: 2.5rem;
	width: 100%;
	max-width: 420px;
	box-shadow: 0 0 40px rgba(0,0,0,0.6);
}

/* BRAND */
.auth-brand {
	font-family: 'Space Mono', monospace;
	color: #00ffe0;
	font-weight: bold;
	display: block;
	margin-bottom: 20px;
	text-decoration: none;
}
.auth-brand span { color: #fff; }

/* TITLE */
.auth-title {
	font-size: 26px;
	font-weight: 800;
}
.auth-sub {
	font-size: 13px;
	color: #aaa;
	margin-bottom: 20px;
}

/* INPUT */
.cv-input-wrap {
	position: relative;
}
.cv-input-wrap i {
	position: absolute;
	left: 10px;
	top: 50%;
	transform: translateY(-50%);
	color: #888;
}
.cv-input {
	width: 100%;
	padding: 10px 10px 10px 35px;
	border-radius: 8px;
	border: 1px solid #333;
	background: #0a0e18;
	color: #fff;
	margin-bottom: 15px;
}
.cv-input:focus {
	border-color: #00ffe0;
	outline: none;
}

/* BUTTON */
.btn-login {
	width: 100%;
	padding: 10px;
	border-radius: 8px;
	background: #00ffe0;
	color: #000;
	border: none;
	font-weight: bold;
	cursor: pointer;
}
.btn-login:hover {
	background: #00ccbb;
}

/* ALERT */
.cv-alert {
	padding: 10px;
	border-radius: 8px;
	margin-bottom: 15px;
	font-size: 13px;
}
.cv-alert--error {
	background: #ff4d4f20;
	color: #ff4d4f;
}

/* REMEMBER */
.auth-row {
	display: flex;
	justify-content: space-between;
	font-size: 12px;
	margin-bottom: 15px;
}
.auth-row a {
	color: #00ffe0;
	text-decoration: none;
}

/* SWITCH */
.auth-switch {
	text-align: center;
	font-size: 13px;
	margin-top: 15px;
}
.auth-switch a {
	color: #00ffe0;
}

/* FEATURES */
.auth-feature {
	display: flex;
	gap: 10px;
	margin-top: 20px;
}
.auth-feature i {
	color: #00ffe0;
}

/* MOBILE */
@media (max-width: 768px) {
	.auth-right { display: none; }
}
</style>
</head>

<body>

<!-- LEFT -->
<div class="auth-left">
	<div class="auth-card">

		<a href="/" class="auth-brand">CODE<span>VERSE</span></a>

		<h2 class="auth-title">Welcome back</h2>
		<p class="auth-sub">Sign in to your account</p>

		<!-- ERROR -->
		<c:if test="${not empty error}">
			<div class="cv-alert cv-alert--error">
				<i class="bi bi-exclamation-triangle-fill"></i> ${error}
			</div>
		</c:if>

		<form action="authenticate" method="post">

			<!-- EMAIL -->
			<label>Email</label>
			<div class="cv-input-wrap">
				<i class="bi bi-envelope"></i>
				<input type="email" name="email" class="cv-input" placeholder="you@example.com" required>
			</div>

			<!-- PASSWORD -->
			<label>Password</label>
			<div class="cv-input-wrap">
				<i class="bi bi-lock"></i>
				<input type="password" name="password" class="cv-input" placeholder="••••••••" required>
			</div>

			<!-- ROW -->
			<div class="auth-row">
				<label><input type="checkbox"> Remember me</label>
				<a href="forgetPassword">Forgot?</a>
			</div>

			<!-- BUTTON -->
			<button type="submit" class="btn-login">
				<i class="bi bi-box-arrow-in-right"></i> Sign In
			</button>

		</form>

		<!-- SWITCH -->
		<div class="auth-switch">
			Don’t have an account? <a href="signup">Create one</a>
		</div>

	</div>
</div>

<!-- RIGHT -->
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