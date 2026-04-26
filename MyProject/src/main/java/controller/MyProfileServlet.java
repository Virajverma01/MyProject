package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import dao.EmployeeDAO;
import model.Employee;

@WebServlet("/employee/myProfile")
public class MyProfileServlet extends HttpServlet {

	private EmployeeDAO employeeDAO;

	@Override
	public void init() {
		employeeDAO = new EmployeeDAO();
	}

	// ✅ LOAD PROFILE (VIEW)
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		// 🔐 Session check
		if (session == null || session.getAttribute("empId") == null) {
			response.sendRedirect("../login.jsp");
			return;
		}

		int empId = (Integer) session.getAttribute("empId");

		Employee emp = employeeDAO.getEmployeeById(empId);
		request.setAttribute("employee", emp);

		request.getRequestDispatcher("/employee/myProfile.jsp").forward(request, response);
	}

}