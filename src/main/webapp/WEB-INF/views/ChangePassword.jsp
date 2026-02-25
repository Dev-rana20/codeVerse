<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>CodeVerse</title>
<!-- plugins:css -->
<jsp:include page="AdminCSS.jsp"></jsp:include>
</head>

<body>
	<div class="container-scroller">
		<div class="container-fluid page-body-wrapper full-page-wrapper">
			<div class="content-wrapper d-flex align-items-center auth px-0">
				<div class="row w-100 mx-0">
					<div class="col-lg-4 mx-auto">
						<div class="auth-form-light text-left py-5 px-4 px-sm-5">
							<div class="brand-logo text-center mb-4">
								<img alt="BrandLogo" src="/assets/images/logo.png"
									style="width: 300px; height: auto;">
							</div>
							<form action="updatePassword" method="post">
								<input type="hidden" name="email" value="${email}">

								<div class="mb-3">
									<label>New Password</label> <input type="password"
										name="Password" class="form-control" required>
								</div>

								<div class="mb-3">
									<label>Confirm Password</label> <input type="password"
										name="confirmPassword" class="form-control" required>
								</div>
								<c:if test="${not empty error}">
									<div class="alert alert-danger">${error}</div>
								</c:if>

								<button type="submit" class="btn btn-primary w-100">
									Update Password</button>

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