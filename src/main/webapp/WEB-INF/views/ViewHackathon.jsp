<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Hackathon</title>

<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body{
        background:#f4f6f9;
    }
    .view-card{
        margin-top:60px;
        padding:30px;
        background:white;
        border-radius:12px;
        box-shadow:0 5px 15px rgba(0,0,0,0.1);
    }
    .label{
        font-weight:600;
        color:#555;
    }
</style>
<jsp:include page="AdminCSS.jsp"></jsp:include>
</head>
<body>

<jsp:include page="AdminHeader.jsp"></jsp:include>
<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>

<div class="content">
    <div class="view-card">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3>${hackathon.title}</h3>
            <a href="listHackathon" class="btn btn-secondary">Back</a>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <p><span class="label">Hackathon ID:</span> ${hackathon.hackathonId}</p>
            </div>
            <div class="col-md-6">
                <p><span class="label">Title:</span> ${hackathon.title}</p>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <p><span class="label">Status:</span> ${hackathon.status}</p>
            </div>
            <div class="col-md-6">
                <p><span class="label">Event Type:</span> ${hackathon.eventType}</p>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <p><span class="label">Payment:</span> ${hackathon.payment}</p>
            </div>
            <div class="col-md-6">
                <p>
                    <span class="label">Team Size:</span>
                    ${hackathon.minTeamSize} - ${hackathon.maxTeamSize}
                </p>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <p><span class="label">Location:</span> ${hackathon.location}</p>
            </div>
            <div class="col-md-6">
                <p><span class="label">User Type ID:</span> ${hackathon.userTypeId}</p>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <p><span class="label">Registration Start Date:</span> ${hackathon.registrationStartDate}</p>
            </div>
            <div class="col-md-6">
                <p><span class="label">Registration End Date:</span> ${hackathon.registrationEndDate}</p>
            </div>
        </div>

        <div class="text-end mt-4">
            <a href="editHackathon?id=${hackathon.hackathonId}" 
               class="btn btn-warning">Edit</a>
        </div>

    </div>
</div>

</body>
</html>
