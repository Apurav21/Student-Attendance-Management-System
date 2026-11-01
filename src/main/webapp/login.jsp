<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login | AttendEase</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body class="login-page">
<div class="login-shell">
    <div class="login-brand">
        <div class="brand-mark">A</div>
        <div>
            <div class="brand-name">AttendEase</div>
            <div class="brand-subtitle">STUDENT ATTENDANCE SYSTEM</div>
        </div>
    </div>
    <section class="login-card">
        <div class="eyebrow">ADMIN PORTAL</div>
        <h1>Welcome back</h1>
        <p class="muted">Sign in to manage student attendance.</p>
        <c:if test="${not empty error}">
            <div class="alert alert-danger"><c:out value="${error}"/></div>
        </c:if>
        <form action="${pageContext.request.contextPath}/login" method="post" class="form-stack">
            <label for="username">Username</label>
            <input id="username" name="username" type="text" placeholder="Enter admin username" required autocomplete="username">
            <label for="password">Password</label>
            <input id="password" name="password" type="password" placeholder="Enter password" required autocomplete="current-password">
            <button type="submit" class="btn btn-primary btn-full">Sign in <span aria-hidden="true">→</span></button>
        </form>
        <div class="demo-note"><strong>Demo login</strong><br>Username: <code>admin</code> &nbsp; Password: <code>admin123</code></div>
    </section>
    <p class="login-foot">A simple, organized way to track classroom attendance.</p>
</div>
</body>
</html>
