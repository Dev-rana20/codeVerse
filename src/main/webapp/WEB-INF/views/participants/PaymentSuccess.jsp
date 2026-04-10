<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../components/Head.jsp"%>
<style>
.success-page {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	min-height: 70vh;
	text-align: center;
}

.success-icon {
	font-size: 80px;
	color: #00ffe0;
	margin-bottom: 20px;
	animation: bounceIn 0.8s cubic-bezier(0.68, -0.55, 0.265, 1.55);
}

@
keyframes bounceIn {from { opacity:0;
	transform: scale(0.3);
}

to {
	opacity: 1;
	transform: scale(1);
}

}
.success-card {
	background: #1e293b;
	padding: 40px;
	border-radius: 20px;
	border: 1px solid rgba(0, 255, 224, 0.3);
	max-width: 500px;
	width: 90%;
	box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
}

.txn-id {
	background: rgba(255, 255, 255, 0.05);
	padding: 10px;
	border-radius: 8px;
	font-family: monospace;
	color: #94a3b8;
	margin: 20px 0;
}
</style>
</head>
<body>
	<%@ include file="../components/navbar.jsp"%>

	<div class="cv-shell">
		<%@ include file="../components/Sidebar.jsp"%>

		<main class="cv-content">
			<div class="success-page">
				<div class="success-card">
					<div class="success-icon">
						<i class="bi bi-check-circle-fill"></i>
					</div>
					<h1 class="cv-page-title mb-2">Payment Successful!</h1>
					<p class="cv-muted">
						Registration for <strong>${reg.hackathon.title}</strong> is
						confirmed.
					</p>

					<div class="txn-id">Ref ID: ${reg.paymentId}</div>

					<div class="cv-grid-2 gap-3 mt-4">
						<a href="/hackathonDetail/${reg.hackathon.hackathonId}"
							class="btn-cv btn-cv--primary btn-cv--block"> View Hackathon
						</a> <a href="/paymentHistory"
							class="btn-cv btn-cv--ghost btn-cv--block"> Payment History </a>
					</div>
				</div>
			</div>
		</main>
	</div>

	<%@ include file="../components/Footer.jsp"%>
	<%@ include file="../components/Scripts.jsp"%>
</body>
</html>
