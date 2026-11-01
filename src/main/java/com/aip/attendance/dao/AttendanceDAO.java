package com.aip.attendance.dao;

import com.aip.attendance.model.AttendanceRecord;
import com.aip.attendance.util.DatabaseConnection;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AttendanceDAO {
    public Map<Integer, String> findStatusesByDate(LocalDate date) throws SQLException {
        String sql = "SELECT student_id, status FROM attendance WHERE attendance_date = ?";
        Map<Integer, String> statuses = new HashMap<>();
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, Date.valueOf(date));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) statuses.put(rs.getInt("student_id"), rs.getString("status"));
            }
        }
        return statuses;
    }

    /** Saves every student's status for the selected date; an existing record is updated. */
    public void saveAttendance(LocalDate date, Map<Integer, String> statuses) throws SQLException {
        String sql = "INSERT INTO attendance (student_id, attendance_date, status) VALUES (?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE status = VALUES(status), marked_at = CURRENT_TIMESTAMP";
        try (Connection con = DatabaseConnection.getConnection()) {
            con.setAutoCommit(false);
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                for (Map.Entry<Integer, String> entry : statuses.entrySet()) {
                    ps.setInt(1, entry.getKey());
                    ps.setDate(2, Date.valueOf(date));
                    ps.setString(3, entry.getValue());
                    ps.addBatch();
                }
                ps.executeBatch();
                con.commit();
            } catch (SQLException e) {
                con.rollback();
                throw e;
            } finally {
                con.setAutoCommit(true);
            }
        }
    }

    public int countByStatus(LocalDate date, String status) throws SQLException {
        String sql = "SELECT COUNT(*) FROM attendance WHERE attendance_date = ? AND status = ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, Date.valueOf(date));
            ps.setString(2, status);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }

    public List<AttendanceRecord> getReport(LocalDate date) throws SQLException {
        String sql = "SELECT s.roll_no, s.name, s.course, s.semester, " +
                "COALESCE(a.status, 'NOT MARKED') AS attendance_status " +
                "FROM students s LEFT JOIN attendance a ON s.id = a.student_id AND a.attendance_date = ? " +
                "ORDER BY s.roll_no";
        List<AttendanceRecord> records = new ArrayList<>();
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, Date.valueOf(date));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    records.add(new AttendanceRecord(rs.getString("roll_no"), rs.getString("name"),
                            rs.getString("course"), rs.getInt("semester"), rs.getString("attendance_status")));
                }
            }
        }
        return records;
    }
}
