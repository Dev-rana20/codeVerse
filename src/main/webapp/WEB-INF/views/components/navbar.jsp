<%--============================================================CODEVERSE — Navbar Fragment Path:
	src/main/webapp/WEB-INF/views/components/navbar.jsp Include in any view: <%@ include file="components/navbar.jsp" %>
	OR (from a deeper path):
	<%@ include file="../components/navbar.jsp" %>

		Session attributes read:
		${sessionScope.userName} — full name
		${sessionScope.userEmail} — email
		${sessionScope.userAvatar} — avatar URL (optional)
		${sessionScope.notifCount} — unread notification count

		Set active page on the page's JSP BEFORE the include:
		<c:set var="activePage" value="hackathons" scope="request" />

		Valid activePage values:
		dashboard | hackathons | team | submissions | leaderboard | profile
		============================================================ --%>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


			<style>
				.cv-notification-drawer {
					width: 340px;
					max-height: 420px;
					overflow-y: auto;
					padding: 0;
				}

				.cv-notification-item {
					padding: 12px 14px;
					border-bottom: 1px solid var(--border-color);
					display: flex;
					gap: 10px;
					cursor: pointer;
					transition: .2s;
				}

				.cv-notification-item:hover {
					background: var(--hover-bg);
				}

				.cv-notification-item.unread {
					background: rgba(0, 255, 224, .05);
				}

				.cv-notification-message {
					font-size: .85rem;
					font-weight: 600;
				}

				.cv-notification-time {
					font-size: .7rem;
					color: var(--text-muted);
				}

				.cv-empty-small {
					padding: 20px;
					text-align: center;
					color: var(--text-muted);
				}
			</style>


			<nav class="cv-navbar" role="navigation" aria-label="Main Application Navigation">
				<div class="cv-navbar__inner">

					<%-- Sidebar toggle (works for both desktop collapse & mobile open) --%>
						<button class="cv-sidebar-toggle" data-cv-sidebar-toggle aria-label="Toggle sidebar"
							data-cv-tip="Toggle sidebar">
							<i class="bi bi-layout-sidebar-inset" aria-hidden="true"></i>
						</button>

						<%-- Brand --%>
							<a href="/userHome" class="cv-brand">CODE<span>VERSE</span></a>

							

								<%-- Right side controls --%>
									<div class="cv-navbar-right">

										<div class="cv-navbar-right">

											<%-- Theme Toggle --%>
											<button class="cv-icon-btn" data-cv-theme-toggle title="Toggle Theme" data-cv-tip="Toggle Theme" aria-label="Toggle Light and Dark Mode">
												<i class="bi bi-moon-stars-fill show-dark" aria-hidden="true"></i>
												<i class="bi bi-sun-fill show-light" aria-hidden="true"></i>
											</button>

											<%-- Notification bell --%>
												<div class="cv-dropdown">

													<div class="cv-icon-btn" data-cv-dropdown="cvNotifMenu"
														data-cv-tip="Notifications" role="button" tabindex="0" aria-haspopup="true" aria-expanded="false" aria-label="View notifications">

														<i class="bi bi-bell" aria-hidden="true"></i>

														<c:choose>
															<c:when test="${notifCount > 0}">
																<span id="cvNotifBadge" class="cv-notif-badge">
																	<span class="sr-only">You have </span>${notifCount}<span class="sr-only"> notifications</span> </span>
															</c:when>
														</c:choose>

													</div>

													<div class="cv-dropdown-menu cv-notification-drawer"
														id="cvNotifMenu">

														<div class="cv-dropdown-header">
															<div>Notifications</div>
															<a href="/participant/notifications" class="cv-link-small">
																View All </a>
														</div>

														<div id="cvNotificationList">
															<div class="cv-empty-small">Loading...</div>
														</div>

													</div>

												</div>



												<%-- Avatar dropdown --%>
													<div class="cv-dropdown">
														<div class="cv-nav-avatar" data-cv-dropdown="cvUserMenu"
															data-cv-tip="Account" role="button" tabindex="0" aria-haspopup="true" aria-expanded="false" aria-label="User account menu">
															<c:choose>
																<c:when
																	test="${not empty sessionScope.user.profilePicURL}">
																	<img src="${sessionScope.user.profilePicURL}"
																		alt="${sessionScope.user.firstName}'s Profile Picture" />
																</c:when>
																<c:otherwise>
																	<img src="https://api.dicebear.com/7.x/initials/svg?seed=${sessionScope.user.firstName}&backgroundColor=0f1420&textColor=00ffe0"
																		alt="${sessionScope.user.firstName}'s Initials Avatar" />
																</c:otherwise>
															</c:choose>
														</div>

														<div class="cv-dropdown-menu" id="cvUserMenu">
															<div class="cv-dropdown-header">
																<div class="cv-dropdown-name">
																	<c:out value="${sessionScope.user.firstName}" />
																</div>
																<div class="cv-dropdown-email">
																	<c:out value="${sessionScope.user.email}" />
																</div>
															</div>
															<a href="/profile" class="cv-dropdown-item"> <i
																	class="bi bi-person-circle" aria-hidden="true"></i> My Profile
															</a> 
															<a href="/settings" class="cv-dropdown-item"> <i class="bi bi-gear" aria-hidden="true"></i>
																Settings
															</a>
															<div class="cv-dropdown-divider"></div>
															<a href="/logout" class="cv-dropdown-item danger"
																data-cv-confirm="Are you sure you want to logout?"> <i
																	class="bi bi-box-arrow-right" aria-hidden="true"></i> Logout
															</a>
														</div>
													</div>

										</div>
										<%-- end navbar-right --%>
									</div>
									<%-- end navbar__inner --%>
			</nav>

			<%-- Mobile sidebar overlay (click to close) --%>
				<div class="cv-sidebar-overlay" id="cvSidebarOverlay"></div>