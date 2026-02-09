<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>User List</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>
.profile-pic {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	object-fit: cover;
}
</style>
<jsp:include page="AdminCSS.jsp"></jsp:include>

</head>

<body>

	<!-- header -->
	<jsp:include page="AdminHeader.jsp"></jsp:include>


	<!-- Sidebar -->
	<jsp:include page="AdminSidebar.jsp"></jsp:include>



	<div class="content">

		<div class="d-flex justify-content-between align-items-center mb-3">
			<h3>User List</h3>
			<a href="new-user.jsp" class="btn btn-primary">+ Add User</a>
		</div>

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
</body>
</html>