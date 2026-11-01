package com.aip.attendance.servlet;

import com.aip.attendance.dao.AttendanceDAO;
import com.aip.attendance.dao.StudentDAO;
import com.aip.attendance.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/attendance")
public class AttendanceServlet extends HttpServlet {
    private final StudentDAO studentDAO = new StudentDAO();
    private final AttendanceDAO attendanceDAO = new AttendanceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            LocalDate date = parseDate(request.getParameter("date"));
            request.setAttribute("attendanceDate", date.toString());
            request.setAttribute("students", studentDAO.findAll());
            request.setAttribute("statuses", attendanceDAO.findStatusesByDate(date));
            request.getRequestDispatcher("/WEB-INF/views/attendance.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Unable to load attendance page.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            LocalDate date = parseDate(request.getParameter("date"));
            List<Student> students = studentDAO.findAll();
            Map<Integer, String> statuses = new HashMap<>();
            for (Student student : students) {
                String status = request.getParameter("status_" + student.getId());
                if (!"PRESENT".equals(status) && !"ABSENT".equals(status)) {
                    throw new IllegalArgumentException("Choose Present or Absent for every student.");
                }
                statuses.put(student.getId(), status);
            }
            attendanceDAO.saveAttendance(date, statuses);
            response.sendRedirect(request.getContextPath() + "/attendance?date=" + date + "&message=saved");
        } catch (IllegalArgumentException e) {
            response.sendRedirect(request.getContextPath() + "/attendance?error=invalid");
        } catch (Exception e) {
            throw new ServletException("Unable to save attendance.", e);
        }
    }

    private LocalDate parseDate(String value) {
        return (value == null || value.isBlank()) ? LocalDate.now() : LocalDate.parse(value);
    }
}
