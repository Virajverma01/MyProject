<%@ page import="java.sql.*"%>
<%@ page import="util.DBConnection"%>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<script>
	history.pushState(null, null, location.href);
	window.onpopstate = function() {
		history.pushState(null, null, location.href);
	};
</script>

<style>
body {
	margin: 0;
	font-family: Segoe UI, Arial, sans-serif;
	background: #f1f3f6;
}

/* Header */
.header {
	width: 100%;
	background: #2c3e50;
	color: white;
	padding: 12px 20px;
	display: flex;
	gap: 40rem;
	align-items: center;
}

.header h2 {
	margin: 0;
}

/* Back button */
.backBtn {
	background: #3498db;
	border: none;
	padding: 8px 16px;
	color: white;
	border-radius: 5px;
	cursor: pointer;
	text-decoration: none;
}

.backBtn:hover {
	background: #2980b9;
}

/* Container */
.container {
	width: 95%;
	margin: 30px auto;
}

/* Table styling */
table {
	width: 100%;
	border-collapse: collapse;
	background: white;
}

th {
	background: #34495e;
	color: white;
	padding: 12px;
	text-align: left;
}

td {
	padding: 12px;
	border-bottom: 1px solid #ddd;
}

tr:hover {
	background: #f7f7f7;
}

/* Status colors */
.approved {
	color: green;
	font-weight: bold;
}

.rejected {
	color: red;
	font-weight: bold;
}

.pending {
	color: orange;
	font-weight: bold;
}
</style>

<div class="header">
	<a href="employeeDashboard.jsp" button class="backBtn"
		onclick="history.back()">Back
		</button>
	</a>
	<h2>Leave Requests</h2>
</div>

<div class="container">

	<table>

		<tr>
			<th>Leave Type</th>
			<th>From</th>
			<th>To</th>
			<th>Status</th>
			<th>HR Comment</th>
		</tr>

		<%
		Integer empId = (Integer) session.getAttribute("employee_id");

		if (empId == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con
				.prepareStatement("SELECT * FROM leave_requests WHERE employee_id=? ORDER BY applied_at DESC");

		ps.setInt(1, empId);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {

			String status = rs.getString("status");
			String cls = "pending";

			if ("APPROVED".equals(status))
				cls = "approved";
			else if ("REJECTED".equals(status))
				cls = "rejected";
		%>

		<tr>

			<td><%=rs.getString("leave_type")%></td>
			<td><%=rs.getDate("start_date")%></td>
			<td><%=rs.getDate("end_date")%></td>

			<td class="<%=cls%>"><%=status%></td>

			<td><%=rs.getString("hr_comment") == null ? "—" : rs.getString("hr_comment")%>
			</td>

		</tr>

		<%
		}
		%>

	</table>

</div>