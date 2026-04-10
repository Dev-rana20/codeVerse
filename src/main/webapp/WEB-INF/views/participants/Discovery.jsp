<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="pageTitle" value="Participant Discovery" scope="request" />
<c:set var="activePage" value="discovery" scope="request" />

<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../components/Head.jsp"%>
<style>
.discovery-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
	gap: 20px;
}

.participant-card {
	background: var(--card-bg, #1a1f2e);
	border: 1px solid rgba(255, 255, 255, 0.05);
	border-radius: 16px;
	padding: 24px;
	transition: all 0.3s ease;
	position: relative;
	overflow: hidden;
	display: flex;
	flex-direction: column;
	height: 100%;
}

.participant-card:hover {
	transform: translateY(-5px);
	border-color: var(--accent-color, #00ffe0);
	box-shadow: 0 10px 30px rgba(0, 255, 224, 0.1);
}

.participant-avatar {
	width: 80px;
	height: 80px;
	border-radius: 50%;
	object-fit: cover;
	margin-bottom: 16px;
	border: 2px solid rgba(255, 255, 255, 0.1);
}

.participant-name {
	font-size: 1.1rem;
	font-weight: 700;
	color: #fff;
	margin-bottom: 4px;
}

.participant-bio {
	font-size: 0.85rem;
	color: #aaa;
	margin-bottom: 16px;
	display: -webkit-box;
	-webkit-line-clamp: 3;
	-webkit-box-orient: vertical;
	overflow: hidden;
	line-height: 1.5;
}

.skill-tag {
	font-size: 0.7rem;
	padding: 4px 10px;
	border-radius: 20px;
	background: rgba(0, 255, 224, 0.1);
	color: #00ffe0;
	margin: 2px;
	display: inline-block;
	border: 1px solid rgba(0, 255, 224, 0.2);
}

.search-bar {
	background: rgba(255, 255, 255, 0.03);
	border: 1px solid rgba(255, 255, 255, 0.1);
	border-radius: 12px;
	padding: 12px 20px;
	color: #fff;
	width: 100%;
	margin-bottom: 30px;
}

.search-bar:focus {
	outline: none;
	border-color: #00ffe0;
	box-shadow: 0 0 0 2px rgba(0, 255, 224, 0.1);
}
</style>
</head>
<body class="cv-scope">
	<%@ include file="../components/navbar.jsp"%>

	<div class="cv-shell">
		<%@ include file="../components/Sidebar.jsp"%>

		<main class="cv-content">
			<div class="cv-page-header">
				<div class="cv-page-header__left">
					<div class="cv-page-eyebrow">
						<i class="bi bi-people-fill"></i> Networking
					</div>
					<h1 class="cv-page-title">Discover Participants</h1>
					<p class="cv-page-subtitle">Find talented developers and
						designers for your next team.</p>
				</div>
			</div>

			<div class="mb-4">
				<input type="text" id="participantSearch" class="search-bar"
					placeholder="Search by name or skills (e.g. Java, React)...">
			</div>

			<div class="discovery-grid" id="discoveryGrid">
				<c:forEach var="p" items="${participants}">
					<%-- Skip current user if needed, but showing everyone for now --%>
					<c:set var="detail"
						value="${userDetailRepo.findByUserId(p.userId).orElse(null)}" />

					<div class="participant-card"
						data-search="${fn:toLowerCase(p.firstName)} ${fn:toLowerCase(p.lastName)} ${fn:toLowerCase(detail.skills)}">
						<div class="d-flex align-items-center gap-3 mb-3">
							<c:choose>
								<c:when test="${not empty p.profilePicURL}">
									<img src="${p.profilePicURL}" alt="${p.firstName}"
										class="participant-avatar">
								</c:when>
								<c:otherwise>
									<img
										src="https://api.dicebear.com/7.x/initials/svg?seed=${p.firstName}"
										alt="${p.firstName}" class="participant-avatar">
								</c:otherwise>
							</c:choose>
							<div>
								<div class="participant-name">${p.firstName}${p.lastName}</div>
								<div class="text-muted-cv small font-mono">${not empty detail.qualification ? detail.qualification : 'Participant'}</div>
							</div>
						</div>

						<p class="participant-bio">${not empty detail.bio ? detail.bio : 'No bio provided.'}</p>

						<div class="mt-auto">
							<div class="mb-3 d-flex flex-wrap">
								<c:if test="${not empty detail.skills}">
									<c:forEach var="skill" items="${fn:split(detail.skills, ',')}">
										<span class="skill-tag">${fn:trim(skill)}</span>
									</c:forEach>
								</c:if>
							</div>

							<a href="/participant/profile/${p.userId}"
								class="btn-cv btn-cv--primary btn-cv--sm w-100"> View
								Portfolio <i class="bi bi-arrow-right ms-1"></i>
							</a>
						</div>
					</div>
				</c:forEach>
			</div>

			<div id="noResults" class="text-center py-5 d-none">
				<i class="bi bi-search text-muted" style="font-size: 3rem;"></i>
				<h3 class="mt-3">No participants found</h3>
				<p class="text-muted">Try a different search term.</p>
			</div>
		</main>
	</div>

	<%@ include file="../components/Footer.jsp"%>
	<%@ include file="../components/Scripts.jsp"%>

	<script>
        document.getElementById('participantSearch').addEventListener('input', function(e) {
            const term = e.target.value.toLowerCase();
            const cards = document.querySelectorAll('.participant-card');
            let found = false;

            cards.forEach(card => {
                const searchContent = card.getAttribute('data-search');
                if (searchContent.includes(term)) {
                    card.style.display = 'flex';
                    found = true;
                } else {
                    card.style.display = 'none';
                }
            });

            document.getElementById('noResults').classList.toggle('d-none', found || cards.length === 0);
            document.getElementById('discoveryGrid').classList.toggle('d-none', !found && cards.length > 0);
        });
    </script>
</body>
</html>
