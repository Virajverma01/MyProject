<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<form action="<%= request.getContextPath() %>/ApplyLeaveServlet" method="post">

<% 
String role = (String) session.getAttribute("role"); 
Integer empId = (Integer) session.getAttribute("employee_id");
%>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies
%>

<!DOCTYPE html>
<html>
<head>
<title>Apply Leave</title>

<style>
    body {
        margin: 0;
        font-family: "Inter", "Segoe UI", Arial, sans-serif;
        background: #f8fafc;
        color: #1f2937;
    }

    .page-wrapper {
        max-width: 1100px;
        margin: 30px auto;
        padding: 0 20px;
    }

    .page-title {
        font-size: 22px;
        font-weight: 600;
        margin-bottom: 6px;
    }

    .page-subtitle {
        color: #6b7280;
        font-size: 14px;
        margin-bottom: 24px;
    }

    .card {
        background: #ffffff;
        border: 1px solid #e5e7eb;
        border-radius: 8px;
        padding: 24px;
    }

    .form-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
    }

    .form-group.full {
        grid-column: span 2;
    }

    label {
        font-size: 13px;
        font-weight: 500;
        margin-bottom: 6px;
        color: #374151;
    }

    select, input, textarea {
        padding: 10px 12px;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        font-size: 14px;
        background: #fff;
    }

    select:focus, input:focus, textarea:focus {
        outline: none;
        border-color: #4f6ef7;
    }

    textarea {
        resize: none;
        min-height: 90px;
    }

    .info-box {
        margin-top: 18px;
        padding: 12px 16px;
        background: #f1f5ff;
        border: 1px solid #dbe3ff;
        border-radius: 6px;
        font-size: 14px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .info-box span {
        font-weight: 600;
        color: #1e3a8a;
    }

    .error {
        color: #dc2626;
        font-size: 13px;
        margin-top: 6px;
        display: none;
    }

    .actions {
        display: flex;
        justify-content: flex-end;
        margin-top: 24px;
        gap: 12px;
    }

    .btn {
        padding: 10px 20px;
        font-size: 14px;
        border-radius: 6px;
        cursor: pointer;
        border: none;
    }

    .btn-primary {
        background: #4f6ef7;
        color: #ffffff;
    }

    .btn-primary:hover {
        background: #425bd4;
    }

    .btn-secondary {
        background: #e74c3c;
        color: #ffffff;
        border: 1px solid #d1d5db;
        text-decoration: none;
    }

    @media (max-width: 768px) {
        .form-grid {
            grid-template-columns: 1fr;
        }
        .form-group.full {
            grid-column: span 1;
        }
    }
</style>

</head>
<body>

<div class="page-wrapper">

    <div class="page-title">Apply Leave</div>
    <div class="page-subtitle">
        Submit your leave request for HR approval
    </div>

    <div class="card">

            <div class="form-grid">

                <div class="form-group">
                    <label>Leave Type</label>
                    <select name="leave_type" required>
                        <option value="">Select leave type</option>
                        <option>Casual Leave</option>
                        <option>Sick Leave</option>
                        <option>Earned Leave</option>
                        <option value="Unpaid Leave">Unpaid Leave</option>
						<option value="Half Day">Half Day</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Reason</label>
                    <input type="text" name="reason" placeholder="Short reason" required>
                </div>

                <div class="form-group">
                    <label>Start Date</label>
                    <input type="date" name="start_date" id="startDate" onchange="calculateDays()" required>
                </div>

                <div class="form-group">
                    <label>End Date</label>
                    <input type="date" name="end_date" id="endDate" onchange="calculateDays()" required>
                    <div class="error" id="dateError">
                        End date cannot be before start date
                    </div>
                </div>

                <div class="form-group full">
                    <textarea name="description" placeholder="Detailed reason for leave (optional)"></textarea>
                </div>

            </div>

            <div class="info-box">
                <div>Total Leave Days</div>
                <span id="totalDays">0</span>
            </div>

            <div class="actions">
           <a href="employeeDashboard.jsp" button type="reset" class="btn btn-secondary">Cancel</button> </a>
                <button type="submit" class="btn btn-primary">Submit Request</button>
            </div>

        </form>
    </div>

</div>

<script>
    function calculateDays() {
        const start = document.getElementById("startDate").value;
        const end = document.getElementById("endDate").value;

        if (start && end) {
            const s = new Date(start);
            const e = new Date(end);

            const diff = (e - s) / (1000 * 60 * 60 * 24) + 1;

            if (diff > 0) {
                document.getElementById("totalDays").innerText = diff;
                document.getElementById("dateError").style.display = "none";
            }
        }
    }

    function validateDates() {
        const start = document.getElementById("startDate").value;
        const end = document.getElementById("endDate").value;

        if (new Date(end) < new Date(start)) {
            document.getElementById("dateError").style.display = "block";
            return false;
        }
        return true;
    }
</script>

</body>
</html>
