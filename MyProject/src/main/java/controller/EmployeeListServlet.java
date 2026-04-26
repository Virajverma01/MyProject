package controller;

import dao.EmployeeDAO;
import model.Employee;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/EmployeeListServlet")
public class EmployeeListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EmployeeDAO dao = new EmployeeDAO();
        List<Employee> list = dao.getAllEmployees();
        

        request.setAttribute("employees", list);
        request.getRequestDispatcher("employees.jsp").forward(request, response);
    }
    
    
}
