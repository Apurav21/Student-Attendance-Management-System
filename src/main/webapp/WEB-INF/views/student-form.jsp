<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/partials/header.jsp"/>
<section class="page-heading">
    <div><div class="eyebrow">STUDENT DIRECTORY</div><h1><c:out value="${formTitle}"/></h1><p class="muted">Enter the student's basic academic and contact details.</p></div>
    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/students">← Back to students</a>
</section>
<c:if test="${param.error == 'duplicate'}"><div class="alert alert-danger">That roll number already exists. Please enter a different roll number.</div></c:if>
<c:if test="${param.error == 'invalid'}"><div class="alert alert-danger">Please complete the required fields and select a semester between 1 and 10.</div></c:if>
<section class="content-card form-card">
    <form action="${pageContext.request.contextPath}/students" method="post" class="student-form">
        <c:choose><c:when test="${student.id > 0}"><input type="hidden" name="action" value="update"><input type="hidden" name="id" value="${student.id}"></c:when><c:otherwise><input type="hidden" name="action" value="add"></c:otherwise></c:choose>
        <div class="form-grid">
            <div class="field"><label for="rollNo">University UID / Roll Number <span>*</span></label><input id="rollNo" name="rollNo" value="<c:out value='${student.rollNo}'/>" placeholder="e.g. 26MCC20001" required maxlength="30"></div>
            <div class="field"><label for="name">Student Name <span>*</span></label><input id="name" name="name" value="<c:out value='${student.name}'/>" placeholder="Enter full name" required maxlength="100"></div>
            <div class="field"><label for="course">Course <span>*</span></label><input id="course" name="course" value="<c:out value='${student.course}'/>" placeholder="e.g. MCA" required maxlength="60"></div>
            <div class="field"><label for="semester">Semester <span>*</span></label><select id="semester" name="semester" required>
                <c:forEach begin="1" end="10" var="s"><option value="${s}" <c:if test="${student.semester == s}">selected</c:if>>Semester ${s}</option></c:forEach>
            </select></div>
            <div class="field field-wide"><label for="email">Email Address</label><input id="email" name="email" type="email" value="<c:out value='${student.email}'/>" placeholder="student@example.com" maxlength="120"></div>
        </div>
        <div class="form-actions"><a class="btn btn-secondary" href="${pageContext.request.contextPath}/students">Cancel</a><button class="btn btn-primary" type="submit">Save student <span>→</span></button></div>
    </form>
</section>
<jsp:include page="/WEB-INF/views/partials/footer.jsp"/>
