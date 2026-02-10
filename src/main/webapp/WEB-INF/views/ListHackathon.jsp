<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hackathon List</title>
<jsp:include page="AdminCSS.jsp"></jsp:include>
<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body {
	background-color: #f8f9fa;
}

.card {
	margin-top: 80px;
	border-radius: 12px;
}
</style>


 <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
        }
        .container {
            width: 95%;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            border-radius: 6px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            margin-bottom: 15px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background: #f9f9f9;
        }
        .badge {
            padding: 5px 10px;
            border-radius: 12px;
            color: white;
            font-size: 12px;
        }
        .new{
        	padding: 5px 10px;
            border-radius: 12px;
            color: red;
            font-size: 12px;
        }
        .UPCOMING { background: #17a2b8; }
        .ONGOING { background: #28a745; }
        .COMPLETED { background: #6c757d; }

        .FREE { background: #28a745; }
        .PAID { background: #dc3545; }

        .btn {
            padding: 6px 10px;
            text-decoration: none;
            border-radius: 4px;
            font-size: 13px;
            color: white;
        }
        .btn-add { background: #28a745; }
        .btn-edit { background: #ffc107; color: black; }
        .btn-delete { background: #dc3545; }
        .btn-view { background: #007bff; }
    </style>
<style>
    body{
        background:#f4f6f9;
    }
    .table-card{
        margin-top:50px;
        padding:25px;
        background:white;
        border-radius:10px;
        box-shadow:0 4px 10px rgba(0,0,0,0.1);
    }
</style>

</head>
<body>
<jsp:include page="AdminHeader.jsp"></jsp:include>
<jsp:include page="AdminSidebar.jsp"></jsp:include>
<div class="content">
    <div class="table-card">

        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3>Hackathon List</h3>
            <a href="newHackathon" class="btn btn-primary">+ Add Hackathon</a>
        </div>

        <table class="table table-bordered table-hover text-center align-middle">
        <thead>
				<tr>
					<th>#</th>
					<th>Title</th>
					<th>Status</th>
					<th>Event Type</th>
					<th>Payment</th>
					<th>Team Size</th>
					<th>Location</th>
					<th>Registration Period</th>
					<th>Actions</th>
				</tr>
			</thead>

			<tbody>
				<c:choose>
					<c:when test="${empty allHackathon}">
						<tr>
							<td colspan="9">No hackathons found</td>
						</tr>
					</c:when>

					<c:otherwise>
						<c:forEach var="h" items="${allHackathon}" varStatus="i">
							<tr>
								<td>${i.count}</td>
								<td>${h.title}</td>

								<td><span class="badge ${h.status}"> ${h.status}
								</span></td>

								<td>${h.eventType}</td>

								<td><span class="new ${h.payment}">
										${h.payment} </span></td>

								<td>${h.minTeamSize} - ${h.maxTeamSize}</td>

								<td>${h.location}</td>

								<td>${h.registrationStartDate} to
									${h.registrationEndDate}</td>

								<td><a
									href="viewHackathon?hackathonId=${h.hackathonId}"
									class="btn btn-view">View</a> <a
									href="editHackathon"
									class="btn btn-edit">Edit</a> 
									
									
									<a
									href="deleteHackathon?hackathonId=${h.hackathonId}"
									class="btn btn-delete"
									onclick="return confirm('Are you sure you want to delete this hackathon?')">
										Delete </a></td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
        </table>

    </div>
    <jsp:include page="AdminFooter.jsp"></jsp:include>
</div>

</body>
</html>
