<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AttendEase | Student Attendance</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<div class="app-shell">
    <aside class="sidebar">
        <a class="brand" href="${pageContext.request.contextPath}/dashboard">
            <span class="brand-mark">A</span>
            <span><strong>AttendEase</strong><small>ATTENDANCE PORTAL</small></span>
        </a>
        <div class="nav-label">WORKSPACE</div>
        <nav class="main-nav">
            <a href="${pageContext.request.contextPath}/dashboard"><span class="nav-icon">▦</span> Dashboard</a>
            <a href="${pageContext.request.contextPath}/students"><span class="nav-icon">♙</span> Students</a>
            <a href="${pageContext.request.contextPath}/attendance"><span class="nav-icon">✓</span> Mark Attendance</a>
            <a href="${pageContext.request.contextPath}/reports"><span class="nav-icon">▤</span> Reports</a>
        </nav>
        <div class="sidebar-bottom">
            <div class="admin-mini"><span class="avatar">A</span><span><strong>Administrator</strong><small>Admin account</small></span></div>
            <a class="logout-link" href="${pageContext.request.contextPath}/logout">↪ &nbsp; Sign out</a>
        </div>
    </aside>
    <main class="main-content">
        <header class="topbar">
            <div><span class="topbar-kicker">STUDENT MANAGEMENT</span><strong>Attendance overview</strong></div>
            <div class="topbar-user"><span class="online-dot"></span> Administrator</div>
        </header>
