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
<title>Skydash Admin</title>
<!-- plugins:css -->

<jsp:include page="AdminCSS.jsp"></jsp:include>

<style>
.UPCOMING {
	background: #17a2b8;
}

.ONGOING {
	background: #28a745;
}

.COMPLETED {
	background: #6c757d;
}

.FREE {
	background: #28a745;
}

.PAID {
	background: #dc3545;
}

.btn-add {
	background: #28a745;
}

.btn-edit {
	background: #ffc107;
	color: black;
}

.btn-delete {
	background: #dc3545;
}

.btn-view {
	background: #007bff;
}
</style>

</head>
<body>
	<div class="container-scroller">
		<!-- partial:partials/_navbar.html -->
		<jsp:include page="AdminHeader.jsp"></jsp:include>
		<!-- partial -->
		<div class="container-fluid page-body-wrapper">
			<!-- partial:partials/_sidebar.html -->
			<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>
			<!-- partial -->
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="row">
						<div class="col-md-12 grid-margin">
							<div class="row">
								<div class="col-12 col-xl-8 mb-4 mb-xl-0">
									<h3 class="font-weight-bold">List User</h3>

								</div>

							</div>
						</div>
					</div>


					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="card-body">
									<div class="d-flex justify-content-between">
										<p class="card-title">All Users</p>
										<a href="newHackathon" class="text-info">New</a>
									</div>
									<div class="table-responsive">
										<table class="table table-bordered table-striped text-center">
											<thead class="table-dark">
												<tr>
													<th>User Type ID</th>
													<th>User Type</th>
													<th>Action</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${userTypeList}" var="u">
													<tr>
														<td>${u.userTypeId}</td>
														<td>${u.userType}</td>
														<td><a href="editUserType?id=${u.userTypeId}"
															class="btn btn-warning btn-sm">Edit</a> <a
															href="deleteUserType?id=${u.userTypeId}"
															class="btn btn-danger btn-sm"
															onclick="return confirm('Are you sure you want to delete?')">
																Delete </a></td>
													</tr>
												</c:forEach>

												<c:if test="${empty userTypeList}">
													<tr>
														<td colspan="3">No User Types Found</td>
													</tr>
												</c:if>

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

				<jsp:include page="AdminFooter.jsp"></jsp:include>
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