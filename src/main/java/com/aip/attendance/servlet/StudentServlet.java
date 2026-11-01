package com.aip.attendance.servlet;

import com.aip.attendance.dao.StudentDAO;
import com.aip.attendance.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/students")
public class StudentServlet extends HttpServlet {
    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            if ("new".equals(action)) {
                request.setAttribute("student", new Student());
                request.setAttribute("formTitle", "Add Student");
                request.getRequestDispatcher("/WEB-INF/views/student-form.jsp").forward(request, response);
                return;
            }
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Student student = studentDAO.findById(id);
                if (student == null) {
                    response.sendRedirect(request.getContextPath() + "/students?error=notfound");
                    return;
                }
                request.setAttribute("student", student);
                request.setAttribute("formTitle", "Edit Student");
                request.getRequestDispatcher("/WEB-INF/views/student-form.jsp").forward(request, response);
                return;
            }
            request.setAttribute("students", studentDAO.findAll());
            request.setAttribute("error", request.getParameter("error"));
            request.getRequestDispatcher("/WEB-INF/views/students.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/students");
        } catch (Exception e) {
            throw new ServletException("Unable to load student records.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        try {
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                studentDAO.delete(id);
                response.sendRedirect(request.getContextPath() + "/students?message=deleted");
                return;
            }

            String rollNo = clean(request.getParameter("rollNo"));
            String name = clean(request.getParameter("name"));
            String course = clean(request.getParameter("course"));
            String semesterText = request.getParameter("semester");
            String email = clean(request.getParameter("email"));
            int semester = Integer.parseInt(semesterText);

            if (rollNo.isBlank() || name.isBlank() || course.isBlank() || semester < 1 || semester > 10) {
                response.sendRedirect(request.getContextPath() + "/students?action=new&error=invalid");
                return;
            }

            Student student = new Student();
            student.setRollNo(rollNo);
            student.setName(name);
            student.setCourse(course);
            student.setSemester(semester);
            student.setEmail(email);

            if ("update".equals(action)) {
                student.setId(Integer.parseInt(request.getParameter("id")));
                studentDAO.update(student);
                response.sendRedirect(request.getContextPath() + "/students?message=updated");
            } else {
                studentDAO.insert(student);
                response.sendRedirect(request.getContextPath() + "/students?message=added");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/students?action=new&error=invalid");
        } catch (Exception e) {
            if (e instanceof java.sql.SQLIntegrityConstraintViolationException) {
                response.sendRedirect(request.getContextPath() + "/students?action=new&error=duplicate");
            } else {
                throw new ServletException("Unable to save student record.", e);
            }
        }
    }

    private String clean(String value) {
        return value == null ? "" : value.trim();
    }
}
