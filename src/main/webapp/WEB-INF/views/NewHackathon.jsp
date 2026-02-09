<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Hackathon</title>
<jsp:include page="AdminCSS.jsp"></jsp:include>
<!-- Bootstrap 5 CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>
    body {
        background: #f5f7fa;
    }
    .signup-card {
        max-width: 550px;
        margin: auto;
        margin-top: 60px;
        padding: 25px;
        border-radius: 10px;
        background: #fff;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }
</style>
</head>

<body>
	<jsp:include page="AdminHeader.jsp"></jsp:include>
	<jsp:include page="AdminSidebar.jsp"></jsp:include>

<div class="content">
    <div class="signup-card">
        <h3 class="text-center mb-4">Create Hackathon</h3>

        <form action="/saveHackathon" method="post">

            <!-- Title -->
            <div class="mb-3">
                <label class="form-label">Hackathon Title</label>
                <input type="text" name="title" class="form-control" required>
            </div>

            <!-- Status -->
            <div class="mb-3">
                <label class="form-label">Status</label>
                <select name="status" class="form-select" required>
                    <option value="">-- Select Status --</option>
                    <option value="true">Active</option>
                    <option value="false">Inactive</option>
                </select>
            </div>

            <!-- Event Type -->
            <div class="mb-3">
                <label class="form-label">Event Type</label>
                <select name="eventType" class="form-select" required>
                    <option value="">-- Select Event Type --</option>
                    <option>Online</option>
                    <option>Offline</option>
                    <option>Hybrid</option>
                </select>
            </div>

            <!-- Payment -->
            <div class="mb-3">
                <label class="form-label">Payment</label>
                <select name="payment" class="form-select" required>
                    <option value="">-- Select Payment Type --</option>
                    <option value="true">Paid</option>
                    <option value="false">Free</option>
                </select>
            </div>

            <!-- Team Size -->
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Min Team Size</label>
                    <input type="number" name="minTeamSize" class="form-control" min="1" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Max Team Size</label>
                    <input type="number" name="maxTeamSize" class="form-control" min="1" required>
                </div>
            </div>

            <!-- Location -->
            <div class="mb-3">
                <label class="form-label">Location</label>
                <input type="text" name="location" class="form-control" required>
            </div>

            <!-- User Type -->
            <div class="mb-3">
                <label class="form-label">User Type</label>
                <select name="userType" class="form-select" required>
                    <option value="">-- Select User Type --</option>
                    <option>Student</option>
                    <option>Professional</option>
                    <option>Open</option>
                </select>
            </div>

            <!-- Registration Dates -->
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Registration Start Date</label>
                    <input type="date" name="registrationStartDate" class="form-control" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Registration End Date</label>
                    <input type="date" name="registrationEndDate" class="form-control" required>
                </div>
            </div>

            <!-- Submit -->
            <div class="d-grid mt-3">
                <button type="submit" class="btn btn-primary">
                    Create Hackathon
                </button>
            </div>

        </form>
    </div>
    	<jsp:include page="AdminFooter.jsp"></jsp:include>
</div>

</body>
</html>
