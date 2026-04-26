package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.DBConnection;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement check = con.prepareStatement(
                "SELECT * FROM users WHERE username=?");
            check.setString(1, email);
            ResultSet rs = check.executeQuery();

            if (rs.next()) {

                PreparedStatement ps = con.prepareStatement(
                    "UPDATE users SET password=? WHERE username=?");

                ps.setString(1, newPassword);
                ps.setString(2, email);

                ps.executeUpdate();

                request.setAttribute("msg", " ");

            } else {
                request.setAttribute("errors", "Email not registered");
            }

            // 🔥 THIS LINE IS IMPORTANT
            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}