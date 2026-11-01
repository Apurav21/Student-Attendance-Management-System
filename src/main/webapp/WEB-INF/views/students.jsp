<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/partials/header.jsp"/>
<section class="page-heading">
    <div><div class="eyebrow">STUDENT DIRECTORY</div><h1>Students</h1><p class="muted">Add and maintain student information.</p></div>
    <a class="btn btn-primary" href="${pageContext.request.contextPath}/students?action=new">＋ Add student</a>
</section>
<c:if test="${param.message == 'added'}"><div class="alert alert-success">Student added successfully.</div></c:if>
<c:if test="${param.message == 'updated'}"><div class="alert alert-success">Student details updated successfully.</div></c:if>
<c:if test="${param.message == 'deleted'}"><div class="alert alert-success">Student deleted successfully.</div></c:if>
<c:if test="${param.error == 'duplicate'}"><div class="alert alert-danger">That roll number already exists. Use a unique roll number.</div></c:if>
<c:if test="${param.error == 'notfound'}"><div class="alert alert-danger">Student record was not found.</div></c:if>
<section class="content-card table-card">
    <div class="table-toolbar"><div><h3>All students</h3><p class="muted">${students.size()} student record(s)</p></div><span class="table-note">Sorted by roll number</span></div>
    <div class="table-wrap"><table>
        <thead><tr><th>ROLL NO.</th><th>STUDENT NAME</th><th>COURSE</th><th>SEMESTER</th><th>EMAIL</th><th>ACTIONS</th></tr></thead>
        <tbody>
        <c:forEach var="student" items="${students}">
            <tr>
                <td><span class="roll-pill"><c:out value="${student.rollNo}"/></span></td>
                <td><strong><c:out value="${student.name}"/></strong></td>
                <td><c:out value="${student.course}"/></td>
                <td><span class="semester-pill">Sem <c:out value="${student.semester}"/></span></td>
                <td><c:out value="${student.email}"/></td>
                <td><div class="row-actions"><a class="action-link" href="${pageContext.request.contextPath}/students?action=edit&id=${student.id}">Edit</a>
                    <form action="${pageContext.request.contextPath}/students" method="post" onsubmit="return confirm('Delete this student? Their attendance records will also be deleted.');">
                        <input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="${student.id}"><button class="action-link danger-link" type="submit">Delete</button>
                    </form></div></td>
            </tr>
        </c:forEach>
        <c:if test="${empty students}"><tr><td colspan="6" class="empty-state">No students found. Add your first student to get started.</td></tr></c:if>
        </tbody>
    </table></div>
</section>
<jsp:include page="/WEB-INF/views/partials/footer.jsp"/>
