<%-- 
    Document   : projectDetails
    Created on : 2023. 8. 11., 오전 4:43:23
    Author     : parkchaebin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>프로젝트 상세 페이지</title>
        <script>
            <c:if test="${!empty msg}">
            alert("${msg}");
            </c:if>
        </script>
    </head>

    <body>

        <h1>프로젝트 상세 정보 확인, 수정 및 삭제</h1>

        <c:if test="${not empty project}">
            <form action="/monitoring/project/updateProject" method="post">
                <input type="hidden" name="pid" value="${project.pid}" />

                <p><b>프로젝트 아이디 :</b> <c:out value="${project.pid}" /></p>
                <p><b>프로젝트 이름 :</b> <input type="text" name="name" value="${project.name}" required/></p>
                <p><b>프로젝트 설명 :</b> <input type="text" name="content" value="${project.content}" /></p>
                <p><b>프로젝트 시작 기간 :</b> <input type="date" name="start" value="${project.start}" required/></p>
                <p><b>프로젝트 종료 기간 :</b> <input type="date" name="end" value="${project.end}" required/></p>
                <p><b>게시글 카테고리 : <input type="text" name="category" value="${project.category}" required/></p> 
                카테고리 리스트 : <br>
                    <c:forEach var="cat" items="${project.categoryList}">
                        ${cat} <br>
                    </c:forEach>
                
                <p><b>스프린트 주기 :</b> <input type="number" name="cycle" value="${project.cycle}" /></p>

                <button type="submit" ${right == 1 ? '' : 'disabled'}>수정</button>

            </form>

            <form action="delete/${project.pid}" method="post">
                <input type="hidden" name="pid" value="${project.pid}" />
                <button type="submit" ${right == 1 ? '' : 'disabled'}>삭제</button>
            </form>
 
            <br> <br> 

            <form action="/monitoring/project/manageMember/${project.pid}" method="get">
                <input type="hidden" name="pid" value="${project.pid}" />
                <input type="submit" value="팀원 관리" />
            </form>
                
        </c:if>

    </body>
</html>
