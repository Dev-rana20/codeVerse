
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
						<div class="col-md-12 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">

									<div class="card shadow">
										<div class="card-header bg-dark text-white">
											<h4 class="mb-0">User Details</h4>
										</div>

										<div class="card-body">
											<div class="row">

												<!-- Profile Picture -->
												<div class="col-md-3 text-center">
													<c:choose>
														<c:when test="${not empty user.profilePicURL}">
															<img src="${user.profilePicURL}" class="profile-pic">
														</c:when>
														<c:otherwise>
															<img src="https://via.placeholder.com/120"
																class="profile-pic">
														</c:otherwise>
													</c:choose>

													<div class="mt-2">
														<span class="badge bg-info text-dark"> ${user.role}
														</span>
													</div>
												</div>

												<!-- User Info -->
												<div class="col-md-9">
													<table class="table table-borderless">
														<tr>
															<td class="label">User ID</td>
															<td>${user.userId}</td>
														</tr>
														<tr>
															<td class="label">Full Name</td>
															<td>${user.firstName}${user.lastName}</td>
														</tr>
														<tr>
															<td class="label">Email</td>
															<td>${user.email}</td>
														</tr>
														<tr>
															<td class="label">Gender</td>
															<td>${user.gender}</td>
														</tr>
														<tr>
															<td class="label">Birth Year</td>
															<td>${user.birthYear}</td>
														</tr>
														<tr>
															<td class="label">Contact Number</td>
															<td>${user.contactNum}</td>
														</tr>
														<tr>
															<td class="label">Created At</td>
															<td>${user.createdAt}</td>
														</tr>
														<tr>
															<td class="label">Status</td>
															<td><c:choose>
																	<c:when test="${user.active}">
																		<span class="badge bg-success">Active</span>
																	</c:when>
																	<c:otherwise>
																		<span class="badge bg-danger">Inactive</span>
																	</c:otherwise>
																</c:choose></td>
														</tr>

														<tr>
															<td class="label">Country</td>
															<td>${userDetail.country}</td>
														</tr>
														<tr>
															<td class="label">State</td>
															<td>${userDetail.state}</td>
														</tr>
														<tr>
															<td class="label">City</td>
															<td>${userDetail.city}</td>
														</tr>


													</table>
												</div>

											</div>
										</div>

										<div class="card-footer text-end">
											<a href="listUser" class="btn btn-secondary">Back</a> <a
												href="editUser?userId=${user.userId}"
												class="btn btn-warning">Edit</a>
										</div>
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
</body>
</html>