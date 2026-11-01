<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/partials/header.jsp"/>
<section class="page-heading">
    <div><div class="eyebrow">ATTENDANCE ANALYTICS</div><h1>Attendance Reports</h1><p class="muted">Review attendance records for a selected date.</p></div>
    <button class="btn btn-secondary" type="button" onclick="window.print()">Print report ↗</button>
</section>
<section class="content-card report-filter">
    <form action="${pageContext.request.contextPath}/reports" method="get" class="report-date-form"><div class="field"><label for="reportDate">Select date</label><input id="reportDate" type="date" name="date" value="${reportDate}" required></div><button class="btn btn-primary" type="submit">Generate report</button></form>
</section>
<section class="stat-grid report-stats">
    <article class="stat-card"><div class="stat-top"><span>Present</span><span class="stat-icon icon-green">✓</span></div><div class="stat-number"><c:out value="${presentCount}"/></div><div class="stat-caption">Students present</div></article>
    <article class="stat-card"><div class="stat-top"><span>Absent</span><span class="stat-icon icon-red">×</span></div><div class="stat-number"><c:out value="${absentCount}"/></div><div class="stat-caption">Students absent</div></article>
    <article class="stat-card"><div class="stat-top"><span>Not Marked</span><span class="stat-icon icon-amber">…</span></div><div class="stat-number"><c:out value="${records.size() - presentCount - absentCount}"/></div><div class="stat-caption">Attendance pending</div></article>
</section>
<section class="content-card table-card report-table">
    <div class="table-toolbar"><div><h3>Attendance for <c:out value="${reportDate}"/></h3><p class="muted">Complete class register for the selected date.</p></div><span class="table-note">${records.size()} student(s)</span></div>
    <div class="table-wrap"><table><thead><tr><th>ROLL NO.</th><th>STUDENT NAME</th><th>COURSE</th><th>SEMESTER</th><th>STATUS</th></tr></thead><tbody>
        <c:forEach var="record" items="${records}"><tr><td><span class="roll-pill"><c:out value="${record.rollNo}"/></span></td><td><strong><c:out value="${record.studentName}"/></strong></td><td><c:out value="${record.course}"/></td><td>Sem <c:out value="${record.semester}"/></td><td><c:choose><c:when test="${record.status == 'PRESENT'}"><span class="status-badge status-present">Present</span></c:when><c:when test="${record.status == 'ABSENT'}"><span class="status-badge status-absent">Absent</span></c:when><c:otherwise><span class="status-badge status-pending">Not marked</span></c:otherwise></c:choose></td></tr></c:forEach>
        <c:if test="${empty records}"><tr><td colspan="5" class="empty-state">No student records available.</td></tr></c:if>
    </tbody></table></div>
</section>
<jsp:include page="/WEB-INF/views/partials/footer.jsp"/>
