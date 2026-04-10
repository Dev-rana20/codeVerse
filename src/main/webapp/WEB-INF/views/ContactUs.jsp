<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Contact Us" scope="request" />
<c:set var="activePage" value="contact" scope="request" />

<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="components/Head.jsp"%>
</head>
<body>
	<%@ include file="components/navbar.jsp"%>

	<div class="cv-shell">
		<%@ include file="components/Sidebar.jsp"%>

		<main class="cv-content">
			<div class="cv-hero mb-5">
				<div class="cv-hero__title">
					Get in <span>Touch</span>
				</div>
				<p class="cv-hero__subtitle">Have questions or need support?
					We're here to help.</p>
			</div>

			<div class="row g-4">

				<!-- 🔹 CONTACT INFORMATION -->
				<div class="col-lg-12">
					<div class="row g-4">

						<div class="col-md-4">
							<div class="cv-card h-100 text-center p-4">
								<div class="mb-4">
									<i class="bi bi-envelope-at display-4 color-primary"></i>
								</div>
								<h3 class="fs-5 mb-3">Email Support</h3>
								<p class="text-muted">For general inquiries and technical
									help.</p>
								<a href="mailto:support@codeverse.com"
									class="fw-bold color-primary text-decoration-none fs-5">support@codeverse.com</a>
							</div>
						</div>

						<div class="col-md-4">
							<div class="cv-card h-100 text-center p-4">
								<div class="mb-4">
									<i class="bi bi-chat-dots display-4 color-success"></i>
								</div>
								<h3 class="fs-5 mb-3">Community</h3>
								<p class="text-muted">Join our Discord for real-time
									collaboration.</p>
								<a href="#"
									class="fw-bold color-success text-decoration-none fs-5">Join
									Discord</a>
							</div>
						</div>

						<div class="col-md-4">
							<div class="cv-card h-100 text-center p-4">
								<div class="mb-4">
									<i class="bi bi-geo-alt display-4 color-warning"></i>
								</div>
								<h3 class="fs-5 mb-3">Office</h3>
								<p class="text-muted">Visit our main hub for offline events.</p>
								<address class="fw-bold text-white fs-5 mb-0">123 Tech
									Avenue, Silicon Valley, CA</address>
							</div>
						</div>

					</div>
				</div>

				<div class="col-12 mt-5">
					<div class="cv-card p-5 overflow-hidden position-relative">
						<!-- Neon detail -->
						<div
							style="position: absolute; top: -20%; right: -10%; width: 40%; height: 60%; background: radial-gradient(circle, rgba(0, 255, 224, 0.1) 0%, rgba(0, 0, 0, 0) 70%); border-radius: 50%; pointer-events: none;"></div>

						<div class="row align-items-center">
							<div class="col-lg-6">
								<h2 class="display-5 fw-bold mb-4">
									Want to <span class="color-primary">partner</span> with us?
								</h2>
								<p class="text fs-5 mb-4">We're always looking for
									sponsors, mentors, and corporate partners to help grow our
									hackathon ecosystem. Reach out and let's build something
									amazing together.</p>
								<div class="d-flex gap-3">
									<a href="#" class="btn-cv btn-cv--primary px-4 py-2">Sponsorship
										Inquiry</a> <a href="#" class="btn-cv btn-cv--outline px-4 py-2">Become
										a Judge</a>
								</div>
							</div>
							<div class="col-lg-6 text-center mt-5 mt-lg-0">
								<img
									src="https://cdni.iconscout.com/illustration/premium/thumb/contact-us-3483604-2912020.png"
									alt="Contact" class="img-fluid"
									style="max-width: 400px; filter: drop-shadow(0 0 20px rgba(0, 255, 224, 0.2));" />
							</div>
						</div>
					</div>
				</div>

			</div>
		</main>
	</div>

	<%@ include file="components/Footer.jsp"%>
	<%@ include file="components/Scripts.jsp"%>
</body>
</html>
