<%
/* ROLE SECURITY */
String role = (String) session.getAttribute("role");
if (role == null || !role.equalsIgnoreCase("HR")) {
    response.sendRedirect("../index.jsp");
    return;
}
%>

<script>
    // Block back & forward buttons
    history.pushState(null, null, location.href);
    window.onpopstate = function () {
        history.pushState(null, null, location.href);
    };
</script>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
/* CACHE CONTROL */
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

if (session.getAttribute("user") == null) {
    response.sendRedirect("../index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HR Dashboard</title>

<style>
:root{
    --primary:#16a34a;
    --bg:#f8fafc;
    --card:#ffffff;
    --text:#111827;
    --muted:#6b7280;
    --border:#e5e7eb;
}

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:"Segoe UI", Arial, sans-serif;
}

body{
    background:var(--bg);
    color:var(--text);
}

/* NAVBAR */
.navbar{
    background:#fff;
    border-bottom:1px solid var(--border);
    padding:16px 40px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.navbar h2{
    font-size:20px;
    color:var(--primary);
}

.navbar .right{
    display:flex;
    align-items:center;
    gap:20px;
}

.clock{
    font-size:14px;
    color:var(--muted);
}

.navbar a{
    text-decoration:none;
    color:var(--muted);
    font-weight:500;
}

.navbar a:hover{
    color:var(--primary);
}

/* CONTAINER */
.container{
    max-width:1200px;
    margin:30px auto;
    padding:0 20px;
}

/* HEADER */
.header{
    margin-bottom:25px;
}

.header h3{
    font-size:24px;
}

#pp{
		color: var(--primary);
		font-size:24px;
		display: inline;
}

.header p{
    color:var(--muted);
    font-size:14px;
}

/* STATS */
.stats{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:20px;
    margin-bottom:35px;
}

.stat-box{
    background:#fff;
    border:1px solid var(--border);
    border-radius:12px;
    padding:20px;
}

.stat-box span{
    font-size:13px;
    color:var(--muted);
}

.stat-box h2{
    margin-top:8px;
    font-size:28px;
    color:var(--primary);
}

/* QUICK ACTION */
.quick-action{
    background:#fff;
    border:1px dashed var(--border);
    padding:18px;
    border-radius:12px;
    margin-bottom:30px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.quick-action button{
    background:var(--primary);
    color:#fff;
    border:none;
    padding:12px 20px;
    border-radius:10px;
    cursor:pointer;
    font-size:14px;
}

/* CARDS */
.cards{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(260px,1fr));
    gap:24px;
}

.card{
    background:#fff;
    border:1px solid var(--border);
    border-radius:14px;
    padding:24px;
    cursor:pointer;
    transition:0.25s ease;
}

.card:hover{
    border-color:var(--primary);
    box-shadow:0 10px 30px rgba(0,0,0,0.08);
}

.card h4{
    font-size:16px;
}

.card p{
    margin-top:8px;
    font-size:14px;
    color:var(--muted);
}

/* FOOTER */
.footer{
    margin-top:50px;
    text-align:center;
    font-size:13px;
    color:var(--muted);
}
</style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <h2>HR Panel</h2>
    <div class="right">
        <div class="clock" id="clock"></div>
        <a href="<%= request.getContextPath() %>/adminDashboard.jsp">Dashboard</a>
        <a href="<%= request.getContextPath() %>/attendance.jsp">Attendance</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
</div>

<div class="container">

    <!-- HEADER -->
    <div class="header">
        <h3>Welcome,<p id="pp"> HR</p></h3>
        <p>Employee management & daily operations</p>
    </div>

    <!-- STATS -->
    <div class="stats">
        <div class="stat-box">
            <span>Total Employees</span>
            <h2 id="empCount">0</h2>
        </div>
        <div class="stat-box">
            <span>New Joinees (This Month)</span>
            <h2 id="newJoin">0</h2>
        </div>
        <div class="stat-box">
            <span>Leave Requests</span>
            <h2 id="leaveCount">0</h2>
        </div>
    </div>

    <!-- QUICK ACTION -->
    <div class="quick-action">
        <div>
            <strong>Quick Action</strong><br>
            Add new employee instantly
        </div>
        <button onclick="location.href='addEmployee.jsp'">+ Add Employee</button>
    </div>

    <!-- HR CARDS -->
    <div class="cards">

        <div class="card" onclick="location.href='addEmployee.jsp'">
            <h4>Add Employee</h4>
            <p>Register new employees into the system</p>
        </div>

        <div class="card" onclick="location.href='EmployeeListServlet'">
            <h4>Employee Directory</h4>
            <p>View, search and manage employee profiles</p>
        </div>

        <div class="card" onclick="location.href='attendance.jsp'">
            <h4>Attendance</h4>
            <p>Monitor and mark daily attendance</p>
        </div>

        <div class="card" onclick="location.href='hrLeaves'">
            <h4>Leave Management</h4>
            <p>Approve or reject employee leave requests</p>
        </div>

    </div>

    <div class="footer">
        © 2026 Attendance Management System | HR Module
    </div>

</div>

<script>
/* LIVE CLOCK */
function updateClock(){
    const now = new Date();
    document.getElementById("clock").innerText =
        now.toLocaleDateString() + " | " + now.toLocaleTimeString();
}
setInterval(updateClock,1000);
updateClock();

/* UI COUNTERS */
function animate(id,target){
    let i=0;
    const el=document.getElementById(id);
    const interval=setInterval(()=>{
        i++;
        el.innerText=i;
        if(i>=target) clearInterval(interval);
    },25);
}

animate("empCount", 48);
animate("newJoin", 3);
animate("leaveCount", 5);
</script>

</body>
</html>
