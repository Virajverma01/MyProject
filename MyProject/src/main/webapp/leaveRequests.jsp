<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="java.sql.*"%>
<%@ page import="util.DBConnection"%>

<script>
	history.pushState(null, null, location.href);
	window.onpopstate = function() {
		history.pushState(null, null, location.href);
	};
</script>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<%
HttpSession session1 = request.getSession(false);
if (session1 == null || session1.getAttribute("role") == null) {
	response.sendRedirect(request.getContextPath() + "/index.jsp");
	return;
}

String role = (String) session1.getAttribute("role");
if (!"ADMIN".equalsIgnoreCase(role) && !"HR".equalsIgnoreCase(role)) {
	response.sendRedirect("unauthorized.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Leave Requests</title>

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
	box-shadow: 0 6px 14px rgba(0, 0, 0, 0.1);
}

h2 {
	margin-bottom: 15px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

th {
	background: #f4f6f9;
}

.status {
	font-weight: bold;
}

.btn-cancel {
	border-radius: 5px;
	padding: 10px;
	background: #e74c3c;
	color: #fff;
	font-size: 16px;
	cursor: pointer;
	text-decoration: none;
}

#con {
	gap: 40rem;
	marg
	
}

input[name="hr_comment"] {
	padding: 6px;
	border-radius: 6px;
	border: 1px solid #ccc;
	width: 160px;
}

.approve:hover {
	background: #218838;
}

.reject:hover {
	background: #c82333;
}

tr:hover {
	background: #f9fafc;
}

.PENDING {
	color: orange;
}

.APPROVED {
	color: green;
}

.REJECTED {
	color: red;
}

.action-btn {
	padding: 6px 10px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.approve {
	background: #28a745;
	color: #fff;
}

.reject {
	background: #dc3545;
	color: #fff;
}

.hr_comment {
	width: 220px; 
	padding: 8px 10px; 
	border-radius: 6px;
	border: 1px solid #ccc;
	font-size: 14px;
	outline: none;
	transition: all 0.3s ease;
}


.hr_comment:hover {
	border-color: #4CAF50;
	box-shadow: 0 0 5px rgba(76, 175, 80, 0.3);
}

.hr_comment:focus {
	border-color: #4CAF50;
	box-shadow: 0 0 5px rgba(76, 175, 80, 0.3);
}

#h2{
	margin-left: 45rem;
	margin-top: -1.2rem;
}	

</style>
</head>
<body>

	<div class="container">

		<div id=con>
			<a
				href="<%=role.equalsIgnoreCase("ADMIN") ? request.getContextPath() + "/adminDashboard.jsp"
		: request.getContextPath() + "/hrDashboard.jsp"%>"
				class="btn-cancel"> <i class="fa fa-times-circle"></i> Back
			</a>
		</div>
		<h2 id=h2>Leave Requests</h2>
		<table>
			<tr>
				<th>ID</th>
				<th>Employee</th>
				<th>Type</th>
				<th>From</th>
				<th>To</th>
				<th>Reason</th>
				<th>Status</th>
				<th>Action</th>
			</tr>

			<%
			List<model.LeaveRequest> leaves = (List<model.LeaveRequest>) request.getAttribute("leaves");

			if (leaves != null && !leaves.isEmpty()) {
				for (model.LeaveRequest lr : leaves) {
			%>

			<tr>
				<td><%=lr.getId()%></td>
				<td><%=lr.getEmployeeName()%></td>
				<td><%=lr.getLeaveType()%></td>
				<td><%=lr.getStartDate()%></td>
				<td><%=lr.getEndDate()%></td>
				<td><%=lr.getReason()%></td>
				<td class="status <%=lr.getStatus()%>"><%=lr.getStatus()%></td>

				<td>
					<%
					if ("PENDING".equalsIgnoreCase(lr.getStatus())) {
					%>

					<form action="leaveAction" method="post">

						<input type="hidden" name="leave_id" value="<%=lr.getId()%>">

						<input type="text" class="hr_comment" placeholder="Add comment...">


						<button class="action-btn approve" name="action" value="APPROVED">
							Approve</button>

						<button class="action-btn reject" name="action" value="REJECTED">
							Reject</button>

					</form> <%
 } else {
 %> <%=lr.getStatus()%> <%
 }
 %>

				</td>
			</tr>

			<%
			}
			} else {
			%>

			<tr>
				<td colspan="8">No leave requests found</td>
			</tr>

			<%
			}
			%>

		</table>
	</div>

</body>
</html>
