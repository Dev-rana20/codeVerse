<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>Insert title here</title>
		</head>

		<body>
			<div class="container mt-4">

				<div class="cv-card">

					<div class="cv-card__body">

						<h3>${team.teamName}</h3>

						<!-- Project Link -->
						<div class="mb-3">
							<label>Project:</label>

							<c:choose>
								<c:when test="${not empty team.finalSubmissionLink}">
									<a href="${team.finalSubmissionLink}" target="_blank"> View
										Submission </a>
								</c:when>

								<c:otherwise>
									<span class="cv-badge cv-badge--danger"> No Submission </span>
								</c:otherwise>
							</c:choose>
						</div>

						<form action="/judge/submit-evaluation" method="post">

							<input type="hidden" name="teamId" value="${team.hackathonTeamId}" />

							<div class="row g-3">

								<div class="col-md-6">
									<label>Innovation (0-10)</label> <input type="number" name="innovation" min="0"
										max="10" class="form-control" required>
								</div>

								<div class="col-md-6">
									<label>Technical (0-10)</label> <input type="number" name="technical" min="0"
										max="10" class="form-control" required>
								</div>

								<div class="col-md-6">
									<label>UI/UX (0-10)</label> <input type="number" name="uiUx" min="0" max="10"
										class="form-control" required>
								</div>

								<div class="col-md-6">
									<label>Functionality (0-10)</label> <input type="number" name="functionality"
										min="0" max="10" class="form-control" required>
								</div>

								<div class="col-md-6">
									<label>Presentation (0-10)</label> <input type="number" name="presentation" min="0"
										max="10" class="form-control" required>
								</div>

								<div class="col-md-6">
									<label>Impact (0-10)</label> <input type="number" name="impact" min="0" max="10"
										class="form-control" required>
								</div>

							</div>

							<div class="mt-3">
								<label>Remarks</label>
								<textarea name="remarks" class="form-control"></textarea>
							</div>

							<div class="mt-4">
								<button type="submit" class="btn-cv btn-cv--primary">
									Submit Evaluation</button>
							</div>

						</form>

					</div>

				</div>

			</div>
		</body>

		</html>