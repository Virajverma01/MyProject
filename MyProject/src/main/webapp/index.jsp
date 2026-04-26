<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
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

<% if(request.getAttribute("msg") != null) { %>
<p style="color: green;"><%=request.getAttribute("msg")%></p>
<% } %>


<%
    String errors = (String) request.getAttribute("errors");
    if (errors != null) {
%>
<script>
        alert("<%= errors %>");
    </script>
<%
    }
%>

<%
    String msg = (String) request.getAttribute("msg");
    if (msg != null) {
%>
<script>
        alert("<%= msg %>");
    </script>
<%
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login | Attendance System</title>

<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Inter', sans-serif;
}

body {
	height: 100vh;
	background: #000000d4;
	display: flex;
	align-items: center;
	justify-content: center;
}

.login-card {
	width: 380px;
	padding: 35px;
	background: rgba(255, 255, 255, 0.12);
	backdrop-filter: blur(15px);
	border-radius: 14px;
	box-shadow: 0 25px 50px rgba(0, 0, 0, .35);
	color: #fff;
}

h2 {
	text-align: center;
	margin-bottom: 6px;
}

.subtitle {
	text-align: center;
	font-size: 13px;
	opacity: .85;
	margin-bottom: 25px;
}

.input-group {
	position: relative;
	margin-bottom: 20px;
}

.input-group input {
	width: 100%;
	padding: 12px 14px;
	border: none;
	outline: none;
	background: rgba(255, 255, 255, .18);
	color: #fff;
	border-radius: 8px;
}

.input-group label {
	position: absolute;
	left: 14px;
	top: 50%;
	transform: translateY(-50%);
	font-size: 13px;
	color: #ddd;
	pointer-events: none;
	transition: .3s;
}

.input-group input:focus+label, .input-group input:not(:placeholder-shown)+label
	{
	top: -6px;
	font-size: 11px;
	background: #203a43;
	padding: 0 6px;
	border-radius: 4px;
	color: #4fc3f7;
}

.toggle-password {
	position: absolute;
	right: 12px;
	top: 50%;
	transform: translateY(-50%);
	font-size: 12px;
	cursor: pointer;
	color: #ccc;
}

.options {
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-size: 12px;
	margin-bottom: 22px;
}

.options a {
	color: #4fc3f7;
	text-decoration: none;
}

.login-btn {
	width: 100%;
	padding: 12px;
	border: none;
	border-radius: 8px;
	background: linear-gradient(135deg, #4fc3f7, #0288d1);
	color: #fff;
	font-size: 15px;
	cursor: pointer;
}

.login-btn:hover {
	box-shadow: 0 10px 25px rgba(79, 195, 247, .4);
	transform: translateY(-2px);
}

.footer {
	text-align: center;
	font-size: 11px;
	opacity: .7;
	margin-top: 18px;
}

.error {
	background: #fff;
	color: red;
	padding: 8px;
	border-radius: 6px;
	font-size: 12px;
	margin-bottom: 15px;
	text-align: center;
}

#btn {
	padding: 12px 20px;
	border: none;
	border-radius: 25px;
	cursor: pointer;
	font-size: 14px;
	font-weight: 500;
	background: #fff;
}

/* Modal Background */
.modal {
	display: none;
	position: fixed;
	inset: 0;
	background: rgba(0, 0, 0, 0.65);
	backdrop-filter: blur(8px);
	justify-content: center;
	align-items: center;
	z-index: 999;
}

/* Modal Card (Match Login Card) */
.modal-content {
	position: relative;
	width: 380px;
	padding: 30px;
	border-radius: 18px;
	text-align: center;
	background: linear-gradient(360deg, rgb(192, 192, 192), #203a43,
		rgb(192, 192, 192));
	backdrop-filter: blur(18px);
	box-shadow: 0 15px 40px rgba(0, 0, 0, 0.4);
	color: #fff;
	animation: popupFade 0.4s ease;
}

/* Close Button */
.close-btn {
	position: absolute;
	right: 18px;
	top: 12px;
	font-size: 22px;
	cursor: pointer;
	color: #ccc;
	transition: 0.3s;
}

.close-btn:hover {
	color: #fff;
}

/* Title */
.modal-content h2 {
	margin-bottom: 6px;
	font-weight: 600;
}

.subtitle {
	font-size: 13px;
	opacity: 0.75;
	margin-bottom: 20px;
}

/* Input Group */
.input-group {
	position: relative;
	margin-bottom: 18px;
}

/* Inputs */
.input-group input {
	width: 100%;
	padding: 12px 40px 12px 12px;
	border-radius: 8px;
	border: none;
	outline: none;
	background: rgba(255, 255, 255, 0.15);
	color: #fff;
	font-size: 14px;
}

.input-group input::placeholder {
	color: transparent;
}

/* Floating Labels */
.input-group label {
	position: absolute;
	left: 12px;
	top: 12px;
	font-size: 13px;
	color: #ccc;
	pointer-events: none;
	transition: 0.3s;
}

.input-group input:focus+label, .input-group input:valid+label {
	top: -8px;
	left: 8px;
	font-size: 11px;
	background: #1f3b45;
	padding: 2px 6px;
	border-radius: 4px;
	color: #4fc3f7;
}

/* Eye Toggle */
.toggle {
	position: absolute;
	right: 12px;
	top: 12px;
	cursor: pointer;
}

/* Strength Text */
#strength {
	font-size: 12px;
	margin-bottom: 10px;
	text-align: left;
}

/* Update Button (Same Style as Login) */
.submit-btn {
	width: 100%;
	padding: 12px;
	border-radius: 8px;
	border: none;
	background: linear-gradient(to right, #4facfe, #00c6ff);
	color: white;
	font-weight: 600;
	cursor: pointer;
	transition: 0.3s;
}

.submit-btn:hover {
	transform: scale(1.05);
}

/* Cancel Button */
.cancel-btn {
	width: 100%;
	padding: 10px;
	margin-top: 10px;
	border-radius: 8px;
	border: none;
	background: rgba(255, 255, 255, 0.15);
	cursor: pointer;
	transition: 0.3s;
}

.cancel-btn:hover {
	background: rgba(255, 255, 255, 0.25);
}

/* Animation */
@
keyframes popupFade {from { opacity:0;
	transform: translateY(30px);
}

to {
	opacity: 1;
	transform: translateY(0);
}
}
</style>
</head>

<body>

	<div class="login-card">
		<h2>Welcome</h2>
		<div class="subtitle">Attendance Management System</div>

		<% String error = request.getParameter("error");
       if("invalid".equals(error)){ %>
		<div class="error">Invalid username or password</div>
		<% } %>

		<form action="login" method="post" onsubmit="saveRememberMe()">

			<div class="input-group">
				<input type="text" id="username" name="username" required
					placeholder=" "> <label>Username</label>
			</div>

			<div class="input-group">
				<input type="password" id="password" name="password" required
					placeholder=" "> <label>Password</label> <span
					class="toggle-password" onclick="togglePassword()">SHOW</span>
			</div>

			<div class="options">
				<label> <input type="checkbox" id="rememberMe">
					Remember me
				</label> <a href="#" onclick="openModal()">Forgot password?</a>
			</div>

			<button type="submit" class="login-btn">Sign In</button>
		</form>

		<div class="footer">© 2026 Attendance Mangement</div>
	</div>


	<!-- Forgot Password Modal -->
	<div id="forgotModal" class="modal">
		<div class="modal-content">
			<span class="close-btn" onclick="closeModal()">&times;</span>

			<h2>Reset Password</h2>
			<p class="subtitle">Enter your registered email and set a new
				password</p>

			<form action="<%=request.getContextPath()%>/ForgotPasswordServlet"
				method="post" onsubmit="return validateForm()">

				<div class="input-group">
					<input type="email" name="email" id="email" required> <label>Registered
						Email</label>
				</div>

				<div class="input-group">
					<input type="password" name="newPassword" id="newPassword" required
						onkeyup="checkStrength()"> <label>New Password</label> <span
						class="toggle" onclick="togglePassword('newPassword')">👁</span>
				</div>

				<div id="strength"></div>

				<div class="input-group">
					<input type="password" name="confirmPassword" id="confirmPassword"
						required> <label>Confirm Password</label> <span
						class="toggle" onclick="togglePassword('confirmPassword')">👁</span>
				</div>

				<button type="submit" class="submit-btn">Update Password</button>
				<button type="button" onclick="closeModal()" class="cancel-btn">Cancel</button>
			</form>
		</div>
	</div>

	<script>
function togglePassword(){
    const p = document.getElementById("password");
    p.type = p.type === "password" ? "text" : "password";
}

/* Remember Me */
window.onload = function(){
    if(localStorage.getItem("rememberUser")){
        document.getElementById("username").value = localStorage.getItem("rememberUser");
        document.getElementById("rememberMe").checked = true;
    }
}

function saveRememberMe(){
    if(document.getElementById("rememberMe").checked){
        localStorage.setItem("rememberUser",
            document.getElementById("username").value);
    } else {
        localStorage.removeItem("rememberUser");
    }
}

/* Forgot modal */
function openModal() {
    document.getElementById("forgotModal").style.display = "flex";
}

function closeModal() {
    document.getElementById("forgotModal").style.display = "none";
}
</script>
	<script>
function closeModal() {
    document.getElementById("forgotModal").style.display = "none";
}

function togglePassword(id) {
    const field = document.getElementById(id);
    field.type = field.type === "password" ? "text" : "password";
}

function checkStrength() {
    const password = document.getElementById("newPassword").value;
    const strength = document.getElementById("strength");

    if (password.length < 6) {
        strength.innerHTML = "Weak Password";
        strength.style.color = "red";
    } else if (password.match(/[A-Z]/) && password.match(/[0-9]/)) {
        strength.innerHTML = "Strong Password";
        strength.style.color = "lightgreen";
    } else {
        strength.innerHTML = "Medium Password";
        strength.style.color = "orange";
    }
}

function validateForm() {
    const pass = document.getElementById("newPassword").value;
    const confirm = document.getElementById("confirmPassword").value;

    if (pass !== confirm) {
        alert("Passwords do not match!");
        return false;
    }

    return true;
}
</script>

</body>
</html>
