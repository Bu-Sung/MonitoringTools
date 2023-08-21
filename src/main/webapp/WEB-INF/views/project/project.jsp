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

        <h1>Project List</h1>

        <table>
            <tr>
                <th>프로젝트 이름</th>
                <th>프로젝트 설명</th>
                <th>프로젝트 시작 기간</th>
                <th>프로젝트 마감 기간</th>
                <th>게시글 카테고리</th>
            </tr>
            <c:forEach var="project" items="${projects}">
                <tr>

                    <td><a href="projectDetails/${project.pid}"><c:out value="${project.name}" /></a></td>
                    <td><c:out value="${project.content}" /></td>
                    <td><c:out value="${project.start}" /></td>
                    <td><c:out value="${project.end}" /></td>
                    <td><c:out value="${project.category}" /></td>
                </tr>
            </c:forEach>
        </table> 

        <form action="projectSave" method="post">
            <button type="submit">프로젝트 추가</button>
        </form>
    </body>
</html>
