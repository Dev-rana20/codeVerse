<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<!DOCTYPE html>
		<html>

		<head>
			<title>Hackathon Details</title>

			<!-- Bootstrap -->
			<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

			<style>
				body {
					background-color: #f5f7fa;
				}

				.card {
					border-radius: 12px;
				}

				.title {
					font-size: 28px;
					font-weight: bold;
				}

				.badge-status {
					font-size: 14px;
				}
			</style>
		</head>

		<body>

			<div class="container mt-5">

				<div class="card shadow p-4">

					<!-- Title + Status -->
					<div class="d-flex justify-content-between align-items-center mb-3">
						<div class="title">${hack.title}</div>

						<span class="badge bg-success badge-status">
							${hack.status}
						</span>
					</div>

					<!-- Basic Info -->
					<div class="row mb-3">
						<div class="col-md-4">
							<strong>Event Type:</strong> ${hack.eventType}
						</div>

						<div class="col-md-4">
							<strong>Payment:</strong> ${hack.payment}
						</div>

						<div class="col-md-4">
							<strong>Location:</strong> ${hack.location}
						</div>
					</div>

					<!-- Team Size -->
					<div class="row mb-3">
						<div class="col-md-6">
							<strong>Min Team Size:</strong> ${hack.minTeamSize}
						</div>

						<div class="col-md-6">
							<strong>Max Team Size:</strong> ${hack.maxTeamSize}
						</div>
					</div>

					<!-- Dates -->
					<div class="row mb-3">
						<div class="col-md-6">
							<strong>Registration Start:</strong> ${hack.registrationStartDate}
						</div>

						<div class="col-md-6">
							<strong>Registration End:</strong> ${hack.registrationEndDate}
						</div>
					</div>


					<div class="mb-3">
						<strong>Description:</strong>
						<p>${description.hackathonDetailsText}</p>

						<c:if test="${not empty description.hackathonDetailsURL}">
							<a href="${description.hackathonDetailsURL}" target="_blank" class="btn btn-primary">
								View More Details
							</a>
						</c:if>
					</div>


					<!-- Back Button -->
					<a href="/hackathons" class="btn btn-secondary">
						← Back to Hackathons
					</a>

				</div>

			</div>

		</body>

		</html>