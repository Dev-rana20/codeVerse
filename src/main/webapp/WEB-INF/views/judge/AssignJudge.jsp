<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>CodeVerse</title>
<!-- plugins:css -->

<jsp:include page="../AdminCSS.jsp"></jsp:include>

<style>
.ASSIGNED {
	background: #007bff; /* blue */
	color: white;
}

.IN_PROGRESS {
	background: #ffc107; /* yellow */
	color: black;
}

.COMPLETED {
	background: #28a745; /* green */
	color: white;
}

.badge {
	padding: 5px 10px;
	border-radius: 5px;
	font-size: 12px;
	display: inline-block;
	margin-bottom: 4px;
	max-width: 250px;
	overflow: hidden;
	text-overflow: ellipsis;
}

.FREE {
	background: #28a745;
}

.PAID {
	background: #dc3545;
}

.btn.btn-add {
	background: #28a745;
}

.btn.btn-edit {
	background: #ffc107;
	color: black;
}

.btn.btn-delete {
	background: #dc3545;
}

.btn.btn-view {
	background: #007bff;
}
</style>

</head>
<body>
	<div class="container-scroller">
		<!-- partial:partials/_navbar.html -->
		<jsp:include page="../AdminHeader.jsp"></jsp:include>
		<!-- partial -->
		<div class="container-fluid page-body-wrapper">
			<!-- partial:partials/_sidebar.html -->
			<jsp:include page="../AdminLeftSidebar.jsp"></jsp:include>
			<!-- partial -->
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="row">
						<div class="col-md-12 grid-margin">
							<div class="row">
								<div class="col-12 col-xl-8 mb-4 mb-xl-0">
									<h3 class="font-weight-bold">Judge</h3>

								</div>

							</div>
						</div>
					</div>


					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="card-body">
									<div class="d-flex justify-content-between">
										<p class="card-title">All judges</p>
										<a href="/judge/inviteJudge" class="text-info">invite</a>
									</div>
									<div class="table-responsive">
										<table class="table table-bordered table-hover">
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
															<td colspan="4">No judges found</td>
														</tr>
													</c:when>

													<c:otherwise>
														<c:forEach items="${judges}" var="j" varStatus="i">
															<tr>

																<!-- Index -->
																<td>${i.count}</td>

																<!-- Judge Info -->
																<td>${j.email}</td>

																<!-- Assigned Hackathons -->
																<td><c:forEach items="${assignments}" var="a">
																		<c:if test="${a.user.userId eq j.userId}">
																			<div class="mb-1">
																				<span class="badge ${a.status}">
																					${a.hackathon.title} (${a.status}) </span>
																			</div>
																		</c:if>
																	</c:forEach></td>

																<!-- Assign New Hackathon -->
																<td>
																	<form action="/admin/assign-judge" method="post"
																		class="d-flex gap-2">

																		<input type="hidden" name="judgeId"
																			value="${j.userId}" /> <select name="hackathonId"
																			class="form-control" required>
																			<option value="">Select Hackathon</option>

																			<c:forEach items="${hackathons}" var="h">
																				<option value="${h.hackathonId}">
																					${h.title}</option>
																			</c:forEach>
																		</select>

																		<button type="submit" class="btn btn-add">
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
						</div>
					</div>


				</div>
				<!-- content-wrapper ends -->
				<!-- partial:partials/_footer.html -->

				<jsp:include page="../AdminFooter.jsp"></jsp:include>
				<!-- partial -->
			</div>
			<!-- main-panel ends -->
		</div>
		<!-- page-body-wrapper ends -->
	</div>
	<!-- container-scroller -->
	<!-- plugins:js -->




	<!-- End custom js for this page-->
</body>
</html>