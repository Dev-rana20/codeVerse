<%--============================================================CODEVERSE — Dashboard (Demo / Reference Page) Path:
	src/main/webapp/WEB-INF/views/participant/dashboard.jsp Controller sets: model.addAttribute("pageTitle", "Dashboard"
	); model.addAttribute("activePage", "dashboard" ); session.setAttribute("userName", user.getName());
	session.setAttribute("userEmail", user.getEmail()); session.setAttribute("notifCount", notifCount); HOW TO BUILD ANY
	NEW PAGE — copy this file, then: 1. Change pageTitle + activePage 2. Replace everything inside <main
	class="cv-content">
	3. Done. Navbar, sidebar, footer are automatic.
	============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%-- ── Step 1: Set page identity ──────────────────────────── --%>
<c:set var="pageTitle" value="Dashboard" scope="request" />
<c:set var="activePage" value="dashboard" scope="request" />

<!DOCTYPE html>
<html lang="en" data-page="dashboard">
<%-- data-page on <html> or

							<body> is read by codeverse.js to
								auto-mark the correct sidebar link as active.
								--%>

<head>
<%@ include file="/WEB-INF/views/components/Head.jsp"%>
<style>
	/* Chart Premium Styles */
	.cv-chart-wrapper {
		position: relative;
		width: 100%;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.cv-chart-center-text {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		text-align: center;
		pointer-events: none;
		width: 100%;
		z-index: 10;
	}
	.cv-chart-center-val {
		font-size: 1.65rem;
		font-weight: 800;
		font-family: var(--font-mono);
		color: var(--text-primary);
		line-height: 1;
	}
	.cv-chart-center-label {
		font-size: 0.6rem;
		color: var(--text-muted);
		text-transform: uppercase;
		letter-spacing: 0.1em;
		margin-top: 4px;
		font-weight: 700;
	}
</style>
</head>

<body data-page="dashboard">

	<%-- ── Step 2: Navbar (always first inside body) ──────────── --%>
	<%@ include file="/WEB-INF/views/components/navbar.jsp"%>

	<%-- ── Step 3: Shell wraps sidebar + main content ─────────── --%>
	<div class="cv-shell">

		<%-- Step 4: Sidebar --%>
		<%@ include file="/WEB-INF/views/components/SidebarAdmin.jsp"%>

		<%-- ── Step 5: Your page content goes here
																────────────────── --%>
		<main class="cv-content">

			<div class="container-scroller">

				<div class="container-fluid page-body-wrapper">
					<div class="main-panel">
						<div class="content-wrapper">

							<!-- Page Header -->
							<div class="cv-page-header mb-4">
								<div>
									<div class="cv-page-eyebrow">
										<i class="bi bi-speedometer2"></i> Overview
									</div>
									<h1 class="cv-page-title">Welcome,
										${sessionScope.user.firstName}</h1>
									<p class="cv-page-sub">All systems are running smoothly!</p>
								</div>
							</div>

							<!-- Stat Cards -->
							<div class="row g-3 mb-4">
								<div class="col-6 col-xl-3">
									<a href="listUser" style="text-decoration: none">
										<div class="cv-stat">
											<div class="cv-stat__icon cv-stat__icon--cyan">
												<i class="bi bi-people-fill"></i>
											</div>
											<div>
												<div class="cv-stat__val">${fn:length(user)}</div>
												<div class="cv-stat__label">Total Users</div>
											</div>
										</div>
									</a>
								</div>
								<div class="col-6 col-xl-3">
									<a href="listHackathon" style="text-decoration: none">
										<div class="cv-stat">
											<div class="cv-stat__icon cv-stat__icon--purple">
												<i class="bi bi-lightning-charge-fill"></i>
											</div>
											<div>
												<div class="cv-stat__val">${fn:length(allHackathon)}</div>
												<div class="cv-stat__label">Total Hackathons</div>
											</div>
										</div>
									</a>
								</div>
								<div class="col-6 col-xl-3">
									<div class="cv-stat">
										<div class="cv-stat__icon cv-stat__icon--green">
											<i class="bi bi-cash-stack"></i>
										</div>
										<div>
											<div class="cv-stat__val">
												<fmt:formatNumber value="${analytics.totalRevenue}" type="currency" currencySymbol="₹" />
											</div>
											<div class="cv-stat__label">Total Revenue</div>
										</div>
									</div>
								</div>
								<div class="col-6 col-xl-3">
									<div class="cv-stat">
										<div class="cv-stat__icon cv-stat__icon--gold">
											<i class="bi bi-trophy-fill"></i>
										</div>
										<div>
											<div class="cv-stat__val">${analytics.totalSubmissions}</div>
											<div class="cv-stat__label">Submissions</div>
										</div>
									</div>
								</div>
							</div>

							<!-- Charts Section -->
							<div class="row g-4">
								<!-- Registrations Over Time -->
								<div class="col-12 col-xl-8">
									<div class="cv-card p-4 h-100">
										<h5 class="cv-card-title mb-4">Registrations Over Time (Last 30 Days)</h5>
										<div style="height: 300px;">
											<canvas id="registrationTrendChart"></canvas>
										</div>
									</div>
								</div>

								<!-- Team Formation Rate -->
								<div class="col-12 col-xl-4">
									<div class="cv-card p-4 h-100">
										<h5 class="cv-card-title mb-4">Team Formation Rate</h5>
										<div style="height: 250px;" class="cv-chart-wrapper">
											<canvas id="teamFormationChart"></canvas>
											<div class="cv-chart-center-text">
												<div class="cv-chart-center-val">${analytics.teamFormationRate}%</div>
												<div class="cv-chart-center-label">Efficiency</div>
											</div>
										</div>
									</div>
								</div>

								<!-- Judge Completion Rate -->
								<div class="col-12 col-xl-4">
									<div class="cv-card p-4 h-100">
										<h5 class="cv-card-title mb-4">Judge Completion</h5>
										<div style="height: 250px;" class="cv-chart-wrapper">
											<canvas id="judgeCompletionChart"></canvas>
											<div class="cv-chart-center-text">
												<div class="cv-chart-center-val">${analytics.judgeCompletionRate}%</div>
												<div class="cv-chart-center-label">Evaluations Done</div>
											</div>
										</div>
									</div>
								</div>

								<!-- Revenue Trend / Summary -->
								<div class="col-12 col-xl-8">
									<div class="cv-card p-4 h-100">
										<h5 class="cv-card-title mb-4">Summary Overview</h5>
										<div class="row g-3">
											<div class="col-md-6">
												<div class="p-3 bg-light rounded shadow-sm mb-3">
													<div class="text-muted small">Total Teams</div>
													<div class="h3 mb-0">${analytics.totalTeams}</div>
												</div>
												<div class="p-3 bg-light rounded shadow-sm">
													<div class="text-muted small">Total Participants</div>
													<div class="h3 mb-0">${analytics.totalParticipants}</div>
												</div>
											</div>
											<div class="col-md-6">
												<div class="p-3 bg-light rounded shadow-sm mb-3">
													<div class="text-muted small">Completed Evaluations</div>
													<div class="h3 mb-0 text-success">${analytics.completedEvaluations}</div>
												</div>
												<div class="p-3 bg-light rounded shadow-sm">
													<div class="text-muted small">Pending Evaluations</div>
													<div class="h3 mb-0 text-warning">${analytics.pendingEvaluations}</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

						</div>

					</div>
				</div>
			</div>

		</main>
		<%-- end cv-content --%>
	</div>
	<%-- end cv-shell --%>

	<%-- ── Step 6: Footer + Scripts (always last) ─────────────── --%>
	<%@ include file="/WEB-INF/views/components/Footer.jsp"%>
	<%@ include file="/WEB-INF/views/components/Scripts.jsp"%>

	<%-- Chart.js CDN --%>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

	<script>
		document.addEventListener('DOMContentLoaded', function() {
			// Parse the analytics JSON data
			let analytics = {};
			try {
				analytics = ${not empty analyticsJson ? analyticsJson : '{}'};
			} catch (e) {
				console.error("Failed to parse analytics data", e);
				return;
			}

			// Common Chart Formatting
			const chartColors = {
				cyan: '#22d3ee',
				purple: '#a855f7',
				green: '#10b981',
				gold: '#f59e0b',
				dark: '#1e293b',
				light: 'rgba(255, 255, 255, 0.05)'
			};

			// 1. Registration Trend Chart
			const regTrendCtx = document.getElementById('registrationTrendChart').getContext('2d');
			const regTrendLabels = Object.keys(analytics.registrationTrend || {});
			const regTrendData = Object.values(analytics.registrationTrend || {});

			new Chart(regTrendCtx, {
				type: 'line',
				data: {
					labels: regTrendLabels.map(d => {
						const date = new Date(d);
						return date.toLocaleDateString(undefined, { month: 'short', day: 'numeric' });
					}),
					datasets: [{
						label: 'Registrations',
						data: regTrendData,
						borderColor: chartColors.cyan,
						backgroundColor: 'rgba(34, 211, 238, 0.1)',
						borderWidth: 3,
						pointRadius: 4,
						pointBackgroundColor: chartColors.cyan,
						fill: true,
						tension: 0.4
					}]
				},
				options: {
					responsive: true,
					maintainAspectRatio: false,
					plugins: {
						legend: { display: false },
						tooltip: {
							mode: 'index',
							intersect: false,
							backgroundColor: 'rgba(15, 23, 42, 0.9)',
							titleColor: '#fff',
							bodyColor: '#fff',
							borderColor: chartColors.cyan,
							borderWidth: 1
						}
					},
					scales: {
						y: { 
							beginAtZero: true, 
							ticks: { color: 'rgba(255,255,255,0.5)', stepSize: 1 },
							grid: { color: chartColors.light } 
						},
						x: { 
							ticks: { 
								color: 'rgba(255,255,255,0.5)',
								autoSkip: true,
								maxRotation: 45,
								minRotation: 0,
								padding: 10
							},
							grid: { display: false } 
						}
					}
				}
			});

			// 2. Team Formation Chart (Doughnut)
			const teamCtx = document.getElementById('teamFormationChart').getContext('2d');
			new Chart(teamCtx, {
				type: 'doughnut',
				data: {
					labels: ['Teams Formed', 'Total Participants'],
					datasets: [{
						data: [analytics.totalTeams || 0, Math.max(0, (analytics.totalParticipants || 0) - (analytics.totalTeams || 0))],
						backgroundColor: [chartColors.purple, chartColors.dark],
						hoverOffset: 4,
						borderWidth: 0
					}]
				},
				options: {
					cutout: '85%',
					responsive: true,
					maintainAspectRatio: false,
					plugins: {
						legend: { display: false }
					}
				}
			});

			// 3. Judge Completion Chart (Doughnut)
			const judgeCtx = document.getElementById('judgeCompletionChart').getContext('2d');
			new Chart(judgeCtx, {
				type: 'doughnut',
				data: {
					labels: ['Completed', 'Pending'],
					datasets: [{
						data: [analytics.completedEvaluations || 0, analytics.pendingEvaluations || 0],
						backgroundColor: [chartColors.green, chartColors.gold],
						hoverOffset: 4,
						borderWidth: 0
					}]
				},
				options: {
					cutout: '85%',
					responsive: true,
					maintainAspectRatio: false,
					plugins: {
						legend: { display: false }
					}
				}
			});
		});
	</script>

</body>

</html>