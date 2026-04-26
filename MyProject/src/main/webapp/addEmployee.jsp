<script>
    // Block back & forward buttons
    history.pushState(null, null, location.href);
    window.onpopstate = function () {
        history.pushState(null, null, location.href);
    };
</script>
<%
String role = (String) session.getAttribute("role");
if (role == null || (!role.equalsIgnoreCase("ADMIN") && !role.equalsIgnoreCase("HR"))) {
	response.sendRedirect(request.getContextPath() + "/index.jsp");
	return;
}
%>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Employee</title>

<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
body {
	font-family: 'Poppins', sans-serif;
	background: linear-gradient(120deg, #eef2f3, #d9e4ec);
}

.container {
	max-width: 900px;
	margin: 40px auto;
}

.btn-group {
	margin-top: 25px;
	display: flex;
	gap: 15px;
	align-items: stretch;
}

.btn-primary {
	flex: 1;
	padding: 13px;
	border: none;
	border-radius: 10px;
	background: #3498db;
	color: #fff;
	font-size: 16px;
	cursor: pointer;
	text-align: center;
}

.btn-primary:hover {
	background: #2980b9;
}

.btn-cancel {
	flex: 1;
	padding: 13px;
	border: none;
	border-radius: 10px;
	background: #e74c3c;
	color: #fff;
	font-size: 16px;
	cursor: pointer;
	text-align: center;
	text-decoration: none;
}

.btn-cancel:hover {
	background: #c0392b;
}

.card {
	background: #fff;
	padding: 30px;
	border-radius: 14px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .12);
}

h3 {
	text-align: center;
	color: #2c3e50;
}

.form-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 35px;
}

label {
	font-size: 14px;
	font-weight: 500;
}

input, select, textarea {
	width: 100%;
	padding: 12px;
	border-radius: 10px;
	border: 1px solid #ccc;
}

textarea {
	height: 100px;
}

.full {
	grid-column: span 2;
}
</style>
</head>

<body>
	<div class="container">
		<div class="card">
			<h3>
				<i class="fa fa-user-plus"></i> Add Employee
			</h3>

			<form action="<%=request.getContextPath()%>/AddEmployeeServlet"
				method="post">

				<div class="form-grid">
					<div>
						<label>Full Name *</label> <input type="text" name="fullName"
							required>
					</div>

					<div>
						<label>Email *</label> <input type="email" name="email" required>
					</div>

					<div>
						<label>Mobile *</label> <input type="text" name="mobile" required>
					</div>

					<div>
						<label>Gender</label> <select name="gender">
							<option>MALE</option>
							<option>FEMALE</option>
							<option>OTHER</option>
						</select>
					</div>

					<div>
						<label>Date of Birth</label> <input type="date" name="dob">
					</div>

					<div>
						<label>Date of Joining *</label> <input type="date" name="doj"
							required>
					</div>

					<div class="full">
						<label>Address</label>
						<textarea name="address"></textarea>
					</div>
				</div>

				<div class="btn-group">
					<button type="submit" class="btn-primary">
						<i class="fa fa-check-circle"></i> Create Employee
					</button>

					<a
						href="<%=role.equalsIgnoreCase("ADMIN") ? request.getContextPath() + "/adminDashboard.jsp"
		: request.getContextPath() + "/hrDashboard.jsp"%>"
						class="btn-cancel"> <i class="fa fa-times-circle"></i> Cancel
					</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
