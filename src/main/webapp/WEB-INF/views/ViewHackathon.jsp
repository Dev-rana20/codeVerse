<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">

<!DOCTYPE html>
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

						<!-- Hackathon Details Card -->
						<div class="col-md-12 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">

									<h3 class="mb-4">${hackathon.title}</h3>

									<div class="row mb-3">
										<div class="col-md-6">
											<p>
												<b>Hackathon ID:</b> ${hackathon.hackathonId}
											</p>
										</div>
										<div class="col-md-6">
											<p>
												<b>Title:</b> ${hackathon.title}
											</p>
										</div>
									</div>

									<div class="row mb-3">
										<div class="col-md-6">
											<p>
												<b>Status:</b> ${hackathon.status}
											</p>
										</div>
										<div class="col-md-6">
											<p>
												<b>Event Type:</b> ${hackathon.eventType}
											</p>
										</div>
									</div>

									<div class="row mb-3">
										<div class="col-md-6">
											<p>
												<b>Payment:</b> ${hackathon.payment}
											</p>
										</div>
										<div class="col-md-6">
											<p>
												<b>Team Size:</b> ${hackathon.minTeamSize} -
												${hackathon.maxTeamSize}
											</p>
										</div>
									</div>

									<div class="row mb-3">
										<div class="col-md-6">
											<p>
												<b>Location:</b> ${hackathon.location}
											</p>
										</div>
										<div class="col-md-6">
											<p>
												<b>User Type ID:</b> ${hackathon.userTypeId}
											</p>
										</div>
									</div>

									<div class="row mb-3">
										<div class="col-md-6">
											<p>
												<b>Registration Start Date:</b>
												${hackathon.registrationStartDate}
											</p>
										</div>
										<div class="col-md-6">
											<p>
												<b>Registration End Date:</b>
												${hackathon.registrationEndDate}
											</p>
										</div>
									</div>

									<div class="text-end mt-4">
										<a href="listHackathon" class="btn btn-secondary">Back</a> <a
											href="editHackathon?id=${hackathon.hackathonId}"
											class="btn btn-warning">Edit</a>
									</div>

								</div>
							</div>
						</div>


						<!-- Hackathon Poster Card -->
						<c:if test="${hackathonDescriptionEntity !=null}">
							<div class="col-md-12 grid-margin stretch-card mt-3">
								<div class="card">
									<div class="card-body">

										<h4 class="mb-4 text-center">Hackathon Details</h4>

										<div class="row">

											<!-- Poster -->
											

												<div class="row mb-4">

													<!-- Poster -->
													<div class="col-md-5 text-center">
														<c:if test="${not empty descList.hackathonDetailsURL}">
															<img src="${descList.hackathonDetailsURL}"
																class="img-fluid rounded shadow"
																style="max-width: 100%;">
														</c:if>
													</div>

													<!-- Description -->
													<div class="col-md-7">
														<c:if test="${not empty descList.hackathonDetailsText}">
															<h5>Description</h5>
															<p style="text-align: justify;">
																${descList.hackathonDetailsText}</p>
														</c:if>
													</div>

												</div>

								


										</div>

									</div>
								</div>
							</div>
						</c:if>


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