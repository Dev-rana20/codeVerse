<%--============================================================CODEVERSE — Base Page
	Template============================================================HOW TO USE: Copy this file, rename it, then fill
	in the three blocks marked TODO below. That's all you need for any new page. Blocks to fill: 1. pageTitle — shown in
	<title> and page header
	2. activePage — highlights the correct nav link
	values: dashboard | hackathons | team
	submissions | leaderboard
	3. pageContent — your page-specific HTML goes here

	OPTIONAL blocks (delete if unused):
	- pageEyebrow — small label above the title
	- pageSubtitle — muted subtitle below the title
	- pageHeaderRight — buttons/chips in top-right of header
	- extraStyles — any page-specific <style>
		overrides - extraScripts — any page-specific <script>blocks============================================================--%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%-- ── TODO 1: Set page metadata ─────────────────────────────── --%><c:set var="pageTitle" value="Page Title" scope="request" /><c:set var="activePage" value="dashboard" scope="request" /><%-- Optional: --%><c:set var="pageEyebrow" value="" scope="request" /><c:set var="pageSubtitle" value="" scope="request" />< !DOCTYPE html><html lang="en"><head><%@ include file="head.jsp" %><%-- ── TODO (optional): Page-specific styles ──────────────── --%><%-- <style>
		/* your page-only overrides here */
	</style>
	--%>
	</head>

	<body>

		<%-- NAVBAR --%>
			<%@ include file="navbar.jsp" %>

				<%-- PAGE HEADER --%>
					<div class="cv-page-header">
						<div class="container">
							<div class="d-flex align-items-start justify-content-between flex-wrap gap-3">
								<div>
									<c:if test="${not empty pageEyebrow}">
										<div class="cv-page-header__eyebrow">
											<i class="bi bi-lightning-charge"></i>${pageEyebrow}
										</div>
									</c:if>
									<h1 class="cv-page-header__title cv-fade-up">${pageTitle}</h1>
									<c:if test="${not empty pageSubtitle}">
										<p class="cv-page-header__sub cv-fade-up">${pageSubtitle}</p>
									</c:if>
								</div>
								<%-- Optional right-side actions slot --%>
									<div id="pageHeaderRight" class="d-flex align-items-center gap-2 flex-wrap">
										<%-- TODO (optional): Add header action buttons here --%>
									</div>
							</div>
						</div>
					</div>

					<%-- ── MAIN CONTENT ──────────────────────────────────────────── --%>
						<main class="cv-main">
							<div class="container py-3">

								<%-- ── TODO 2: Your page content goes below this line ─── --%>




									<%-- ── END page content ──────────────────────────────── --%>

							</div>
						</main>

						<%-- FOOTER --%>
							<%@ include file="footer.jsp" %>

								<%-- SCRIPTS --%>
									<%@ include file="scripts.jsp" %>

										<%-- ── TODO (optional): Page-specific scripts ─────────────── --%>
											<%-- <script>
												// your page-only JS here
												</script>
												--%>

	</body>

	</html>