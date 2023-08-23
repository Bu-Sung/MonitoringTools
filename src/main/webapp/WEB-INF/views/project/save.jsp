<%-- 
    Document   : projectSave
    Created on : 2023. 8. 10., 오전 5:29:13
    Author     : parkchaebin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>프로젝트 추가 페이지</title>
        <script>
            <c:if test="${!empty msg}">
                alert("${msg}");
            </c:if>
        </script>
    </head>
    <body>

        <h1>프로젝트 추가</h1>

        <form action="addProject" method="post">
            <table>
                <tr>
                    <td>프로젝트 이름 :</td>
                    <td><input type="text" name="name" required></td>
                </tr>
                <tr>
                    <td>프로젝트 설명 :</td>
                    <td><input type="text" name="content"></td>
                </tr>
                <tr>
                    <td>프로젝트 시작 기간 :</td>
                    <td><input type="date" name="start" required></td>
                </tr>
                <tr>
                    <td>프로젝트 종료 기간 :</td>
                    <td><input type="date" name="end" required></td>
                </tr>
                <tr>
                    <td>게시글 카테고리 :</td>
                    <td><input type="text" name="category"></td>
                </tr>


                <tr>
                    <td colspan="2">
                        <input type="submit" value="저장">
                    </td>
                </tr>
            </table>
        </form>

    </body>
</html>
