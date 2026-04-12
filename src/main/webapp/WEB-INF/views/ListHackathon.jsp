<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- ── Page Identity ── --%>
<c:set var="pageTitle" value="List Hackathon" scope="request" />
<c:set var="activePage" value="listHackathon" scope="request" />

<!DOCTYPE html>
<html lang="en" data-page="listHackathon">

<head>
<%@ include file="/WEB-INF/views/components/Head.jsp"%>

<style>
.cv-badge.UPCOMING {
	background: var(--info);
}

.cv-badge.OPEN {
	background: var(--success);
}

.cv-badge.COMPLETED {
	background: var(--secondary);
}

.cv-badge.FREE {
	background: var(--success);
}

.cv-badge.PAID {
	background: var(--danger);
}
</style>

</head>

<body data-page="listHackathon">

	<%-- Navbar --%>
	<%@ include file="/WEB-INF/views/components/navbar.jsp"%>

	<div class="cv-shell">

		<%-- Sidebar --%>
		<%@ include file="/WEB-INF/views/components/SidebarAdmin.jsp"%>

		<main class="cv-content">

			<!-- Page Header -->
			<div class="cv-page-header mb-4">
				<div>
					<div class="cv-page-eyebrow">
						<i class="bi bi-lightning-charge"></i> Hackathons
					</div>
					<h1 class="cv-page-title">All Hackathons</h1>
				</div>

				<a href="newHackathon" class="btn-cv btn-cv-primary"> <i
					class="bi bi-plus-circle"></i> New Hackathon
				</a>
			</div>

			<!-- Table Card -->
			<div class="cv-card">

				<div class="cv-card__header">
					<i class="bi bi-list-check"></i>
					<h3>Hackathon List</h3>
				</div>

				<div class="cv-card__body">

					<div class="cv-table-wrap">
						<table class="cv-table">

							<thead>
								<tr>
									<th>#</th>
									<th>Title</th>
									<th>Status</th>
									<th>Event Type</th>
									<th>Payment</th>
									<th>Team Size</th>
									<th>Location</th>
									<th>Registration</th>
									<th>Actions</th>
								</tr>
							</thead>

							<tbody>

								<c:choose>
									<c:when test="${empty allHackathon}">
										<tr>
											<td colspan="9" class="text-center text-muted">No
												hackathons found</td>
										</tr>
									</c:when>

									<c:otherwise>
										<c:forEach var="h" items="${allHackathon}" varStatus="i">
											<tr>

												<td>${i.count}</td>

												<td>${h.title}</td>

												<td><span class="cv-badge ${h.status}">
														${h.status} </span></td>

												<td>${h.eventType}</td>

												<td><span class="cv-badge ${h.payment}">
														${h.payment} </span></td>

												<td>${h.minTeamSize}- ${h.maxTeamSize}</td>

												<td>${h.location}</td>

												<td>${h.registrationStartDate} <br /> <small>to
														${h.registrationEndDate}</small>
												</td>

												<td><a
								href="viewHackathon?hackathonId=${h.hackathonId}"
								class="btn-cv btn-cv-info btn-sm"> <i class="bi bi-eye"></i>
							</a> <a href="editHackathon?hackathonId=${h.hackathonId}"
								class="btn-cv btn-cv-warning btn-sm"> <i
									class="bi bi-pencil"></i>
							</a>
							<form action="deleteHackathon" method="post" style="display:inline"
								onsubmit="return confirm('Are you sure you want to delete this hackathon? All related data (teams, registrations, submissions, evaluations) will be permanently removed.')">
								<input type="hidden" name="hackathonId" value="${h.hackathonId}" />
								<button type="submit" class="btn-cv btn-cv-danger btn-sm">
									<i class="bi bi-trash"></i>
								</button>
							</form></td>

											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>

							</tbody>

						</table>
					</div>

				</div>

			</div>

		</main>
	</div>

	<%-- Footer + Scripts --%>
	<%@ include file="/WEB-INF/views/components/Footer.jsp"%>
	<%@ include file="/WEB-INF/views/components/Scripts.jsp"%>

</body>
</html>