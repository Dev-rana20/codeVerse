<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- Page Identity --%>
<c:set var="pageTitle" value="Hackathon Details" scope="request" />
<c:set var="activePage" value="hackathons" scope="request" />

<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/components/Head.jsp"%>
</head>

<body data-page="hackathons">

	<%@ include file="/WEB-INF/views/components/navbar.jsp"%>

	<div class="cv-shell">

		<%@ include file="/WEB-INF/views/components/SidebarAdmin.jsp"%>

		<main class="cv-content">

			<!-- Page Header -->
			<div class="cv-page-header mb-4">
				<div>
					<div class="cv-page-eyebrow">
						<i class="bi bi-lightning-charge"></i> Hackathons
					</div>
					<h1 class="cv-page-title">${hackathon.title}</h1>
					<p class="cv-page-sub">Detailed information about this
						hackathon</p>
				</div>
			</div>

			<!-- Hackathon Details Card -->
			<div class="cv-card mb-4">
				<div class="cv-card__header">
					<i class="bi bi-info-circle"></i>
					<h3>Hackathon Information</h3>
				</div>

				<div class="cv-card__body">

					<div class="row mb-3">
						<div class="col-md-6">
							<p>
								<b>ID:</b> ${hackathon.hackathonId}
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
							<span
								class="cv-badge 
								${hackathon.status == 'ONGOING' ? 'bg-success' : 
								  hackathon.status == 'UPCOMING' ? 'bg-info' : 'bg-secondary'}">
								${hackathon.status} </span>
						</div>
						<div class="col-md-6">
							<p>
								<b>Event Type:</b> ${hackathon.eventType}
							</p>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col-md-6">
							<span
								class="cv-badge 
								${hackathon.payment == 'FREE' ? 'bg-success' : 'bg-danger'}">
								${hackathon.payment} </span>
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
								<b>Registration Start:</b> ${hackathon.registrationStartDate}
							</p>
						</div>
						<div class="col-md-6">
							<p>
								<b>Registration End:</b> ${hackathon.registrationEndDate}
							</p>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col-md-6">
							<p>
								<b>Event Start:</b> ${hackathon.eventStartDate != null ? hackathon.eventStartDate : 'Not Set'}
							</p>
						</div>
						<div class="col-md-6">
							<p>
								<b>Event End:</b> ${hackathon.eventEndDate != null ? hackathon.eventEndDate : 'Not Set'}
							</p>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col-md-12">
							<p>
								<b>Submission Deadline:</b> 
								<span class="text-danger" style="font-weight: bold;">
									${hackathon.submissionDeadline != null ? hackathon.submissionDeadline : 'Not Set'}
								</span>
							</p>
						</div>
					</div>

					<div class="cv-actions mt-3">
						<a href="listHackathon" class="btn-cv btn-cv-ghost">Back</a> <a
							href="editHackathon?hackathonId=${hackathon.hackathonId}"
							class="btn-cv btn-cv-primary"> <i class="bi bi-pencil"></i>
							Edit
						</a>
					</div>

				</div>
			</div>

			<!-- Description / Poster -->
			<c:if test="${hackathonDescriptionEntity != null}">
				<div class="cv-card">
					<div class="cv-card__header">
						<i class="bi bi-file-earmark-text"></i>
						<h3>Hackathon Details</h3>
					</div>

					<div class="cv-card__body">

						<div class="row">

							<!-- Poster -->
							<div class="col-md-5 text-center">
								<c:if test="${not empty descList.hackathonDetailsURL}">
									<img src="${descList.hackathonDetailsURL}"
										class="img-fluid rounded shadow" style="max-width: 100%;">
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
			</c:if>

		</main>
	</div>

	<%@ include file="/WEB-INF/views/components/Footer.jsp"%>
	<%@ include file="/WEB-INF/views/components/Scripts.jsp"%>

</body>
</html>