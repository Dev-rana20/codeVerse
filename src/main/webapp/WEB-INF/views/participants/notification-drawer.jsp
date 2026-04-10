<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:choose>

		<c:when test="${not empty notifications}">

			<c:forEach items="${notifications}" var="n">

				<a href="/participant/notification/read?id=${n.id}"
					class="cv-notification-item ${!n.read ? 'unread' : ''}">

					<div class="cv-notification-icon-wrap">
						<c:choose>
							<c:when test="${n.type == 'INVITE'}">
								<i class="bi bi-person-plus-fill text-primary"></i>
							</c:when>
							<c:when test="${n.type == 'REQUEST_ACCEPT'}">
								<i class="bi bi-check-circle-fill text-success"></i>
							</c:when>
							<c:when test="${n.type == 'SUBMISSION'}">
								<i class="bi bi-file-earmark-code-fill text-info"></i>
							</c:when>
							<c:otherwise>
								<i class="bi bi-bell-fill"></i>
							</c:otherwise>
						</c:choose>
					</div>

					<div>
						<div class="cv-notification-message">${n.message}</div>
						<div class="cv-notification-time">${n.formattedDate}</div>
					</div>

				</a>

			</c:forEach>

		</c:when>

		<c:otherwise>

			<div class="cv-empty-small">No Notifications</div>

		</c:otherwise>

	</c:choose>
</body>
<%@ include file="../components/Scripts.jsp"%>
</html>