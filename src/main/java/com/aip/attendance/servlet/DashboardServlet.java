package com.aip.attendance.servlet;

import com.aip.attendance.dao.AttendanceDAO;
import com.aip.attendance.dao.StudentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private final StudentDAO studentDAO = new StudentDAO();
    private final AttendanceDAO attendanceDAO = new AttendanceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            LocalDate today = LocalDate.now();
            int total = studentDAO.count();
            int present = attendanceDAO.countByStatus(today, "PRESENT");
            int absent = attendanceDAO.countByStatus(today, "ABSENT");
            request.setAttribute("totalStudents", total);
            request.setAttribute("presentCount", present);
            request.setAttribute("absentCount", absent);
            request.setAttribute("notMarkedCount", Math.max(0, total - present - absent));
            request.setAttribute("today", today.toString());
            request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Unable to load dashboard. Check the database connection.", e);
        }
    }
}
