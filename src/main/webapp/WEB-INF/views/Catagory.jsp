<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Select Category</title>

<!-- Bootstrap 5 CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        background: #f4f6f9;
    }
    .category-card {
        max-width: 450px;
        margin: auto;
        margin-top: 80px;
        padding: 25px;
        border-radius: 10px;
        background: #fff;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }
</style>
</head>

<body>

<div class="container">
    <div class="category-card">
        <h3 class="text-center mb-4">Choose Category</h3>

        <form action="saveCatagory" method="post">

            <!-- Category Selection -->
            <div class="mb-3">
                <label class="form-label">Category</label>
                <select name="catagoryId" class="form-select" required>
                    <option value="">-- Select Category --</option>
                    <option value="1" >Programming</option>
                    <option value="2" >Data Science</option>
                    <option value="3" >Data Analytics</option>
                </select>
            </div>

            <!-- Submit Button -->
            <div class="d-grid">
                <button type="submit" class="btn btn-primary">
                    Submit
                </button>
            </div>

        </form>
    </div>
</div>

</body>
</html>
