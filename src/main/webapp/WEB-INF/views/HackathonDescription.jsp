<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hackathon Description</title>

<!-- Bootstrap 5 CDN -->
<link href="https://cdn.jsdelivr.net/npmbootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        background: #f5f7fa;
    }
    .signup-card {
        max-width: 650px;
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

<div class="container">
    <div class="signup-card">
        <h3 class="text-center mb-4">Hackathon Description</h3>

        <form action="/saveHackathonDescription" method="post">

            <!-- Hackathon Details -->
            <div class="mb-3">
                <label class="form-label">Hackathon Details</label>
                <textarea name="hackathonDetails"
                          class="form-control"
                          rows="6"
                          placeholder="Enter full hackathon description, rules, prizes, timeline..."
                          required></textarea>
            </div>

            <!-- Submit -->
            <div class="d-grid mt-3">
                <button type="submit" class="btn btn-primary">
                    Save Description
                </button>
            </div>

        </form>
    </div>
</div>

</body>
</html>
