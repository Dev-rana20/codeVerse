<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- Page Identity --%>
<c:set var="pageTitle" value="Judge Management" scope="request" />
<c:set var="activePage" value="assignJudge" scope="request" />

<!DOCTYPE html>
<html lang="en" data-page="judges">

<head>
<%@ include file="/WEB-INF/views/components/Head.jsp"%>
</head>

<body data-page="judges">

	<%@ include file="/WEB-INF/views/components/navbar.jsp"%>

	<div class="cv-shell">

		<%@ include file="/WEB-INF/views/components/SidebarAdmin.jsp"%>

		<main class="cv-content">

			<!-- Page Header -->
			<div class="cv-page-header mb-4">
				<div>
					<div class="cv-page-eyebrow">
						<i class="bi bi-person-badge"></i> Judges
					</div>
					<h1 class="cv-page-title">Judge Management</h1>
				</div>

				<a href="/admin/invite-judge" class="btn-cv btn-cv-primary"> <i
					class="bi bi-person-plus"></i> Invite Judge
				</a>
			</div>

			<!-- Judges Table -->
			<div class="cv-card">

				<div class="cv-card__header">
					<i class="bi bi-people"></i>
					<h3>All Judges</h3>
				</div>

				<div class="cv-card__body">

					<div class="table-responsive">
						<table class="cv-table">

							<thead>
								<tr>
									<th>#</th>
									<th>Judge</th>
									<th>Assigned Hackathons</th>
									<th>Assign New</th>
								</tr>
							</thead>

							<tbody>

								<c:choose>

									<c:when test="${empty judges}">
										<tr>
											<td colspan="4" class="text-center text-muted">No judges
												found</td>
										</tr>
									</c:when>

									<c:otherwise>

										<c:forEach items="${judges}" var="j" varStatus="i">

											<tr>

												<!-- Index -->
												<td>${i.count}</td>

												<!-- Judge -->
												<td>
													<div>
														<b>${j.email}</b>
													</div>
												</td>

												<!-- Assigned Hackathons -->
												<td><c:forEach items="${assignments}" var="a">

														<c:if test="${a.user.userId eq j.userId}">
															<div class="mb-1">

																<span
																	class="cv-badge 
																	${a.status == 'ASSIGNED' ? 'bg-primary' :
																	  a.status == 'IN_PROGRESS' ? 'bg-warning text-dark' :
																	  'bg-success'}">

																	${a.hackathon.title} (${a.status}) 
																	<a href="/admin/remove-judge?assignmentId=${a.hackathonJudgeId}" class="text-white ms-2" title="Remove Assignment" onclick="return confirm('Remove judge from this hackathon?');">
																		<i class="bi bi-x-circle-fill"></i>
																	</a>
																</span>

															</div>
														</c:if>

													</c:forEach></td>

												<!-- Assign New -->
												<td>

													<form action="/admin/assign-judge" method="post"
														class="d-flex gap-2">

														<input type="hidden" name="judgeId" value="${j.userId}" />

														<select name="hackathonId" class="cv-select" required>
															<option value="">Select Hackathon</option>
															<c:forEach items="${hackathons}" var="h">
																<%-- Check if judge is already assigned to this hackathon --%>
																<c:set var="isAssigned" value="false" />
																<c:forEach items="${assignments}" var="a">
																	<c:if test="${a.hackathon.hackathonId == h.hackathonId}">
																		<c:set var="isAssigned" value="true" />
																	</c:if>
																</c:forEach>
																
																<c:if test="${not isAssigned}">
																	<option value="${h.hackathonId}">${h.title}</option>
																</c:if>
															</c:forEach>
														</select>

														<button type="submit" class="btn-cv btn-cv-primary">
															Assign</button>

													</form>

												</td>

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

	<%@ include file="/WEB-INF/views/components/Footer.jsp"%>
	<%@ include file="/WEB-INF/views/components/Scripts.jsp"%>

</body>
</html>