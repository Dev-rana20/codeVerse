<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<!-- Bootstrap 5 CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        background: #eef2f7;
    }
    .login-card {
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
    <div class="login-card">
        <h3 class="text-center mb-4">Login</h3>

        <form action="LoginServlet" method="post">

            <!-- Email -->
            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <input type="email" class="form-control" name="email"
                       placeholder="Enter email" required>
            </div>

            <!-- Password -->
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" class="form-control" name="password"
                       placeholder="Enter password" required>
            </div>

            <!-- Submit Button -->
            <div class="d-grid">
                <button type="submit" class="btn btn-primary">
                    Login
                </button>
            </div>

            <!-- Signup link -->
            <p class="text-center mt-3">
                Don’t have an account?
                <a href="signup">Sign Up</a>
            </p>
            
            <!-- Forget password  -->
            <p class="text-center mt-3">
                Forget Password?
                <a href="forgetPassword">Click Here</a>
            </p>

        </form>
    </div>
</div>

</body>
</html>
