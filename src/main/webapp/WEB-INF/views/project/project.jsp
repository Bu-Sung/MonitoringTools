<%-- 
    Document   : project
    Created on : 2023. 8. 6., 오전 2:08:58
    Author     : parkchaebin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>프로젝트 리스트 페이지</title>
        <script>
            <c:if test="${!empty msg}">
                alert("${msg}");
            </c:if>
        </script>
    </head>
    
    <body>
        <h1>${project.pid}</h1>
        <h1>${project.name}</h1>
        <a href="update/${project.pid}">프로젝트 정보 수정</a>
        <a href="meeting/list">회의록관리</a>
        <a href="#">스프린트 관리</a>
        <a href="request/request">요구사항 관리</a>
        <a href="#">일정 관리</a>
        <a href="#">공지사항 관리</a>
    </body>
</html>
