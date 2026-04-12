<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="pageTitle" value="${publicUser.firstName}'s Portfolio"
	scope="request" />
<c:set var="activePage" value="discovery" scope="request" />

<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../components/Head.jsp"%>
<style>
.portfolio-header {
	background: linear-gradient(135deg, #161b2c, #0b0f1a);
	border: 1px solid rgba(255, 255, 255, 0.05);
	border-radius: 20px;
	padding: 40px;
	margin-bottom: 30px;
	display: flex;
	align-items: center;
	gap: 40px;
	position: relative;
	overflow: hidden;
}

.portfolio-header::after {
	content: '';
	position: absolute;
	top: -50%;
	right: -10%;
	width: 300px;
	height: 300px;
	background: radial-gradient(circle, rgba(0, 255, 224, 0.05) 0%,
		transparent 70%);
	border-radius: 50%;
}

.portfolio-pic {
	width: 150px;
	height: 150px;
	border-radius: 50%;
	border: 4px solid #00ffe0;
	box-shadow: 0 0 30px rgba(0, 255, 224, 0.2);
	object-fit: cover;
}

.portfolio-name {
	font-size: 2.2rem;
	font-weight: 800;
	color: #fff;
	margin-bottom: 8px;
}

.portfolio-tagline {
	font-size: 1.1rem;
	color: #00ffe0;
	font-family: 'Space Mono', monospace;
	margin-bottom: 20px;
}

.portfolio-links a {
	color: #aaa;
	font-size: 1.2rem;
	margin-right: 15px;
	transition: color 0.3s;
}

.portfolio-links a:hover {
	color: #fff;
}

.portfolio-grid {
	display: grid;
	grid-template-columns: 1fr 2fr;
	gap: 30px;
}

.profile-side-card {
	background: rgba(255, 255, 255, 0.02);
	border: 1px solid rgba(255, 255, 255, 0.05);
	border-radius: 16px;
	padding: 24px;
	margin-bottom: 20px;
}

.section-heading {
	font-size: 0.8rem;
	color: #6b7280;
	font-family: 'Space Mono', monospace;
	text-transform: uppercase;
	letter-spacing: 0.1em;
	margin-bottom: 15px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.05);
	padding-bottom: 8px;
}

.bio-text {
	color: #d1d5db;
	line-height: 1.7;
	font-size: 0.95rem;
	white-space: pre-wrap;
}
</style>
</head>
<body class="cv-scope">
	<%@ include file="../components/navbar.jsp"%>

	<div class="cv-shell">
		<%@ include file="../components/Sidebar.jsp"%>

		<main class="cv-content">
			<div class="portfolio-header">
				<img
					src="${not empty publicUser.profilePicURL 
        ? publicUser.profilePicURL 
        : 'https://api.dicebear.com/7.x/initials/svg?seed='.concat(publicUser.firstName)}"
					class="portfolio-pic" alt="Avatar">
				<div>
					<h1 class="portfolio-name">${publicUser.firstName}
						${publicUser.lastName}</h1>
					<div class="portfolio-tagline">${not empty publicUserDetail.qualification ? publicUserDetail.qualification : 'Tech Explorer'}</div>
					<div class="portfolio-links">
						<c:if test="${not empty publicUserDetail.githubLink}">
							<a href="${publicUserDetail.githubLink}" target="_blank"
								title="GitHub Profile"> <i class="bi bi-github"></i>
							</a>
						</c:if>
						<c:if test="${not empty publicUserDetail.linkedinLink}">
							<a href="${publicUserDetail.linkedinLink}" target="_blank"
								title="LinkedIn Profile"> <i class="bi bi-linkedin"></i>
							</a>
						</c:if>
						<c:if test="${not empty publicUserDetail.twitterLink}">
							<a href="${publicUserDetail.twitterLink}" target="_blank"
								title="Twitter / X Profile"> <i class="bi bi-twitter-x"></i>
							</a>
						</c:if>
						<c:if test="${not empty publicUser.email}">
							<a href="mailto:${publicUser.email}" title="Send Email"> <i
								class="bi bi-envelope-fill"></i>
							</a>
						</c:if>
						<c:if test="${not empty publicUser.contactNum}">
							<a href="tel:${publicUser.contactNum}" title="Quick Contact">
								<i class="bi bi-telephone-fill"></i>
							</a>
						</c:if>
					</div>
				</div>
			</div>

			<div class="portfolio-grid">
				<div class="portfolio-left">
					<div class="profile-side-card">
						<div class="section-heading">About Me</div>
						<div class="bio-text">${not empty publicUserDetail.bio ? publicUserDetail.bio : 'This participant is a mystery... No bio found.'}</div>
					</div>

					<div class="profile-side-card">
						<div class="section-heading">Technical Skills</div>
						<div class="d-flex flex-wrap gap-2">
							<c:if test="${not empty publicUserDetail.skills}">
								<c:forEach var="skill"
									items="${fn:split(publicUserDetail.skills, ',')}">
									<span class="skill-tag"
										style="font-size: 0.8rem; padding: 6px 12px;">${fn:trim(skill)}</span>
								</c:forEach>
							</c:if>
							<c:if test="${empty publicUserDetail.skills}">
								<span class="text-muted small">Skills not listed.</span>
							</c:if>
						</div>
					</div>

					<div class="profile-side-card">
						<div class="section-heading">Location</div>
						<div class="text-muted-cv small">
							<i class="bi bi-geo-alt-fill me-1"></i> ${publicUserDetail.city},
							${publicUserDetail.country}
						</div>
					</div>
				</div>

				<div class="portfolio-right">
					<div class="cv-card mb-4">
						<div class="cv-card__header">
							<i class="bi bi-trophy-fill text-accent"></i>
							<h2>Hackathon Portfolio</h2>
						</div>
						<div class="cv-card__body p-0">
							<div class="cv-table-wrap">
								<c:choose>
									<c:when test="${not empty registrations}">
										<table class="cv-table">
											<thead>
												<tr>
													<th>Hackathon Event</th>
													<th>Year</th>
													<th class="text-end">Status</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="reg" items="${registrations}">
													<tr>
														<td style="font-weight: 700;">${reg.hackathon.title}</td>
														<td class="font-mono text-muted-cv small">${fn:substring(reg.registrationDate, 0, 4)}</td>
														<td class="text-end"><span
															class="cv-badge cv-badge--${fn:toLowerCase(reg.hackathon.status)}">
																${reg.hackathon.status} </span></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</c:when>
									<c:otherwise>
										<div class="p-5 text-center text-muted-cv">
											<i class="bi bi-clipboard2-data d-block mb-3"
												style="font-size: 2.5rem; opacity: 0.4;"></i>
											<p>No hackathon activity recorded yet.</p>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>

					<div class="cv-card overflow-hidden">
						<div class="cv-card__banner cv-card__banner--ongoing"></div>
						<div class="cv-card__body p-4 text-center">
							<h3 style="font-weight: 800; margin-bottom: 0.5rem;">Join
								${publicUser.firstName}'s Team?</h3>
							<p class="text-muted-cv mb-4">Interested in collaborating?
								Check out ${publicUser.firstName}'s active hackathons and team
								slots.</p>
							<a href="/hackathons" class="btn-cv btn-cv--primary w-100">Find
								Active Hackathons</a>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>

	<%@ include file="../components/Footer.jsp"%>
	<%@ include file="../components/Scripts.jsp"%>
</body>
</html>
