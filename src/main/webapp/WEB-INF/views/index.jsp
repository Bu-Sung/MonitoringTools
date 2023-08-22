<%-- 
    Document   : index
    Created on : 2023. 8. 20., 오전 7:24:37
    Author     : qntjd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JSP Page</title>
        <script>
            <c:if test="${!empty msg}">
                alert("${msg}");
            </c:if>
        </script>
    </head>
    <body>

        <h1>프로젝트</h1>
        <a href="projectMeeting/meeting">회의록</a>

        <c:if test="${!empty sessionScope.user}">
            <p>${sessionScope.user.getId()}</p>
            <p>${sessionScope.user.getName()}</p>
            <p>${sessionScope.user.getEmail()}</p>
            <p>${sessionScope.user.getPhone()}</p>
            <p>${sessionScope.user.getBirth()}</p>
        </c:if>
        <a href="register">회원가입</a>
        <a href="login">로그인</a>
        <c:if test="${!empty sessionScope.user}">
            <a href="update">회원정보 수정</a>
            <a href="logout">로그아웃</a>
        </c:if>

    </body>
</html>
