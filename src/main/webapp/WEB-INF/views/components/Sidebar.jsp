<%--============================================================CODEVERSE — Sidebar Fragment Path:
	src/main/webapp/WEB-INF/views/components/sidebar.jsp Include inside the .cv-shell div on every page: <div
	class="cv-shell">
	<%@ include file="components/sidebar.jsp" %>
		<main class="cv-content"> ... </main>
		</div>

		Active link is controlled by the request attribute:
		<c:set var="activePage" value="hackathons" scope="request" />
		Set this BEFORE including the sidebar in your view.

		Nav badge counts (optional, set from controller):
		${requestScope.pendingInviteCount} — shows on Team
		${requestScope.newSubmissionCount} — shows on Submissions
		============================================================ --%>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

			<aside class="cv-sidebar" id="cvSidebar">

				<%-- ── PROFILE STRIP ───────────────────────────────────────── --%>
					<div class="cv-sidebar-profile">
						<div class="cv-sidebar-avatar">
							<c:choose>
								<c:when test="${not empty sessionScope.user.profilePicURL}">
									<img src="${sessionScope.user.profilePicURL}"
										alt="${sessionScope.user.firstName}" />
								</c:when>
								<c:otherwise>
									<img src="https://api.dicebear.com/7.x/initials/svg?seed=${sessionScope.user.firstName}&backgroundColor=0b0f1a&textColor=00ffe0"
										alt="${sessionScope.user.firstName}" />
								</c:otherwise>
							</c:choose>
						</div>
						<div>
							<div class="cv-sidebar-name">
								<c:out value="${sessionScope.user.firstName}" />
							</div>
							<div class="cv-sidebar-role">
								<c:out value="${sessionScope.user.role}" />
							</div>
						</div>
					</div>

					<%-- ── MAIN NAVIGATION ─────────────────────────────────────── --%>
						<nav class="cv-nav-section">
							<div class="cv-nav-section-label">Main</div>

							<a href="/userHome" class="cv-nav-item ${activePage == 'dashboard' ? 'active' : ''}"
								data-page="dashboard">
								<i class="bi bi-speedometer2"></i>
								<span class="cv-nav-label">Dashboard</span>
							</a>

							<a href="/hackathons" class="cv-nav-item ${activePage == 'hackathons' ? 'active' : ''}"
								data-page="hackathons">
								<i class="bi bi-lightning-charge"></i>
								<span class="cv-nav-label">Hackathons</span>
							</a>

							<a href="/myTeam" class="cv-nav-item ${activePage == 'team' ? 'active' : ''}"
								data-page="team">
								<i class="bi bi-people"></i>
								<span class="cv-nav-label">My Team</span>
								<c:if test="${pendingInviteCount > 0}">
									<span class="cv-nav-badge">${pendingInviteCount}</span>
								</c:if>
							</a>

							<a href="/participant/submissions"
								class="cv-nav-item ${activePage == 'submissions' ? 'active' : ''}"
								data-page="submissions">
								<i class="bi bi-code-slash"></i>
								<span class="cv-nav-label">Submissions</span>
								<c:if test="${newSubmissionCount > 0}">
									<span class="cv-nav-badge green">${newSubmissionCount}</span>
								</c:if>
							</a>

							<a href="/leaderboardList"
								class="cv-nav-item ${activePage == 'leaderboard' ? 'active' : ''}"
								data-page="leaderboard">
								<i class="bi bi-bar-chart-line"></i>
								<span class="cv-nav-label">Leaderboard</span>
							</a>
						</nav>

						<%-- ── ACCOUNT ───────────────────────────────────────────────── --%>
							<nav class="cv-nav-section">
								<div class="cv-nav-section-label">Account</div>

								<a href="/profile" class="cv-nav-item ${activePage == 'profile' ? 'active' : ''}"
									data-page="profile">
									<i class="bi bi-person-circle"></i>
									<span class="cv-nav-label">Profile</span>
								</a>

								<a href="/settings" class="cv-nav-item ${activePage == 'settings' ? 'active' : ''}"
									data-page="settings">
									<i class="bi bi-gear"></i>
									<span class="cv-nav-label">Settings</span>
								</a>

								<a href="/participant/notifications"
									class="cv-nav-item ${activePage == 'notifications' ? 'active' : ''}"
									data-page="notifications">
									<i class="bi bi-bell"></i>
									<span class="cv-nav-label">Notifications</span>
									<c:if test="${sessionScope.notifCount > 0}">
										<span class="cv-nav-badge">${sessionScope.notifCount}</span>
									</c:if>
								</a>
							</nav>

							<%-- ── HELP ─────────────────────────────────────────────────── --%>
								<nav class="cv-nav-section">
									<div class="cv-nav-section-label">Support</div>
									<a href="/faq" class="cv-nav-item" data-page="faq">
										<i class="bi bi-question-circle"></i>
										<span class="cv-nav-label">FAQ</span>
									</a>
									<a href="/contact" class="cv-nav-item" data-page="contact">
										<i class="bi bi-envelope"></i>
										<span class="cv-nav-label">Contact Us</span>
									</a>
								</nav>

								<%-- ── SIDEBAR FOOTER ────────────────────────────────────────── --%>
									<div class="cv-sidebar-footer">
										<a href="/logout" class="cv-nav-item" style="color:var(--danger)"
											data-cv-confirm="Are you sure you want to logout?">
											<i class="bi bi-box-arrow-right"></i>
											<span class="cv-nav-label">Logout</span>
										</a>
									</div>

			</aside>