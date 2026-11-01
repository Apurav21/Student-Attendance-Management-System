package com.aip.attendance.model;

public class AttendanceRecord {
    private String rollNo;
    private String studentName;
    private String course;
    private int semester;
    private String status;

    public AttendanceRecord(String rollNo, String studentName, String course, int semester, String status) {
        this.rollNo = rollNo;
        this.studentName = studentName;
        this.course = course;
        this.semester = semester;
        this.status = status;
    }

    public String getRollNo() { return rollNo; }
    public String getStudentName() { return studentName; }
    public String getCourse() { return course; }
    public int getSemester() { return semester; }
    public String getStatus() { return status; }
}
