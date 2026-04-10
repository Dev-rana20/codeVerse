<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%-- ── Page Identity ───────────────────────────── --%>
<c:set var="pageTitle" value="Team Register" scope="request" />
<c:set var="activePage" value="team" scope="request" />

<!DOCTYPE html>
<html lang="en" data-page="team-register">

<head>
<%@ include file="../components/Head.jsp"%>
</head>

<body data-page="team-register">

	<%@ include file="../components/navbar.jsp"%>

	<div class="cv-shell">

		<%@ include file="../components/Sidebar.jsp"%>

		<main class="cv-content">

			<c:if test="${not empty success}">
				<div class="alert alert-success cv-msg">${success}</div>
			</c:if>

			<c:if test="${not empty error}">
				<div class="alert alert-danger cv-msg">${error}</div>
			</c:if>

			<%-- PAGE HEADER --%>
			<div class="cv-page-header">
				<div class="cv-page-header__left">
					<div class="cv-page-eyebrow">
						<i class="bi bi-people-fill"></i> Team Setup
					</div>

					<h1 class="cv-page-title">
						Create / Join Team for <span style="color: var(--primary)">
							${hackathon.title} </span>
					</h1>

					<p class="cv-page-subtitle">Invite members or join an existing
						team</p>
				</div>
			</div>

			<%-- ALERTS --%>
			<c:if test="${not empty errorMsg}">
				<div class="cv-alert cv-alert--error">
					<i class="bi bi-exclamation-triangle-fill"></i> ${errorMsg}
				</div>
			</c:if>

			<c:if test="${not empty successMsg}">
				<div class="cv-alert cv-alert--success">
					<i class="bi bi-check-circle-fill"></i> ${successMsg}
				</div>
			</c:if>

			<div class="row g-4">

				<%-- LEFT: Create Team Form --%>
				<%-- LEFT: Create Team Form --%>
				<div class="col-12 col-lg-6">

					<div class="cv-card cv-fade-up">

						<div class="cv-card__header">
							<i class="bi bi-plus-circle"></i>
							<h2>Create New Team</h2>
						</div>

						<div class="cv-card__body">

							<c:choose>
								<c:when test="${hasCreatedTeam}">
									<div class="cv-alert cv-alert--warning">
										<i class="bi bi-exclamation-triangle-fill"></i> You have
										already created a team for this hackathon. You cannot create
										another team, but you can join existing teams.
									</div>
								</c:when>

								<c:otherwise>
									<form method="post" action="/team/create">
									

										<input type="hidden" name="hackathonId"
											value="${hackathon.hackathonId}" />

										<div class="mb-3">
											<label class="form-label">Team Name</label> <input
												type="text" name="teamName" class="form-control cv-input"
												placeholder="Enter team name" required />
										</div>

										<div class="mb-3">
											<label class="form-label">Invite Members (Optional)</label>

											<c:if test="${empty users}">
												<div class="cv-empty">
													<i class="bi bi-person-x"></i>
													<p>No users found</p>
												</div>
											</c:if>

											<div class="cv-user-list"
												style="max-height: 250px; overflow-y: auto; padding: 10px; border: 1px solid var(--border); border-radius: 10px;">

												<c:forEach var="u" items="${users}">
													<div class="form-check mb-2">
														<input class="form-check-input" type="checkbox"
															name="memberIds" value="${u.userId}" /> <label
															class="form-check-label"> ${u.firstName}
															${u.lastName} (${u.email}) </label>
													</div>
												</c:forEach>

											</div>
										</div>

										<button class="btn-cv btn-cv--primary btn-cv--block">
											<i class="bi bi-check2-circle"></i> Create Team
										</button>

									</form>
								</c:otherwise>
							</c:choose>

						</div>
					</div>

				</div>

				<%-- RIGHT: Join Existing Team --%>
				<div class="col-12 col-lg-6">

					<div class="cv-card cv-fade-up">

						<div class="cv-card__header">
							<i class="bi bi-box-arrow-in-right"></i>
							<h2>Join Existing Team</h2>
						</div>

						<div class="cv-card__body">

							<c:if test="${empty teams}">
								<div class="cv-empty">
									<i class="bi bi-people"></i>
									<p>No teams available</p>
								</div>
							</c:if>

							<c:forEach var="t" items="${teams}">
								<div class="cv-card mb-2 p-3">

									<div style="font-weight: 600;">${t.teamName}</div>
									<form action="/team/requestJoin" method="post">
									
										<input type="hidden" name="teamId"
											value="${t.hackathonTeamId}" />
										<button class="btn-cv btn-cv--ghost btn-cv--sm">Request
											Join</button>
									</form>


								</div>
							</c:forEach>

						</div>
					</div>

				</div>

			</div>

		</main>
	</div>

	<%@ include file="../components/Footer.jsp"%>
	<%@ include file="../components/Scripts.jsp"%>

</body>
<script>
    setTimeout(() => {
        const success = document.querySelector('.alert-success');
        const error = document.querySelector('.alert-danger');

        if (success) {
            success.style.transition = "0.5s";
            success.style.opacity = "0";
            setTimeout(() => success.remove(), 500);
        }

        if (error) {
            error.style.transition = "0.5s";
            error.style.opacity = "0";
            setTimeout(() => error.remove(), 500);
        }
    }, 2000);
</script>
</html>