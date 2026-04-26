<%@ page import="model.Employee" %>
<%@page import ="model.User" %>

<script>
    // Block back & forward buttons
    history.pushState(null, null, location.href);
    window.onpopstate = function () {
        history.pushState(null, null, location.href);
    };
</script>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies
%>
<%
    Employee emp = (Employee) request.getAttribute("emp");
%>
<%
    Integer empId = (Integer) session.getAttribute("empId");
    if (empId == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background:#eef2ff;
            margin: 0;
            padding: 40px;
        }

        .profile-container {
            max-width: 900px;
            margin: auto;
            background: #fff;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }

        /* Header */
        .profile-header {
            background: linear-gradient(90deg, #4e54c8, #8f94fb);
            padding: 30px;
            color: #fff;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .avatar {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            background: #fff;
            color: #4e54c8;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 36px;
            font-weight: bold;
        }

        .header-text h2 {
            margin: 0;
            font-weight: 600;
        }

        .header-text span {
            opacity: 0.9;
            font-size: 14px;
        }

        /* Content */
        .profile-body {
            padding: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        td {
            padding: 14px 10px;
            border-bottom: 1px solid #eee;
            font-size: 15px;
        }

        td:first-child {
            font-weight: 600;
            color: #555;
            width: 35%;
        }

        .badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 13px;
            color: #fff;
        }

        .male {
            background: #3498db;
        }

        .female {
            background: #e84393;
        }

        /* Buttons */
        .action-buttons {
            margin-top: 30px;
            display: flex;
            gap: 15px;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: 0.3s;
        }

        .btn-edit {
            background: #4e54c8;
            color: #fff;
        }

        .btn-edit:hover {
            background: #3b40a4;
        }

        .btn-print {
            background: #2ecc71;
            color: #fff;
        }

        .btn-print:hover {
            background: #27ae60;
        }
         .btn-cancel {
            background: #e74c3c;
            color: #fff;
        }

        .btn-print:cancel {
            background: #e74c3c;
        }

        /* Footer */
        .profile-footer {
            background: #f7f7f7;
            text-align: center;
            padding: 15px;
            font-size: 13px;
            color: #777;
        }

        @media(max-width: 600px) {
            body {
                padding: 15px;
            }

            .profile-header {
                flex-direction: column;
                text-align: center;
            }
        }
    </style>

    <script>
        function printProfile() {
            window.print();
        }

        function editProfile() {
            alert("Edit profile functionality coming soon!");
        }
    </script>

</head>
<body>

<div class="profile-container">

    <!-- Header -->
    <div class="profile-header">
        <div class="avatar">
            <%= emp.getFullName().substring(0,1).toUpperCase() %>
        </div>
        <div class="header-text">
            <h2><%= emp.getFullName() %></h2>
            <span>Employee ID: <%= emp.getEmpId() %></span>
        </div>
    </div>

    <!-- Body -->
    <div class="profile-body">
        <table>
            <tr>
                <td>Email</td>
                <td><%= emp.getEmail() %></td>
            </tr>
            <tr>
                <td>Mobile</td>
                <td><%= emp.getPhone() %></td>
            </tr>
            <tr>
                <td>Gender</td>
                <td>
                    <span class="badge <%= emp.getGender().equalsIgnoreCase("MALE") ? "male" : "female" %>">
                        <%= emp.getGender() %>
                    </span>
                </td>
            </tr>
            <tr>
                <td>Date of Birth</td>
                <td><%= emp.getDob() %></td>
            </tr>
            <tr>
                <td>Date of Joining</td>
                <td><%= emp.getDoj() %></td>
            </tr>
            <tr>
                <td>Address</td>
                <td><%= emp.getAddress() %></td>
            </tr>
            <tr>
                <td>Profile Created At</td>
                <td><%= emp.getcreated_at() %></td>
            </tr>
        </table>

        <!-- Buttons -->
        <div class="action-buttons">
            <button class="btn btn-edit" onclick="editProfile()">Edit Profile</button>
            <button class="btn btn-print" onclick="printProfile()">Print Profile</button>
           <a href="employeeDashboard.jsp"> <button class="btn btn-cancel" onclick="cancelbtn()">Cancel</button> </a>
        </div>
    </div>

    <!-- Footer -->
    <div class="profile-footer">
        © 2026 InfraTech Limited | Employee Self Service Portal
    </div>

</div>


</body>
</html>

