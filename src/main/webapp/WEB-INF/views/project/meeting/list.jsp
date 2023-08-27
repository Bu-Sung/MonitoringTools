<%-- 
    Document   : index
    Created on : 2023. 7. 28., 오전 7:07:25
    Author     : qntjd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>회의록 목록</title>
    <script>
            <c:if test="${!empty msg}">
                alert("${msg}");
            </c:if>
        </script>
</head>
<body>
    <h1>회의록 목록</h1>
    <c:if test="${editRight}">
            <a href="save">회의록 등록하기</a>
        </c:if>
    
    <table>
        <thead>
            <tr>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="meeting" items="${meetingList}">
            <tr>
                <td><a href="${meeting.id}"><c:out value="${meeting.title}"/></a></td>
                <td><c:out value="${meeting.getWriter()}"/></td>
                <td><c:out value="${meeting.getDate()}"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <br>
    
</body>
</html>
