<%--============================================================CODEVERSE — Head Fragment Path:
	src/main/webapp/WEB-INF/views/components/head.jsp Include inside <head> on every view:

	<head>
		<%@ include file="components/head.jsp" %>
	</head>

	Set a custom title before including:
	<c:set var="pageTitle" value="Dashboard" scope="request" />
	============================================================ --%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<title>CodeVerse<c:if test="${not empty pageTitle}"> — ${pageTitle}</c:if>
		</title>
		<meta name="theme-color" content="#090c12" />

		<!-- Google Fonts -->
		<link rel="preconnect" href="https://fonts.googleapis.com" />
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
		<link
			href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap"
			rel="stylesheet" />

		<!-- Bootstrap 5 CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

		<!-- Bootstrap Icons -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

		<!-- CodeVerse Global CSS -->
		<link rel="stylesheet" href="/assets/css/codeverse.css" />