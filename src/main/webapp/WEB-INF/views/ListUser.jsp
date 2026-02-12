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

  .btn-add { background: #28a745; }
        .btn-edit { background: #ffc107; color: black; }
        .btn-delete { background: #dc3545; }
        .btn-view { background: #007bff; }
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
									<h3 class="font-weight-bold">List Hackathon</h3>

								</div>

							</div>
						</div>
					</div>


					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="card-body">
									<div class="d-flex justify-content-between">
										<p class="card-title">All Hackathon</p>
										<a href="newHackathon" class="text-info">New</a>
									</div>
									<div class="table-responsive">
										<table class="table table-bordered table-hover table-striped">
			<thead class="table-dark">
				<tr>
					<th>SrNo</th>
					<th>Name</th>
					<th>Email</th>
					<th>Role</th>
					<th>Gender</th>
					<th>Birth Year</th>
					<th>Profile</th>
					<th>Status</th>
					<th >Action</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach var="user" items="${userList}" varStatus="s">
					<tr>

						<td>${s.count}</td>

						<td>${user.firstName}${user.lastName}</td>
						<td>${user.email}</td>
						<td><span class="badge bg-info text-dark">${user.role}</span>
						</td>
						<td>${user.gender}</td>
						<td>${user.birthYear}</td>
						<td class="text-center"><c:if
								test="${not empty user.profilePicURL}">
								<img src="${user.profilePicURL}" class="profile-pic" />
							</c:if></td>


						<td><c:choose>
								<c:when test="${user.active}">
									<span class="badge bg-success">Active</span>
								</c:when>
								<c:otherwise>
									<span class="badge bg-danger">Inactive</span>
								</c:otherwise>
							</c:choose></td>

						<td><a href="editUser?userId=${user.userId}"
							class="btn btn-sm btn-warning">Edit</a> <a
							href="deleteUser?userId=${user.userId}"
							class="btn btn-sm btn-danger"
							onclick="return confirm('Are you sure?');"> Delete </a>
							
							<a class="btn btn-secondary" href="viewUser?userId=${user.userId}">View</a>
							
							</td>
					</tr>
				</c:forEach>

				<c:if test="${empty userList}">
					<tr>
						<td colspan="11" class="text-center text-muted">No users
							found</td>
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