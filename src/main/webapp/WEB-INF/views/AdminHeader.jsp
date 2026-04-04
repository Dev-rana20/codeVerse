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

<nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
	<div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-start">

    <!-- Full Logo -->
    <a class="navbar-brand brand-logo" href="admin-dashboard">
        <img src="/assets/images/logo.png" alt="BrandLogo" style="width:200px;height:70px;">
    </a>

    <!-- Mini Logo -->
    <a class="navbar-brand brand-logo-mini" href="admin-dashboard">
        <img src="/assets/images/logo-mini.png" alt="logo-mini" style="width:50px;height:40px;">
    </a>

</div>
	<div
		class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
		<button class="navbar-toggler navbar-toggler align-self-center"
			type="button" data-toggle="minimize">
			<span class="icon-menu"></span>
		</button>
	<!-- 	<ul class="navbar-nav mr-lg-2">
			<li class="nav-item nav-search d-none d-lg-block">
				<div class="input-group">
					<div class="input-group-prepend hover-cursor"
						id="navbar-search-icon">
						<span class="input-group-text" id="search"> <i
							class="icon-search"></i>
						</span>
					</div>
					<input type="text" class="form-control" id="navbar-search-input"
						placeholder="Search now" aria-label="search"
						aria-describedby="search">
				</div>
			</li>
		</ul>
		 -->
		<ul class="navbar-nav navbar-nav-right">
			
		
			<li class="nav-item nav-profile dropdown"><a
				class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown"
				id="profileDropdown"> 
				<c:if test="${not empty sessionScope.user.profilePicURL}">
				<img src="${sessionScope.user.profilePicURL}" alt="profile" />
				</c:if>
				<c:if test="${empty sessionScope.user.profilePicURL}">
				<img src="assets/images/faces/dummy.jpg"
					alt="profile" />
				</c:if>
				
			</a>
				<div class="dropdown-menu dropdown-menu-right navbar-dropdown"
					aria-labelledby="profileDropdown">
					<a class="dropdown-item" href="viewUser?userId=${sessionScope.user.userId}"> <i class="ti-settings text-primary"></i>
						Settings
					</a> <a class="dropdown-item" href="logout"> <i class="ti-power-off text-primary"></i>
						Logout
					</a>
				</div></li>
			<!-- <li class="nav-item nav-settings d-none d-lg-flex"><a
				class="nav-link" href="#"> <i class="icon-ellipsis"></i>
			</a></li> -->
		</ul>
		<button
			class="navbar-toggler navbar-toggler-right d-lg-none align-self-center"
			type="button" data-toggle="offcanvas">
			<span class="icon-menu"></span>
		</button>
	</div>
</nav>
</body>
</html>