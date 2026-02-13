<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Skydash Admin</title>
<!-- plugins:css -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet"
	href="<c:url value='/assets/vendors/feather/feather.css'/>">
<link rel="stylesheet"
	href="<c:url value='/assets/vendors/ti-icons/css/themify-icons.css'/>">
<link rel="stylesheet"
	href="<c:url value='/assets/vendors/css/vendor.bundle.base.css'/>">
<link rel="stylesheet" href="<c:url value='/assets/css/style.css'/>">
<link rel="shortcut icon"
	href="<c:url value='/assets/images/favicon.png'/>">

</head>

<body>
	<div class="container-scroller">
		<div class="container-fluid page-body-wrapper full-page-wrapper">
			<div class="content-wrapper d-flex align-items-center auth px-0">
				<div class="row w-100 mx-0">
					<div class="col-lg-4 mx-auto">
						<div class="auth-form-light text-left py-5 px-4 px-sm-5">
							<div class="brand-logo text-center mb-4">
								<img alt="BrandLogo" src="/assets/images/logo.png" style="width:300px; height:auto;">
							</div>
							<form action="LoginServlet" method="post">

								<!-- Email -->
								<div class="mb-3">
									<label class="form-label">Email Address</label> <input
										type="email" class="form-control" name="email"
										placeholder="Enter email" required>
								</div>

								<!-- Password -->
								<div class="mb-3">
									<label class="form-label">Password</label> <input
										type="password" class="form-control" name="password"
										placeholder="Enter password" required>
								</div>

								<!-- Submit Button -->
								<div class="d-grid">
									<button type="submit" class="btn btn-primary">Login</button>
								</div>

								<!-- Signup link -->
								<p class="text-center mt-3">
									Don’t have an account? <a href="signup">Sign Up</a>
								</p>

								<!-- Forget password  -->
								<p class="text-center mt-3">
									Forget Password? <a href="forgetPassword">Click Here</a>
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
	<!-- container-scroller -->
	<!-- plugins:js -->
	<script src="<c:url value='/assets/vendors/js/vendor.bundle.base.js'/>"></script>
	<script src="<c:url value='/assets/js/off-canvas.js'/>"></script>
	
	<script src="<c:url value='/assets/js/template.js'/>"></script>
	<script src="<c:url value='/assets/js/settings.js'/>"></script>
	<script src="<c:url value='/assets/js/todolist.js'/>"></script>




</body>
</html>