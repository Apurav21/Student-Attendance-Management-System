package com.aip.attendance.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/** Central JDBC connection helper. Update DB_USER and DB_PASSWORD for your computer. */
public final class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/attendance_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Kolkata";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "15102004Apurav@";

    private DatabaseConnection() { }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC driver was not found. Check Maven dependencies.", e);
        }
        return DriverManager.getConnection(URL, DB_USER, DB_PASSWORD);
    }
}
