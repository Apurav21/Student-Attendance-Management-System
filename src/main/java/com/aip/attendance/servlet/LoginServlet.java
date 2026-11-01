package com.aip.attendance.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    // Demonstration credentials for this college mini-project. Change before any real deployment.
    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "admin123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password)) {
            HttpSession session = request.getSession(true);
            session.setAttribute("adminLoggedIn", true);
            session.setAttribute("adminName", "Administrator");
            session.setMaxInactiveInterval(30 * 60);
            response.sendRedirect(request.getContextPath() + "/dashboard");
        } else {
            request.setAttribute("error", "Invalid username or password. Please try again.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
