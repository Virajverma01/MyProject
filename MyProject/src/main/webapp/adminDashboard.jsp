<%
String role = (String) session.getAttribute("role");
if (role == null || !role.equalsIgnoreCase("ADMIN")) {
    response.sendRedirect("index.jsp");
}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
:root{
    --primary:#2563eb;
    --primary-soft:#eff6ff;
    --bg:#f1f5f9;
    --card:#ffffff;
    --text:#0f172a;
    --muted:#64748b;
    --border:#e2e8f0;
}

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Inter',sans-serif;
}

body{
    background:var(--bg);
    color:var(--text);
}

/* NAVBAR */
.navbar{
    height:64px;
    background:var(--card);
    border-bottom:1px solid var(--border);
    padding:0 36px;
    display:flex;
    align-items:center;
    justify-content:space-between;
}

.navbar h2{
    font-size:18px;
    font-weight:600;
}

.nav-right{
    display:flex;
    align-items:center;
    gap:24px;
    font-size:14px;
}

.clock{
    color:var(--muted);
}

.nav-right a{
    text-decoration:none;
    color:var(--muted);
    font-weight:500;
}

.nav-right a:hover{
    color:var(--primary);
}

/* CONTAINER */
.container{
    max-width:1280px;
    margin:30px auto;
    padding:0 24px;
}

/* HEADER */
.header{
    margin-bottom:28px;
}

.header h3{
    font-size:24px;
    font-weight:600;
}

.header span{
    color:var(--primary);
}

.header p{
    margin-top:6px;
    font-size:14px;
    color:var(--muted);
}

/* STATS */
.stats{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(240px,1fr));
    gap:20px;
    margin-bottom:36px;
}

.stat-box{
    background:var(--card);
    border:1px solid var(--border);
    border-radius:14px;
    padding:22px;
}

.stat-box span{
    font-size:13px;
    color:var(--muted);
}

.stat-box h2{
    margin-top:10px;
    font-size:30px;
    color:var(--primary);
}

/* SEARCH */
.search-box{
    margin-bottom:32px;
}

.search-box input{
    width:100%;
    padding:14px 16px;
    border-radius:12px;
    border:1px solid var(--border);
    font-size:14px;
    outline:none;
}

.search-box input:focus{
    border-color:var(--primary);
}

/* CARDS */
.cards{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
    gap:24px;
}

.card{
    background:var(--card);
    border:1px solid var(--border);
    border-radius:16px;
    padding:26px;
    cursor:pointer;
    transition:0.3s;
}

.card:hover{
    transform:translateY(-4px);
    box-shadow:0 12px 30px rgba(0,0,0,0.08);
    border-color:var(--primary);
}

.card h4{
    font-size:17px;
    font-weight:600;
}

.card p{
    margin-top:10px;
    font-size:14px;
    color:var(--muted);
}

/* FOOTER */
.footer{
    margin:50px 0 20px;
    text-align:center;
    font-size:13px;
    color:var(--muted);
}
</style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <h2>Admin Panel</h2>
    <div class="nav-right">
        <div class="clock" id="clock"></div>
        <a href="<%= request.getContextPath() %>/adminDashboard.jsp">Dashboard</a>
        <a href="<%= request.getContextPath() %>/attendance.jsp">Attendance</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
</div>

<div class="container">

    <!-- HEADER -->
    <div class="header">
        <h3>Welcome, <span>Admin</span></h3>
        <p>Overview of system activity</p>
    </div>

    <!-- STATS -->
    <div class="stats">
        <div class="stat-box">
            <span>Total Employees</span>
            <h2 id="empCount"> 0</h>
        </div>
        <div class="stat-box">
            <span>Present Today</span>
            <h2 id="presentCount">0</h2>
        </div>
        <div class="stat-box">
            <span>Absent Today</span>
            <h2 id="absentCount">0</h2>
        </div>
    </div>

    <!-- SEARCH -->
    <div class="search-box">
        <input type="text" placeholder="Search employee / attendance / reports (UI only)">
    </div>

    <!-- CARDS -->
    <div class="cards">
        <div class="card" onclick="location.href='attendance.jsp'">
            <h4>Attendance</h4>
            <p>Mark and manage daily attendance</p>
        </div>

        <div class="card" onclick="location.href='addEmployee.jsp'">
            <h4>Add Employee</h4>
            <p>Create and manage employees</p>
        </div>

        <div class="card" onclick="location.href='EmployeeListServlet'">
            <h4>Employees</h4>
            <p>View all employee records</p>
        </div>

        <div class="card" onclick="location.href='reports.jsp'">
            <h4>Reports</h4>
            <p>Attendance & performance reports</p>
        </div>
    </div>

    <div class="footer">
        © 2026 Attendance Management System
    </div>

</div>

<script>

function updateClock(){
    const now = new Date();
    document.getElementById("clock").innerText =
        now.toLocaleDateString() + " | " + now.toLocaleTimeString();
}
setInterval(updateClock,1000);
updateClock();

/* COUNTERS (UI ONLY) */
function animate(id,target){
    let i=0;
    const el=document.getElementById(id);
    const t=setInterval(()=>{
        i++;
        el.innerText=i;
        if(i>=target) clearInterval(t);
    },20);
}
animate("empCount", 48);
animate("presentCount",41);
animate("absentCount",7);
</script>

</body>
</html>
