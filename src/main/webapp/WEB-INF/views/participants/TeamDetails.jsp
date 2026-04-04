<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<title>Team Details</title>
<%@ include file="../components/Head.jsp"%>
</head>

<body>

	<%@ include file="../components/navbar.jsp"%>

	<div class="cv-shell">
		<%@ include file="../components/Sidebar.jsp"%>

		<main class="cv-content">

			<div class="cv-page-header">
				<h1 class="cv-page-title">${team.teamName}</h1>
				<p class="cv-page-subtitle">Hackathon: ${team.hackathon.title}</p>
			</div>

			<div class="row g-4">

				<!-- LEFT SIDE -->
				<div class="col-lg-4 col-12">

					<!-- TEAM LEADER -->
					<div class="cv-card">
						<div class="cv-card__header">
							<i class="bi bi-person-badge"></i>
							<h2>Team Leader</h2>
						</div>

						<div class="cv-card__body">${team.teamLeader.firstName}
							${team.teamLeader.lastName}</div>
					</div>


					<!-- JOIN REQUEST -->
					<div class="cv-card mt-4">
						<div class="cv-card__header">
							<i class="bi bi-person-plus"></i>
							<h2>Join Requests</h2>
						</div>

						<div class="cv-card__body">

							<c:if
								test="${team.teamLeader.userId == sessionScope.user.userId}">

								<c:choose>

									<c:when test="${empty requests}">
										<div class="cv-empty">No requests pending</div>
									</c:when>

									<c:otherwise>

										<c:forEach var="r" items="${requests}">

											<div class="cv-card mb-2 p-2">

												<div>
													${r.member.firstName} ${r.member.lastName} <br /> <small
														style="color: gray"> ${r.member.email} </small>
												</div>

												<div class="mt-2">

													<form action="/team/acceptRequest" method="post"
														style="display: inline;">

														<input type="hidden" name="teamId"
															value="${team.hackathonTeamId}" /> <input type="hidden"
															name="memberId" value="${r.member.userId}" />

														<button class="btn-cv btn-cv--primary btn-cv--sm">
															Accept</button>

													</form>


													<form action="/team/rejectRequest" method="post"
														style="display: inline;">

														<input type="hidden" name="teamId"
															value="${team.hackathonTeamId}" /> <input type="hidden"
															name="memberId" value="${r.member.userId}" />

														<button class="btn-cv btn-cv--danger btn-cv--sm">
															Reject</button>

													</form>

												</div>

											</div>

										</c:forEach>

									</c:otherwise>

								</c:choose>

							</c:if>

						</div>
					</div>

				</div>



				<!-- RIGHT SIDE -->
				<div class="col-lg-8 col-12">

					<!-- TEAM MEMBERS -->
					<div class="cv-card">

						<div class="cv-card__header">
							<i class="bi bi-people"></i>
							<h2>Team Members</h2>
						</div>

						<div class="cv-card__body">

							<c:forEach var="m" items="${members}">

								<c:if test="${m.status == 'ACCEPTED'}">

									<div
										class="cv-card mb-2 p-3 d-flex justify-content-between align-items-center">

										<div>
											${m.member.firstName} ${m.member.lastName} <br /> <small
												style="color: gray;"> ${m.member.email} </small> <br /> <span
												class="cv-badge"> ${m.roleTitle} </span>
										</div>


										<!-- REMOVE BUTTON -->
										<c:if
											test="${team.teamLeader.userId == sessionScope.user.userId 
											and m.member.userId ne team.teamLeader.userId}">

											<form action="/team/removeMember" method="post">

												<input type="hidden" name="teamId"
													value="${team.hackathonTeamId}" /> <input type="hidden"
													name="memberId" value="${m.member.userId}" />

												<button class="btn-cv btn-cv--danger btn-cv--sm">
													Remove</button>

											</form>

										</c:if>

									</div>

								</c:if>

							</c:forEach>


							<c:if test="${empty members}">
								<div class="cv-empty">No members yet</div>
							</c:if>


							<!-- TEAM ACTIONS -->
							<div class="mt-4">

								<c:if
									test="${team.teamLeader.userId != sessionScope.user.userId}">

									<form action="/team/leave" method="post">
										<input type="hidden" name="teamId"
											value="${team.hackathonTeamId}" />

										<button class="btn-cv btn-cv--danger">Leave Team</button>
									</form>

								</c:if>


								<c:if
									test="${team.teamLeader.userId == sessionScope.user.userId}">

									<form action="/team/delete" method="post">
										<input type="hidden" name="teamId"
											value="${team.hackathonTeamId}" />

										<button class="btn-cv btn-cv--danger">Delete Team</button>
									</form>

								</c:if>

							</div>


						</div>
					</div>

				</div>

			</div>

		</main>

	</div>

	<%@ include file="../components/Footer.jsp"%>
	<%@ include file="../components/Scripts.jsp"%>

</body>
</html>