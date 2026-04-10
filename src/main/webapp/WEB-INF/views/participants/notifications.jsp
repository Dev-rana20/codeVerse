<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

			<c:set var="pageTitle" value="Notifications" scope="request" />
			<c:set var="activePage" value="notifications" scope="request" />

			<!DOCTYPE html>
			<html lang="en" data-page="notifications">

			<head>
				<%@ include file="../components/Head.jsp" %>

					<style>
						/* ===== Enhanced Elegant UI ===== */
						.cv-notification-list {
							display: flex;
							flex-direction: column;
							gap: 12px;
						}

						.cv-notification {
							display: flex;
							align-items: center;
							gap: 16px;
							padding: 16px;
							border-radius: 14px;
							background: var(--card-bg);
							border: 1px solid rgba(0, 0, 0, 0.06);
							box-shadow: 0 4px 10px rgba(0, 0, 0, 0.04);
							transition: all 0.25s ease;
							position: relative;
						}

						.cv-notification:hover {
							transform: translateY(-3px);
							box-shadow: 0 10px 22px rgba(0, 0, 0, 0.08);
						}

						.cv-notification--unread {
							background: linear-gradient(135deg, rgba(0, 150, 255, 0.08),
									rgba(0, 150, 255, 0.02));
							border-left: 5px solid var(--accent);
						}

						.cv-notification__icon {
							width: 48px;
							height: 48px;
							display: flex;
							align-items: center;
							justify-content: center;
							border-radius: 12px;
							background: black;
							font-size: 20px;
							color: var(--accent);
							flex-shrink: 0;
						}

						.cv-notification__content {
							flex: 1;
						}

						.cv-notification__message {
							font-weight: 600;
							font-size: 0.95rem;
							color: var(--text-primary);
						}

						.cv-notification__time {
							font-size: 0.75rem;
							color: var(--text-muted);
							margin-top: 4px;
						}

						.cv-notification__badge {
							background: var(--accent);
							color: #fff;
							font-size: 0.65rem;
							padding: 3px 8px;
							border-radius: 999px;
							font-weight: 500;
						}

						.cv-empty {
							text-align: center;
							padding: 40px 20px;
							color: var(--text-muted);
						}

						.cv-empty i {
							font-size: 40px;
							margin-bottom: 10px;
							opacity: 0.6;
						}
					</style>
			</head>

			<body data-page="notifications">

				<%@ include file="../components/navbar.jsp" %>

					<div class="cv-shell">

						<%@ include file="../components/Sidebar.jsp" %>

							<main class="cv-content">

								<!-- Page Header -->
								<div class="cv-page-header">
									<div class="cv-page-header__left">
										<div class="cv-page-eyebrow">
											<i class="bi bi-bell"></i> Updates
										</div>
										<h1 class="cv-page-title">Notifications</h1>
										<p class="cv-page-subtitle">Stay updated with your activity in
											a clean and modern way.</p>
									</div>
								</div>

								<div class="cv-card cv-fade-up">

									<div class="cv-card__header d-flex justify-content-between align-items-center">
										<div class="d-flex align-items-center gap-2">
											<i class="bi bi-bell"></i>
											<h2 class="mb-0">Recent Notifications</h2>
										</div>
										<c:if test="${not empty notifications}">
											<a href="/participant/notifications/mark-all-read" class="btn-cv btn-cv--sm btn-cv--ghost">
												<i class="bi bi-check-all"></i> Mark all as read
											</a>
										</c:if>
									</div>

									<div class="cv-card__body">

										<c:choose>

											<c:when test="${not empty notifications}">

												<div class="cv-notification-list">

													<c:forEach var="n" items="${notifications}">

														<a href="/participant/notification/read?id=${n.notificationId}"
															class="cv-notification ${!n.isRead() ? 'cv-notification--unread' : ''}" style="text-decoration: none;">

															<div class="cv-notification__icon">
																<c:choose>
																	<c:when test="${n.type == 'INVITE'}">
																		<i class="bi bi-person-plus-fill"></i>
																	</c:when>
																	<c:when test="${n.type == 'REQUEST_ACCEPT'}">
																		<i class="bi bi-check-circle-fill"></i>
																	</c:when>
																	<c:when test="${n.type == 'SUBMISSION'}">
																		<i class="bi bi-file-earmark-code-fill"></i>
																	</c:when>
																	<c:otherwise>
																		<i class="bi bi-bell-fill"></i>
																	</c:otherwise>
																</c:choose>
															</div>

															<div class="cv-notification__content">
																<div class="cv-notification__message">${n.message}</div>
																<div class="cv-notification__time">
																	<fmt:parseDate value="${n.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
																	<fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy • hh:mm a" />
																</div>
															</div>

															<c:if test="${!n.isRead()}">
																<div class="cv-notification__badge">NEW</div>
															</c:if>

														</a>

													</c:forEach>

												</div>

											</c:when>

											<c:otherwise>

												<div class="cv-empty">
													<i class="bi bi-bell-slash"></i>
													<h3>No notifications yet</h3>
													<p>You're all caught up 🎉</p>
												</div>

											</c:otherwise>

										</c:choose>

									</div>

								</div>

							</main>

					</div>

					<%@ include file="../components/Footer.jsp" %>
						<%@ include file="../components/Scripts.jsp" %>

			</body>

			</html>