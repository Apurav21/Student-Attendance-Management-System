package com.aip.attendance.dao;

import com.aip.attendance.model.Student;
import com.aip.attendance.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    public List<Student> findAll() throws SQLException {
        String sql = "SELECT id, roll_no, name, course, semester, email FROM students ORDER BY roll_no";
        List<Student> students = new ArrayList<>();
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                students.add(mapStudent(rs));
            }
        }
        return students;
    }

    public Student findById(int id) throws SQLException {
        String sql = "SELECT id, roll_no, name, course, semester, email FROM students WHERE id = ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapStudent(rs);
            }
        }
        return null;
    }

    public void insert(Student student) throws SQLException {
        String sql = "INSERT INTO students (roll_no, name, course, semester, email) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            setStudentParameters(ps, student);
            ps.executeUpdate();
        }
    }

    public void update(Student student) throws SQLException {
        String sql = "UPDATE students SET roll_no = ?, name = ?, course = ?, semester = ?, email = ? WHERE id = ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            setStudentParameters(ps, student);
            ps.setInt(6, student.getId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM students WHERE id = ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public int count() throws SQLException {
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM students");
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private Student mapStudent(ResultSet rs) throws SQLException {
        return new Student(rs.getInt("id"), rs.getString("roll_no"), rs.getString("name"),
                rs.getString("course"), rs.getInt("semester"), rs.getString("email"));
    }

    private void setStudentParameters(PreparedStatement ps, Student student) throws SQLException {
        ps.setString(1, student.getRollNo());
        ps.setString(2, student.getName());
        ps.setString(3, student.getCourse());
        ps.setInt(4, student.getSemester());
        ps.setString(5, student.getEmail());
    }
}
