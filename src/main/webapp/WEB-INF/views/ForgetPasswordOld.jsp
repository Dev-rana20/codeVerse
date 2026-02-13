<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password</title>

<!-- Bootstrap 5 CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        background: #f1f4f9;
    }
    .forgot-card {
        max-width: 420px;
        margin: auto;
        margin-top: 90px;
        padding: 25px;
        border-radius: 10px;
        background: #fff;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
</style>
</head>

<body>

<div class="container">
    <div class="forgot-card">
        <h3 class="text-center mb-3">Forgot Password</h3>
        <p class="text-center text-muted mb-4">
            Enter your registered email address
        </p>

        <form action="ForgetPasswordServlet" method="post">

            <!-- Email -->
            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <input type="email" class="form-control" name="email"
                       placeholder="Enter email" required>
            </div>

            <!-- Submit Button -->
            <div class="d-grid">
                <button type="submit" class="btn btn-primary">
                    Reset Password
                </button>
            </div>

            <!-- Back to login -->
            <p class="text-center mt-3">
                Remember your password?
                <a href="login">Login</a>
            </p>

        </form>
    </div>
</div>

</body>
</html>
