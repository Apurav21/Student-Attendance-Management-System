package com.aip.attendance.servlet;

import com.aip.attendance.dao.AttendanceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/reports")
public class ReportServlet extends HttpServlet {
    private final AttendanceDAO attendanceDAO = new AttendanceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String requestedDate = request.getParameter("date");
            LocalDate date = (requestedDate == null || requestedDate.isBlank())
                    ? LocalDate.now() : LocalDate.parse(requestedDate);
            request.setAttribute("reportDate", date.toString());
            request.setAttribute("records", attendanceDAO.getReport(date));
            request.setAttribute("presentCount", attendanceDAO.countByStatus(date, "PRESENT"));
            request.setAttribute("absentCount", attendanceDAO.countByStatus(date, "ABSENT"));
            request.getRequestDispatcher("/WEB-INF/views/reports.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Unable to generate attendance report.", e);
        }
    }
}
