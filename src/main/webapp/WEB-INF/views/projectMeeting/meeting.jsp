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
    <a href="meetingSave">회의록 등록하기</a>
    <table>
        <thead>
            <tr>
                <th>회의 번호</th>
                <th>제목</th>
                <th>작성일</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="meeting" items="${meetings}">
            <tr>
                <td><c:out value="${meeting.id}"/></td>
                <td><c:out value="${meeting.title}"/></td>
                <td><c:out value="${meeting.date}"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <br>
    
</body>
</html>
