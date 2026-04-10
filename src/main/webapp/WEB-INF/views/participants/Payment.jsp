<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>



<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="../components/Head.jsp"%>
<style>
:root {
	--payment-bg: #0f172a;
	--card-bg: #1e293b;
	--accent: #00ffe0;
	--text-main: #f1f5f9;
	--text-muted: #94a3b8;
}

body {
	background-color: var(--payment-bg);
	color: var(--text-main);
	font-family: 'Inter', sans-serif;
}

.payment-container {
	max-width: 1000px;
	margin: 50px auto;
	padding: 20px;
}

.payment-grid {
	display: grid;
	grid-template-columns: 1.5fr 1fr;
	gap: 30px;
}

.cv-card {
	background: var(--card-bg);
	border: 1px solid rgba(255, 255, 255, 0.1);
	border-radius: 16px;
	padding: 30px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
}

.payment-header h2 {
	font-size: 28px;
	font-weight: 700;
	margin-bottom: 5px;
	background: linear-gradient(90deg, #fff, var(--accent));
	-webkit-background-clip: text;
	background-clip: text;
	-webkit-text-fill-color: transparent;
}

.order-summary {
	background: rgba(0, 255, 224, 0.05);
	border: 1px dashed var(--accent);
	border-radius: 12px;
	padding: 20px;
	margin-top: 20px;
}

.summary-item {
	display: flex;
	justify-content: space-between;
	margin-bottom: 10px;
}

.summary-total {
	border-top: 1px solid rgba(255, 255, 255, 0.1);
	padding-top: 10px;
	margin-top: 10px;
	font-weight: 700;
	font-size: 20px;
	color: var(--accent);
}

/* Form Styling */
.form-group {
	margin-bottom: 20px;
}

.form-label {
	display: block;
	margin-bottom: 8px;
	color: var(--text-muted);
	font-size: 14px;
}

.form-input {
	width: 100%;
	background: rgba(255, 255, 255, 0.05);
	border: 1px solid rgba(255, 255, 255, 0.1);
	border-radius: 8px;
	padding: 12px;
	color: #fff;
	transition: all 0.3s;
}

.form-input:focus {
	outline: none;
	border-color: var(--accent);
	box-shadow: 0 0 0 2px rgba(0, 255, 224, 0.2);
}

.pay-btn {
	background: var(--accent);
	color: #000;
	border: none;
	padding: 15px;
	border-radius: 8px;
	font-weight: 700;
	font-size: 16px;
	width: 100%;
	cursor: pointer;
	transition: 0.3s;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
}

.pay-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(0, 255, 224, 0.4);
}

.card-preview {
	background: linear-gradient(135deg, #4338ca, #1e1b4b);
	border-radius: 12px;
	padding: 25px;
	color: #fff;
	height: 200px;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	margin-bottom: 30px;
	position: relative;
	overflow: hidden;
}

.card-preview::before {
	content: '';
	position: absolute;
	top: -50px;
	right: -50px;
	width: 150px;
	height: 150px;
	background: rgba(255, 255, 255, 0.1);
	border-radius: 50%;
}

.chip {
	width: 45px;
	height: 35px;
	background: #fde68a;
	border-radius: 6px;
}

.card-number {
	font-size: 22px;
	letter-spacing: 2px;
	margin: 20px 0;
}

.payment-methods {
	display: flex;
	gap: 15px;
	margin-bottom: 25px;
}

.method-tab {
	padding: 10px 20px;
	border-radius: 8px;
	background: rgba(255, 255, 255, 0.05);
	border: 1px solid rgba(255, 255, 255, 0.1);
	cursor: pointer;
	color: var(--text-muted);
	transition: 0.3s;
}

.method-tab.active {
	background: rgba(0, 255, 224, 0.1);
	border-color: var(--accent);
	color: var(--accent);
}

@media ( max-width : 768px) {
	.payment-grid {
		grid-template-columns: 1fr;
	}
}
</style>
</head>

<body>

	<div class="cv-shell">
		<%@ include file="../components/Sidebar.jsp"%>

		<main class="cv-content">
			<div class="payment-container">

				<div class="payment-header mb-5">
					<h2>Complete Your Registration</h2>
					<p class="text-muted">
						Securely pay for <strong>${hack.title}</strong>
					</p>
				</div>

				<div class="payment-grid">

					<!-- Payment Form -->
					<div class="cv-card">

						<div class="payment-methods">
							<div class="method-tab active">
								<i class="bi bi-credit-card"></i> Card
							</div>
							<div class="method-tab">
								<i class="bi bi-phone"></i> UPI
							</div>
							<div class="method-tab">
								<i class="bi bi-bank"></i> Net Banking
							</div>
						</div>

						<div class="card-preview">
							<div class="chip"></div>
							<div class="card-number" id="cardNumberDisplay">**** ****
								**** 4242</div>
							<div style="display: flex; justify-content: space-between;">
								<div>
									<small style="opacity: 0.7;">CARD HOLDER</small>
									<div id="cardHolderDisplay">${user.firstName}
										${user.lastName}</div>
								</div>
								<div>
									<small style="opacity: 0.7;">EXPIRES</small>
									<div>12/26</div>
								</div>
							</div>
						</div>

						<div id="paymentFormContainer">
							<form action="/hackathons/${hack.hackathonId}/pay" method="POST">
								<input type="hidden" name="razorpay_payment_id"
									value="DEMO_TXN_${System.currentTimeMillis()}">

								<div class="cv-alert info mb-4"
									style="background: rgba(0, 255, 224, 0.1); padding: 15px; border-radius: 8px; border: 1px solid var(--accent); color: var(--accent);">
									<i class="bi bi-info-circle"></i> This is a Demo Bypass mode.
									Clicking below will instantly register you.
								</div>

								<button type="submit" class="pay-btn"
									style="height: 60px; font-size: 18px; box-shadow: 0 0 20px rgba(0, 255, 224, 0.4);">
									<i class="bi bi-shield-lock-fill"></i> Simulate Payment Success
									(₹${hack.fee})
								</button>
							</form>
						</div>

						<p class="text-center mt-3"
							style="font-size: 12px; color: var(--text-muted);">
							<i class="bi bi-shield-check"></i> Demo Mode Active
						</p>
					</div>

					<!-- Order Summary -->
					<div class="cv-card">
						<h3>Order Summary</h3>

						<div class="order-summary">
							<div class="summary-item">
								<span>Event</span> <span style="font-weight: 600;">${hack.title}</span>
							</div>
							<div class="summary-item">
								<span>Type</span> <span>${hack.eventType} Registration</span>
							</div>
							<div class="summary-item">
								<span>Participant</span> <span>${user.firstName}
									${user.lastName}</span>
							</div>

							<div class="summary-total">
								<span>Amount to Pay</span> <span>₹${hack.fee}</span>
							</div>
						</div>

						<div class="mt-4">
							<h5
								style="font-size: 14px; color: var(--text-muted); margin-bottom: 15px;">Benefits
								Includes:</h5>
							<ul
								style="font-size: 13px; color: var(--text-muted); padding-left: 20px;">
								<li>Full access to all hackathon workshops</li>
								<li>Digital Certificate of participation</li>
								<li>Opportunity to pitch to industry leaders</li>
								<li>Exclusive swags (for offline attendees)</li>
							</ul>
						</div>

						<a href="/hackathonDetail/${hack.hackathonId}"
							class="btn btn-link w-100 mt-3"
							style="color: var(--text-muted); text-decoration: none;"> <i
							class="bi bi-arrow-left"></i> Cancel and Go Back
						</a>
					</div>

				</div>
			</div>
		</main>
	</div>

	<%@ include file="../components/Footer.jsp"%>
	<%@ include file="../components/Scripts.jsp"%>
</body>

</html>