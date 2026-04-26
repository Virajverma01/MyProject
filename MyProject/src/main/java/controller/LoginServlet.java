package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import model.User;

@WebServlet("/login")

public class LoginServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    String username = request.getParameter("username");
	    String password = request.getParameter("password");

	    UserDAO userDAO = new UserDAO();
	    User user = userDAO.login(username, password);
	    
	    if (username == null || password == null ||
	    	    username.isEmpty() || password.isEmpty()) {
	    	    response.sendRedirect("index.jsp?error=empty");
	    	    return;
	    	}

	    if (user != null) {
	        HttpSession session = request.getSession();

	        session.setAttribute("user", user);
	        session.setAttribute("role", user.getRole());
	        session.setAttribute("empId", user.getEmpId());
	        session.setAttribute("employee_id", user.getEmpId());
	        session.setAttribute("userId", user.getId());
	        session.setAttribute("fullName", user.getFullName());
	        session.setAttribute("username", user.getUsername());

	        if ("ADMIN".equalsIgnoreCase(user.getRole())) {
	            response.sendRedirect("adminDashboard.jsp");
	        } else if ("HR".equalsIgnoreCase(user.getRole())) {
	            response.sendRedirect("hrDashboard.jsp");
	        } else {
	            response.sendRedirect("employeeDashboard.jsp");
	        }
	    } else {
	        response.sendRedirect("index.jsp?error=invalid");
	    }
	}

    }
