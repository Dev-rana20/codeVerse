<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>CodeVerse</title>
<style type="text/css">
select:valid {
    color: black !important;
}
</style>
<jsp:include page="AdminCSS.jsp"></jsp:include>

</head>
<body>
	<div class="container-scroller">
		<div class="container-fluid page-body-wrapper full-page-wrapper">
			<div class="content-wrapper d-flex align-items-center auth px-0">
				<div class="row w-100 mx-0">
					<div class="col-lg-7 mx-auto">
						<div class="auth-form-light text-left py-5 px-4 px-sm-5">

							<div class="brand-logo text-center mb-4">
								<img alt="BrandLogo" src="/assets/images/logo.png"
									style="width: 300px; height: auto;">
							</div>

							<h3>Sign Up</h3>
							<br>
							<form action="register" method="post">

								<!-- First Name -->
								<div class="mb-3">
									<label class="form-label">First Name</label> <input type="text"
										name="firstName" class="form-control" required>
								</div>

								<!-- Last Name -->
								<div class="mb-3">
									<label class="form-label">Last Name</label> <input type="text"
										name="lastName" class="form-control" required>
								</div>

								<!-- Email -->
								<div class="mb-3">
									<label class="form-label">Email</label> <input type="email"
										name="email" class="form-control" required>
								</div>

								<!-- Password -->
								<div class="mb-3">
									<label class="form-label">Password</label> <input
										type="password" name="password" class="form-control" required>
								</div>

								<!-- Gender -->
								<div class="gender-section">
									<label class="gender-label">Gender</label>

									<div class="gender-options">
										<label class="gender-option"> <input type="radio"
											name="gender" value="MALE" required> <span>Male</span>
										</label> <label class="gender-option"> <input type="radio"
											name="gender" value="FEMALE"> <span>Female</span>
										</label> <label class="gender-option"> <input type="radio"
											name="gender" value="OTHER"> <span>Other</span>
										</label>
									</div>
								</div>


								<!-- Birth Year -->
								<div class="mb-3">
									<label class="form-label">Birth Year</label> <input
										type="number" name="birthYear" class="form-control" min="1900"
										max="2100" required>
								</div>

								<!-- Contact Number -->
								<div class="mb-3">
									<label class="form-label">Contact Number</label> <input
										type="text" name="contactNum" class="form-control" required>
								</div>


								<!-- Qualification -->
								<div class="mb-3">
									<label class="form-label">Qualification</label> <input
										type="text" name="qualification" class="form-control"
										placeholder="e.g. B.Tech, MCA, BSc" required>
								</div>

								<div class="mb-3">
									<label class="form-label">User Type</label> 
									<select name="userTypeId" class="form-select">
										<option value="-1" disabled selected>---Select User Type---</option>

										<c:forEach items="${allUserType}" var="ut">
											<option value="${ut.userTypeId}">${ut.userType}</option>
										</c:forEach>


									</select>
								</div>

								<!-- City -->
								<div class="mb-3">
									<label class="form-label">City</label> <input type="text"
										name="city" class="form-control" placeholder="Enter city"
										required>
								</div>

								<!-- State -->
								<div class="mb-3">
									<label class="form-label">State</label> <input type="text"
										name="state" class="form-control" placeholder="Enter state"
										required>
								</div>

								<!-- Country -->
								<div class="mb-3">
									<label class="form-label">Country</label> <input type="text"
										name="country" class="form-control"
										placeholder="Enter country" value="India" required>
								</div>


								<!-- Profile Pic URL -->
								<div class="mb-3">
									<label class="form-label">Profile Picture URL</label> <input
										type="file" name="profilePicURL" class="form-control">
								</div>


								<!-- Submit -->
								<div class="d-grid">
									<button type="submit" class="btn btn-primary">Save
										User</button>
								</div>
								<!-- Login link -->
								<p class="text-center mt-3">
									Already have an account? <a href="login">Login</a>
								</p>

							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- content-wrapper ends -->
		</div>
		<!-- page-body-wrapper ends -->
	</div>
	<script src="<c:url value='/assets/vendors/js/vendor.bundle.base.js'/>"></script>

	<script src="<c:url value='/assets/js/off-canvas.js'/>"></script>
	<script src="<c:url value='/assets/js/template.js'/>"></script>
	<script src="<c:url value='/assets/js/settings.js'/>"></script>
	<script src="<c:url value='/assets/js/todolist.js'/>"></script>


</body>
</html>