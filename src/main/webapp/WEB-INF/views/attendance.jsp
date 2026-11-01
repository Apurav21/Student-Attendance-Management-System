<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/partials/header.jsp"/>
<section class="page-heading">
    <div><div class="eyebrow">DAILY REGISTER</div><h1>Mark Attendance</h1><p class="muted">Select Present or Absent for every student.</p></div>
    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/reports">View reports →</a>
</section>
<c:if test="${param.message == 'saved'}"><div class="alert alert-success">Attendance saved successfully for <c:out value="${param.date}"/>.</div></c:if>
<c:if test="${param.error == 'invalid'}"><div class="alert alert-danger">Please select Present or Absent for every student.</div></c:if>
<section class="content-card attendance-card">
    <form action="${pageContext.request.contextPath}/attendance" method="post">
        <div class="attendance-toolbar"><div class="field date-field"><label for="date">Attendance date</label><input id="date" type="date" name="date" value="${attendanceDate}" required onchange="window.location='${pageContext.request.contextPath}/attendance?date='+this.value"></div><div class="legend"><span><i class="legend-dot present-dot"></i> Present</span><span><i class="legend-dot absent-dot"></i> Absent</span></div></div>
        <div class="table-wrap"><table>
            <thead><tr><th>ROLL NO.</th><th>STUDENT NAME</th><th>COURSE</th><th>SEMESTER</th><th>ATTENDANCE STATUS</th></tr></thead>
            <tbody>
            <c:forEach var="student" items="${students}">
                <tr><td><span class="roll-pill"><c:out value="${student.rollNo}"/></span></td><td><strong><c:out value="${student.name}"/></strong></td><td><c:out value="${student.course}"/></td><td>Sem <c:out value="${student.semester}"/></td>
                    <td><div class="status-select"><select name="status_${student.id}" aria-label="Attendance status for ${student.name}">
                        <option value="PRESENT" <c:if test="${statuses[student.id] == 'PRESENT' || empty statuses[student.id]}">selected</c:if>>Present</option>
                        <option value="ABSENT" <c:if test="${statuses[student.id] == 'ABSENT'}">selected</c:if>>Absent</option>
                    </select></div></td></tr>
            </c:forEach>
            <c:if test="${empty students}"><tr><td colspan="5" class="empty-state">No students are registered. Add students before marking attendance.</td></tr></c:if>
            </tbody>
        </table></div>
        <c:if test="${not empty students}"><div class="attendance-submit"><span class="muted">Review each student's status before saving.</span><button type="submit" class="btn btn-primary">Save attendance <span>→</span></button></div></c:if>
    </form>
</section>
<jsp:include page="/WEB-INF/views/partials/footer.jsp"/>
