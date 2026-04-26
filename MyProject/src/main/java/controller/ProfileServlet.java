package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.EmployeeDAO;
import model.Employee;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        HttpSession session = request.getSession(false);


        // session check
        if (session == null || session.getAttribute("empId") == null) {
           // System.out.println("No session or empId missing");
            response.sendRedirect("login.jsp");
            return;
        }

        int empId = (int) session.getAttribute("empId");
       // System.out.println("empId = " + empId);

        EmployeeDAO employeeDAO = new EmployeeDAO();
        Employee emp = employeeDAO.getEmployeeById(empId);

        if (emp == null) {
          //  System.out.println("Employee NOT found in DB");
            request.setAttribute("error", "Employee profile not found");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

      //  System.out.println("Employee FOUND: " + emp.getFullName());

        request.setAttribute("emp", emp);
        request.getRequestDispatcher("myProfile.jsp").forward(request, response);
    }
}
