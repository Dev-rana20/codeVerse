<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="activePage" value="payments" scope="request" />
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../components/Head.jsp"%>
<style>
.payment-table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0 10px;
}

.payment-row {
	background: #1e293b;
	border-radius: 12px;
	overflow: hidden;
	transition: 0.3s;
	border: 1px solid rgba(255, 255, 255, 0.05);
}

.payment-row:hover {
	transform: scale(1.01);
	background: rgba(255, 255, 255, 0.07);
	border-color: rgba(0, 255, 224, 0.3);
}

.payment-cell {
	padding: 20px;
	color: #94a3b8;
}

.payment-cell.title {
	color: #f1f5f9;
	font-weight: 600;
}

.payment-cell.amount {
	color: #00ffe0;
	font-weight: 700;
}

.payment-cell.id {
	font-family: monospace;
	font-size: 13px;
}

.payment-header-cell {
	padding: 10px 20px;
	color: #475569;
	text-transform: uppercase;
	font-size: 12px;
	font-weight: 700;
	letter-spacing: 1px;
}
</style>

</head>
<body>
	<%@ include file="../components/navbar.jsp"%>

	<div class="cv-shell">
		<%@ include file="../components/Sidebar.jsp"%>

		<main class="cv-content">
			<div class="cv-page-header">
				<div>
					<h1 class="cv-page-title">Payment History</h1>
					<p class="cv-page-subtitle">Track all your hackathon
						registration payments</p>
				</div>
			</div>

			<c:choose>
				<c:when test="${empty payments}">
					<div class="cv-empty-state">
						<i class="bi bi-wallet2"
							style="font-size: 50px; color: #334155; margin-bottom: 20px;"></i>
						<p class="cv-muted">You haven't made any payments yet.</p>
						<a href="/hackathons" class="btn-cv btn-cv--primary mt-3">Register
							for Hackathons</a>
					</div>
				</c:when>

				<c:otherwise>
					<table class="payment-table">
						<thead>
							<tr>
								<th class="payment-header-cell">Hackathon</th>
								<th class="payment-header-cell">Date</th>
								<th class="payment-header-cell">Amount</th>
								<th class="payment-header-cell">Payment ID</th>
								<th class="payment-header-cell">Status</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="pay" items="${payments}">
								<tr class="payment-row">
									<td class="payment-cell title">${pay.hackathon.title}</td>
									<td class="payment-cell">${pay.registrationDate}</td>
									<td class="payment-cell amount"><c:choose>
											<c:when test="${pay.amount > 0}">₹${pay.amount}</c:when>
											<c:otherwise>FREE</c:otherwise>
										</c:choose></td>
									<td class="payment-cell id">${pay.paymentId != null ? pay.paymentId : '—'}</td>
									<td class="payment-cell"><span class="badge bg-success">Success</span>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:otherwise>
			</c:choose>
		</main>
	</div>

	<%@ include file="../components/Footer.jsp"%>
	<%@ include file="../components/Scripts.jsp"%>
</body>
</html>
