package com.aip.attendance.model;

public class Student {
    private int id;
    private String rollNo;
    private String name;
    private String course;
    private int semester;
    private String email;

    public Student() { }

    public Student(int id, String rollNo, String name, String course, int semester, String email) {
        this.id = id;
        this.rollNo = rollNo;
        this.name = name;
        this.course = course;
        this.semester = semester;
        this.email = email;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getRollNo() { return rollNo; }
    public void setRollNo(String rollNo) { this.rollNo = rollNo; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getCourse() { return course; }
    public void setCourse(String course) { this.course = course; }
    public int getSemester() { return semester; }
    public void setSemester(int semester) { this.semester = semester; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}
