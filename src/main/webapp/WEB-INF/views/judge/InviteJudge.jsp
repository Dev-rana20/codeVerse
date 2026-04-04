<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>

	<body>
		<form action="/admin/invite-judge" method="post">
			<input type="email" name="email" placeholder="Enter judge email" required />
			<button type="submit">Invite Judge</button>
		</form>
	</body>

	</html>