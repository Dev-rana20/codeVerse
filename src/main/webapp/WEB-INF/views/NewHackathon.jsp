<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- ── Page Identity ── --%>
<c:set var="pageTitle" value="New Hackathon" scope="request" />
<c:set var="activePage" value="newHackathon" scope="request" />

<!DOCTYPE html>
<html lang="en" data-page="newHackathon">

<head>
<%@ include file="/WEB-INF/views/components/Head.jsp"%>
</head>

<body data-page="newHackathon">

	<%-- Navbar --%>
	<%@ include file="/WEB-INF/views/components/navbar.jsp"%>

	<div class="cv-shell">

		<%-- Sidebar --%>
		<%@ include file="/WEB-INF/views/components/SidebarAdmin.jsp"%>

		<main class="cv-content">

			<!-- Page Header -->
			<div class="cv-page-header mb-4">
				<div>
					<div class="cv-page-eyebrow">
						<i class="bi bi-lightning-charge"></i> Hackathons
					</div>
					<h1 class="cv-page-title">New Hackathon</h1>
				</div>

				<a href="listHackathon" class="btn-cv btn-cv-ghost"> <i
					class="bi bi-list-ul"></i> View All
				</a>
			</div>

			<!-- Form Card -->
			<div class="row">
				<div class="col-md-8 mx-auto">

					<div class="cv-card">

						<div class="cv-card__header">
							<i class="bi bi-plus-circle"></i>
							<h3>Add New Hackathon</h3>
						</div>

						<div class="cv-card__body">

							<form action="saveHackathon" method="post">
							

								<!-- Title -->
								<div class="cv-form-group">
									<label class="cv-label">Hackathon Title</label> <input
										type="text" name="title" class="cv-input" required />
								</div>

								<!-- Status -->
								<div class="cv-form-group">
									<label class="cv-label">Status</label> <select name="status"
										class="cv-select" required>
										<option value="">-- Select Status --</option>
										<option value="UPCOMING">Upcoming</option>
										<option value="ONGOING">Ongoing</option>
										<option value="COMPLETED">Completed</option>
									</select>
								</div>

								<!-- Event Type -->
								<div class="cv-form-group">
									<label class="cv-label">Event Type</label> <select
										name="eventType" class="cv-select" required>
										<option value="">-- Select Event Type --</option>
										<option value="ONLINE">Online</option>
										<option value="OFFLINE">Offline</option>
										<option value="HYBRID">Hybrid</option>
									</select>
								</div>

								<!-- Payment -->
								<div class="cv-form-group">
									<label class="cv-label">Payment</label> <select name="payment"
										id="paymentSelect" class="cv-select" required>
										<option value="">-- Select Payment Type --</option>
										<option value="FREE">Free</option>
										<option value="PAID">Paid</option>
									</select>
								</div>

								<!-- Entry Fee -->
								<div class="cv-form-group" id="feeGroup" style="display: none;">
									<label class="cv-label">Entry Fee</label> <input type="number"
										name="fee" id="feeInput" class="cv-input" min="0" placeholder="Enter entry fee" />
								</div>

								<!-- Team Size -->
								<div class="row">
									<div class="col-md-6">
										<div class="cv-form-group">
											<label class="cv-label">Min Team Size</label> <input
												type="number" name="minTeamSize" class="cv-input" min="1"
												required />
										</div>
									</div>

									<div class="col-md-6">
										<div class="cv-form-group">
											<label class="cv-label">Max Team Size</label> <input
												type="number" name="maxTeamSize" class="cv-input" min="1"
												required />
										</div>
									</div>
								</div>

								<!-- Location -->
								<div class="cv-form-group">
									<label class="cv-label">Location</label> <input type="text"
										name="location" class="cv-input" />
								</div>

								<!-- User Type -->
								<div class="cv-form-group">
									<label class="cv-label">User Type</label> <select
										name="userTypeId" class="cv-select" required>
										<option value="">-- Select User Type --</option>
										<c:forEach items="${allUserType}" var="u">
											<option value="${u.userTypeId}">${u.userType}</option>
										</c:forEach>
									</select>
								</div>

								<!-- Registration Dates -->
								<div class="row">
									<div class="col-md-6">
										<div class="cv-form-group">
											<label class="cv-label">Registration Start</label> <input
												type="date" name="registrationStartDate" id="regStartDate" class="cv-input"
												required />
										</div>
									</div>

									<div class="col-md-6">
										<div class="cv-form-group">
											<label class="cv-label">Registration End</label> <input
												type="date" name="registrationEndDate" id="regEndDate" class="cv-input"
												required />
										</div>
									</div>
								</div>

								<!-- Event Dates -->
								<div class="row">
									<div class="col-md-6">
										<div class="cv-form-group">
											<label class="cv-label">Event Start Date</label>
											<input type="date" name="eventStartDate" id="eventStartDate" class="cv-input" />
										</div>
									</div>
									<div class="col-md-6">
										<div class="cv-form-group">
											<label class="cv-label">Event End Date</label>
											<input type="date" name="eventEndDate" id="eventEndDate" class="cv-input" />
										</div>
									</div>
								</div>

								<!-- Submission Deadline -->
								<div class="cv-form-group">
									<label class="cv-label">Submission Deadline</label>
									<input type="date" name="submissionDeadline" id="submissionDeadline" class="cv-input" />
									<small class="cv-hint">Teams cannot submit work after this date.</small>
								</div>

								<!-- Prize Descriptions -->
								<div class="row">
									<div class="col-md-4">
										<div class="cv-form-group">
											<label class="cv-label">1st Prize</label>
											<input type="text" name="firstPrize" class="cv-input" placeholder="e.g. $10,000" required />
										</div>
									</div>
									<div class="col-md-4">
										<div class="cv-form-group">
											<label class="cv-label">2nd Prize</label>
											<input type="text" name="secondPrize" class="cv-input" placeholder="e.g. $5,000" required />
										</div>
									</div>
									<div class="col-md-4">
										<div class="cv-form-group">
											<label class="cv-label">3rd Prize</label>
											<input type="text" name="thirdPrize" class="cv-input" placeholder="e.g. $2,000" required />
										</div>
									</div>
								</div>

								<!-- Submit -->
								<div class="cv-actions mt-3">
									<button type="submit" class="btn-cv btn-cv-primary">
										<i class="bi bi-save"></i> Save Hackathon
									</button>

									<a href="listHackathon" class="btn-cv btn-cv-ghost"> Cancel
									</a>
								</div>

							</form>

						</div>

					</div>

				</div>
			</div>

		</main>
	</div>

	<%-- Footer + Scripts --%>
	<%@ include file="/WEB-INF/views/components/Footer.jsp"%>
	<%@ include file="/WEB-INF/views/components/Scripts.jsp"%>

</body>
<script>
	document.querySelector("form").addEventListener("submit", function(e) {
		const min = parseInt(document.querySelector("[name='minTeamSize']").value);
		const max = parseInt(document.querySelector("[name='maxTeamSize']").value);
		if (min > max) {
			alert("Min team size cannot be greater than max team size.");
			e.preventDefault(); return;
		}

		const regEnd   = document.getElementById("regEndDate").value;
		const evStart  = document.getElementById("eventStartDate").value;
		const evEnd    = document.getElementById("eventEndDate").value;
		const subDL    = document.getElementById("submissionDeadline").value;

		if (evStart && evEnd && evStart > evEnd) {
			alert("Event Start Date must be before Event End Date.");
			e.preventDefault(); return;
		}
		if (evStart && regEnd && evStart < regEnd) {
			alert("Event Start Date should be on or after Registration End Date.");
			e.preventDefault(); return;
		}
		if (subDL && evStart && subDL < evStart) {
			alert("Submission Deadline must be on or after the Event Start Date.");
			e.preventDefault(); return;
		}
	});

	document.getElementById("paymentSelect").addEventListener("change", function() {
		const feeGroup = document.getElementById("feeGroup");
		const feeInput = document.getElementById("feeInput");
		if (this.value === "PAID") {
			feeGroup.style.display = "block";
			feeInput.required = true;
		} else {
			feeGroup.style.display = "none";
			feeInput.required = false;
			feeInput.value = "";
		}
	});
</script>
</html>