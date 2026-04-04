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

				<a href="/participant/notification/read?id=${n.notificationId}"
					class="cv-notification-item ${!n.read ? 'unread' : ''}">

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