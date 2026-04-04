<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<nav class="cv-navbar">
		<div class="container">
			<div class="d-flex align-items-center justify-content-between">

				<a href="userHome" class="brand">CODE<span>VERSE</span></a>

				<ul class="nav d-none d-md-flex align-items-center">
					<li><a href="userHome" class="nav-link-cv active">Dashboard</a></li>
					<li><a href="hackathons" class="nav-link-cv">Hackathons</a></li>
					<li><a href="myTeam" class="nav-link-cv">My Team</a></li>
					<li><a href="submissions.jsp" class="nav-link-cv">Submissions</a></li>
					<li><a href="leaderboard.jsp" class="nav-link-cv">Leaderboard</a></li>
				</ul>

				<div class="d-flex align-items-center gap-3">
					<a href="notifications.jsp" class="position-relative text-decoration-none"
						style="color:var(--text-muted)">
						<i class="bi bi-bell" style="font-size:1.1rem"></i>
						<c:if test="${notifCount > 0}">
							<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill"
								style="background:var(--danger);font-size:0.55rem">${notifCount}</span>
						</c:if>
					</a>

					<div class="avatar-btn">
						<c:choose>
							<c:when test="${not empty sessionScope.user.profilePicURL}">
								<img src="${sessionScope.user.profilePicURL}" alt="avatar" />
							</c:when>
							<c:otherwise>
								<img src="https://api.dicebear.com/7.x/initials/svg?seed=${sessionScope.user.firstName}&backgroundColor=0f1420&textColor=00ffe0"
									alt="avatar" />
							</c:otherwise>
						</c:choose>
					</div>

					<a href="logout" class="btn-cv-ghost" style="font-size:0.7rem;padding:0.35rem 0.7rem">
						<i class="bi bi-box-arrow-right me-1"></i>Logout
					</a>
				</div>

			</div>
		</div>
	</nav>