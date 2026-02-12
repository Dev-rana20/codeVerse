<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>View User</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <style>
        .profile-pic {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #ddd;
        }
        .label {
            font-weight: 600;
            color: #555;
        }
    </style>
</head>

<body>
<div class="container mt-4">

    <div class="card shadow">
        <div class="card-header bg-dark text-white">
            <h4 class="mb-0">User Details</h4>
        </div>

        <div class="card-body">
            <div class="row">

                <!-- Profile Picture -->
                <div class="col-md-3 text-center">
                    <c:choose>
                        <c:when test="${not empty user.profilePicURL}">
                            <img src="${user.profilePicURL}" class="profile-pic">
                        </c:when>
                        <c:otherwise>
                            <img src="https://via.placeholder.com/120"
                                 class="profile-pic">
                        </c:otherwise>
                    </c:choose>

                    <div class="mt-2">
                        <span class="badge bg-info text-dark">
                            ${user.role}
                        </span>
                    </div>
                </div>

                <!-- User Info -->
                <div class="col-md-9">
                    <table class="table table-borderless">
                        <tr>
                            <td class="label">User ID</td>
                            <td>${user.userId}</td>
                        </tr>
                        <tr>
                            <td class="label">Full Name</td>
                            <td>${user.firstName} ${user.lastName}</td>
                        </tr>
                        <tr>
                            <td class="label">Email</td>
                            <td>${user.email}</td>
                        </tr>
                        <tr>
                            <td class="label">Gender</td>
                            <td>${user.gender}</td>
                        </tr>
                        <tr>
                            <td class="label">Birth Year</td>
                            <td>${user.birthYear}</td>
                        </tr>
                        <tr>
                            <td class="label">Contact Number</td>
                            <td>${user.contactNum}</td>
                        </tr>
                      <tr>
                            <td class="label">Created At</td>
                            <td>
                                ${user.createdAt}
                            </td>
                        </tr>  
                        <tr>
                            <td class="label">Status</td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.active}">
                                        <span class="badge bg-success">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">Inactive</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="label">Country</td>
                            <td>
                                ${userDetail.country}
                            </td>
                        </tr>
                        <tr>
                            <td class="label">State</td>
                            <td>
                                ${userDetail.state}
                            </td>
                        </tr>
                        <tr>
                            <td class="label">City</td>
                            <td>
                                ${userDetail.city}
                            </td>
                        </tr>
                        
                        
                    </table>
                </div>

            </div>
        </div>

        <div class="card-footer text-end">
            <a href="listUser" class="btn btn-secondary">Back</a>
            <a href="editUser?userId=${user.userId}" class="btn btn-warning">Edit</a>
        </div>
    </div>

</div>
</body>
</html>