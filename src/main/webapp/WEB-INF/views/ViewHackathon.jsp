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
						<div class="col-md-12 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">

									<div class="view-card">

										<div
											class="d-flex justify-content-between align-items-center mb-4">
											<h3>${hackathon.title}</h3>
											
										</div>

										<div class="row mb-3">
											<div class="col-md-6">
												<p>
													<span class="label">Hackathon ID:</span>
													${hackathon.hackathonId}
												</p>
											</div>
											<div class="col-md-6">
												<p>
													<span class="label">Title:</span> ${hackathon.title}
												</p>
											</div>
										</div>

										<div class="row mb-3">
											<div class="col-md-6">
												<p>
													<span class="label">Status:</span> ${hackathon.status}
												</p>
											</div>
											<div class="col-md-6">
												<p>
													<span class="label">Event Type:</span>
													${hackathon.eventType}
												</p>
											</div>
										</div>

										<div class="row mb-3">
											<div class="col-md-6">
												<p>
													<span class="label">Payment:</span> ${hackathon.payment}
												</p>
											</div>
											<div class="col-md-6">
												<p>
													<span class="label">Team Size:</span>
													${hackathon.minTeamSize} - ${hackathon.maxTeamSize}
												</p>
											</div>
										</div>

										<div class="row mb-3">
											<div class="col-md-6">
												<p>
													<span class="label">Location:</span> ${hackathon.location}
												</p>
											</div>
											<div class="col-md-6">
												<p>
													<span class="label">User Type ID:</span>
													${hackathon.userTypeId}
												</p>
											</div>
										</div>

										<div class="row mb-3">
											<div class="col-md-6">
												<p>
													<span class="label">Registration Start Date:</span>
													${hackathon.registrationStartDate}
												</p>
											</div>
											<div class="col-md-6">
												<p>
													<span class="label">Registration End Date:</span>
													${hackathon.registrationEndDate}
												</p>
											</div>
										</div>

										<div class="text-end mt-4">
										<a href="listHackathon" class="btn btn-secondary">Back</a>
											<a href="editHackathon?id=${hackathon.hackathonId}"
												class="btn btn-warning">Edit</a>
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