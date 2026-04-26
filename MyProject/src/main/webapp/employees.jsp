<%@ page import="java.util.*, model.Employee" %>

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
String role = (String) session.getAttribute("role");
if (role == null || (!role.equalsIgnoreCase("ADMIN") && !role.equalsIgnoreCase("HR"))) {
	response.sendRedirect(request.getContextPath() + "/index.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Employee Records</title>

<style>
    body {
        font-family: "Segoe UI", Arial, sans-serif;
        background: #eef2f7;
        padding: 20px;
    }

    .container {
        background: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 6px 14px rgba(0,0,0,0.08);
    }

    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
    }

    h2 {
        margin: 0;
        color: #2c3e50;
    }

    .count {
        background: #3498db;
        color: #fff;
        padding: 6px 14px;
        border-radius: 20px;
        font-size: 13px;
    }
    
    .btn-cancel {
    display: flex;
    border-radius: 5px;
    padding: 5px;
	background: #e74c3c;
	color: #fff;
	font-size: 16px;
	cursor: pointer;
	text-align: center;
	text-decoration: none;
}

    .search-box {
        margin: 15px 0;
    }

    .search-box input {
        width: 100%;
        padding: 10px;
        border-radius: 6px;
        border: 1px solid #ccc;
        font-size: 14px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        table-layout: fixed; /* 🔥 IMPORTANT */
    }

    th, td {
        padding: 10px;
        font-size: 13px;
        vertical-align: middle;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    th {
        background: #2c3e50;
        color: #fff;
        text-align: center;
    }

    td {
        border-bottom: 1px solid #eee;
    }

    tr:hover {
        background: #f1f7ff;
    }

    /* COLUMN ALIGNMENT */
    .col-id,
    .col-dob,
    .col-doj,
    .col-status {
        text-align: center;
    }

    .col-name,
    .col-email,
    .col-address {
        text-align: left;
    }
    
    .col-phone {
    width: 12%;
    text-align: center;
}

    /* COLUMN WIDTHS */
    .col-id { width: 6%; }
    .col-name { width: 18%; }
    .col-email { width: 20%; }
    .col-dob { width: 10%; }
    .col-doj { width: 10%; }
    .col-address { width: 18%; }
    .col-status { width: 12%; }

    .status {
        padding: 4px 12px;
        border-radius: 12px;
        font-size: 12px;
        color: #fff;
        background: #27ae60;
        display: inline-block;
    }

    .msg {
        text-align: center;
        padding: 20px;
        font-weight: bold;
    }

    .msg.null { color: #c0392b; }
    .msg.empty { color: #e67e22; }
</style>

<script>
function filterEmployees() {
    let input = document.getElementById("searchInput").value.toLowerCase();
    let rows = document.querySelectorAll("#empTable tbody tr");

    rows.forEach(row => {
        let text = row.innerText.toLowerCase();
        row.style.display = text.includes(input) ? "" : "none";
    });
}
</script>

</head>
<body>

<div class="container">

<div class="header">

 <a
						href="<%=role.equalsIgnoreCase("ADMIN") ? request.getContextPath() + "/adminDashboard.jsp"
		: request.getContextPath() + "/hrDashboard.jsp"%>"
						class="btn-cancel"> <i class="fa fa-times-circle"></i> Back
					</a>

    <h2>Employee Master Records</h2>
    <%
        List<Employee> list = (List<Employee>) request.getAttribute("employees");
        int count = (list != null) ? list.size() : 0;
    %>
   
   
					
					 <div class="count">Total Employees: <%= count %></div>
</div>

<div class="search-box">
    <input type="text" id="searchInput"
           placeholder="Search by name, email, address..."
           onkeyup="filterEmployees()">
</div>

<table id="empTable">
<thead>
<tr>
    <th class="col-id">ID</th>
    <th class="col-name">Employee Name</th>
    <th class="col-email">Email</th>
    <th class="col-phone">Phone Number</th>
    <th class="col-dob">DOB</th>
    <th class="col-doj">DOJ</th>
    <th class="col-address">Address</th>
    <th class="col-status">Status</th>
</tr>
</thead>
<tbody>

<%
if (list == null) {
%>
<tr>
    <td colspan="7" class="msg null">
        EMPLOYEE LIST IS NULL (Servlet not called)
    </td>
</tr>
<%
} else if (list.isEmpty()) {
%>
<tr>
    <td colspan="7" class="msg empty">
        NO EMPLOYEES FOUND IN DATABASE
    </td>
</tr>
<%
} else {
    for (Employee e : list) {
%>
<tr>
    <td class="col-id"><%= e.getEmpId() %></td>
    <td class="col-name"><%= e.getFullName() %></td>
    <td class="col-email"><%= e.getEmail() %></td>
    <td class="col-phone"><%= e.getPhone() %></td>
    <td class="col-dob"><%= e.getDob() %></td>
    <td class="col-doj"><%= e.getDoj() %></td>
    <td class="col-address"><%= e.getAddress() %></td>
    <td class="col-status"><span class="status">Active</span></td>
</tr>

<%
    }
}
%>

</tbody>
</table>

</div>
</body>
</html>
