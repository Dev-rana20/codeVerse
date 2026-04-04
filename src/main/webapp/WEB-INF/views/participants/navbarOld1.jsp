<%--============================================================CODEVERSE — Navbar Fragment Include via: <%@ include
	file="/components/navbar.jsp" %>
	or
	<jsp:include page="/components/navbar.jsp" />

	Reads from session:
	sessionScope.userName — display name
	sessionScope.userAvatar — avatar URL (optional)
	sessionScope.notifCount — unread notifications (optional)

	Set the active link by putting this BEFORE the include:
	<c:set var="activePage" value="hackathons" scope="request" />

	Valid values: dashboard | hackathons | team | submissions | leaderboard
	============================================================ --%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<nav class="cv-navbar">
			<div class="container">
				<div class="d-flex align-items-center justify-content-between gap-3">

					<%-- BRAND --%>
						<a href="/participant/home" class="brand">CODE<span>VERSE</span></a>

						<%-- DESKTOP NAV --%>
							<ul class="nav d-none d-lg-flex align-items-center">
								<li>
									<a href="/participant/home"
										class="nav-link-cv ${activePage == 'dashboard' ? 'active' : ''}">
										<i class="bi bi-speedometer2 me-1"></i>Dashboard
									</a>
								</li>
								<li>
									<a href="/participant/hackathons"
										class="nav-link-cv ${activePage == 'hackathons' ? 'active' : ''}">
										<i class="bi bi-lightning-charge me-1"></i>Hackathons
									</a>
								</li>
								<li>
									<a href="/participant/team"
										class="nav-link-cv ${activePage == 'team' ? 'active' : ''}">
										<i class="bi bi-people me-1"></i>My Team
									</a>
								</li>
								<li>
									<a href="/participant/submissions"
										class="nav-link-cv ${activePage == 'submissions' ? 'active' : ''}">
										<i class="bi bi-code-slash me-1"></i>Submissions
									</a>
								</li>
								<li>
									<a href="/participant/leaderboard"
										class="nav-link-cv ${activePage == 'leaderboard' ? 'active' : ''}">
										<i class="bi bi-bar-chart-line me-1"></i>Leaderboard
									</a>
								</li>
							</ul>

							<%-- RIGHT SIDE --%>
								<div class="d-flex align-items-center gap-3">

									<%-- Notification Bell --%>
										<a href="/participant/notifications"
											class="position-relative text-decoration-none"
											style="color:var(--text-muted)" data-cv-tip="Notifications">
											<i class="bi bi-bell" style="font-size:1.1rem"></i>
											<c:if test="${sessionScope.notifCount > 0}">
												<span id="cvNotifBadge"
													class="position-absolute top-0 start-100 translate-middle badge rounded-pill"
													style="background:var(--danger);font-size:0.52rem;min-width:16px;height:16px;display:inline-flex;align-items:center;justify-content:center">
													${sessionScope.notifCount}
												</span>
											</c:if>
											<c:if
												test="${empty sessionScope.notifCount || sessionScope.notifCount == 0}">
												<span id="cvNotifBadge" style="display:none"
													class="position-absolute top-0 start-100 translate-middle badge rounded-pill"
													style="background:var(--danger);font-size:0.52rem">0</span>
											</c:if>
										</a>

										<%-- Avatar --%>
											<a href="/participant/profile" class="cv-avatar" data-cv-tip="My Profile">
												<c:choose>
													<c:when test="${not empty sessionScope.userAvatar}">
														<img src="${sessionScope.userAvatar}"
															alt="${sessionScope.userName}" />
													</c:when>
													<c:otherwise>
														<img src="https://api.dicebear.com/7.x/initials/svg?seed=${sessionScope.userName}&backgroundColor=0f1420&textColor=00ffe0"
															alt="${sessionScope.userName}" />
													</c:otherwise>
												</c:choose>
											</a>

											<%-- Logout --%>
												<a href="/logout"
													class="btn-cv btn-cv--ghost btn-cv--sm d-none d-sm-inline-flex"
													data-cv-confirm="Are you sure you want to logout?">
													<i class="bi bi-box-arrow-right"></i>Logout
												</a>

												<%-- Hamburger (mobile) --%>
													<button class="cv-hamburger d-lg-none" id="cvNavToggle"
														aria-label="Toggle navigation" aria-expanded="false">
														<i class="bi bi-list"></i>
													</button>

								</div>
				</div>
			</div>

			<%-- MOBILE MENU --%>
				<div class="cv-mobile-menu" id="cvMobileMenu">
					<a href="/participant/home" class="nav-link-cv ${activePage == 'dashboard' ? 'active' : ''}">
						<i class="bi bi-speedometer2 me-2"></i>Dashboard
					</a>
					<a href="/participant/hackathons" class="nav-link-cv ${activePage == 'hackathons' ? 'active' : ''}">
						<i class="bi bi-lightning-charge me-2"></i>Hackathons
					</a>
					<a href="/participant/team" class="nav-link-cv ${activePage == 'team' ? 'active' : ''}">
						<i class="bi bi-people me-2"></i>My Team
					</a>
					<a href="/participant/submissions"
						class="nav-link-cv ${activePage == 'submissions' ? 'active' : ''}">
						<i class="bi bi-code-slash me-2"></i>Submissions
					</a>
					<a href="/participant/leaderboard"
						class="nav-link-cv ${activePage == 'leaderboard' ? 'active' : ''}">
						<i class="bi bi-bar-chart-line me-2"></i>Leaderboard
					</a>
					<a href="/logout" class="nav-link-cv" style="color:var(--danger) !important">
						<i class="bi bi-box-arrow-right me-2"></i>Logout
					</a>
				</div>
		</nav>