<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/partials/header.jsp"/>
<section class="page-heading">
    <div><div class="eyebrow">OVERVIEW</div><h1>Dashboard</h1><p class="muted">Here is your attendance summary for today.</p></div>
    <div class="date-chip">▣ &nbsp; <c:out value="${today}"/></div>
</section>
<section class="stat-grid">
    <article class="stat-card"><div class="stat-top"><span>Total Students</span><span class="stat-icon icon-blue">♙</span></div><div class="stat-number"><c:out value="${totalStudents}"/></div><div class="stat-caption">Registered students</div></article>
    <article class="stat-card"><div class="stat-top"><span>Present Today</span><span class="stat-icon icon-green">✓</span></div><div class="stat-number"><c:out value="${presentCount}"/></div><div class="stat-caption">Marked present</div></article>
    <article class="stat-card"><div class="stat-top"><span>Absent Today</span><span class="stat-icon icon-red">×</span></div><div class="stat-number"><c:out value="${absentCount}"/></div><div class="stat-caption">Marked absent</div></article>
    <article class="stat-card"><div class="stat-top"><span>Not Marked</span><span class="stat-icon icon-amber">…</span></div><div class="stat-number"><c:out value="${notMarkedCount}"/></div><div class="stat-caption">Attendance pending</div></article>
</section>
<section class="content-card welcome-card">
    <div class="welcome-copy"><div class="eyebrow">QUICK ACTIONS</div><h2>Keep your class records up to date.</h2><p class="muted">Add students, record daily attendance, and view clear attendance reports from one place.</p>
        <div class="action-row"><a class="btn btn-primary" href="${pageContext.request.contextPath}/attendance">Mark attendance <span>→</span></a><a class="btn btn-secondary" href="${pageContext.request.contextPath}/students?action=new">＋ Add student</a></div>
    </div>
    <div class="welcome-art"><div class="art-circle">✓</div><div class="art-label">Every day, accounted for.</div></div>
</section>
<section class="bottom-grid">
    <div class="content-card mini-card"><div class="card-heading"><div><div class="eyebrow">STUDENT RECORDS</div><h3>Manage your class</h3></div><span class="small-icon">♙</span></div><p class="muted">Keep student names, roll numbers, courses and semester details organized.</p><a class="text-link" href="${pageContext.request.contextPath}/students">Open student list →</a></div>
    <div class="content-card mini-card"><div class="card-heading"><div><div class="eyebrow">REPORTING</div><h3>Review attendance</h3></div><span class="small-icon">▤</span></div><p class="muted">Choose a date to see who was present, absent or not marked.</p><a class="text-link" href="${pageContext.request.contextPath}/reports">View reports →</a></div>
</section>
<jsp:include page="/WEB-INF/views/partials/footer.jsp"/>
