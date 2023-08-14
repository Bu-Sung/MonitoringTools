<%-- 
    Document   : index
    Created on : 2023. 7. 28., 오전 7:07:25
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
        <c:if test="${!empty sessionScope.user}">
            <p>${sessionScope.user.getId()}</p>
            <p>${sessionScope.user.getName()}</p>
            <p>${sessionScope.user.getEmail()}</p>
            <p>${sessionScope.user.getPhone()}</p>
            <p>${sessionScope.user.getBirth()}</p>
        </c:if>
        <a href="register">회원가입</a>
        <a href="login">로그인</a>
    </body>
</html>
