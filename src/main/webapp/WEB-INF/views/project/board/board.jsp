<%-- 
    Document   : board
    Created on : 2023. 8. 27., 오후 10:42:18
    Author     : qntjd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/meeting.css">
        <title>JSP Page</title>
    </head>
    <body>
        <div id="board">
            <div class="document-title">제목: ${board.title}</div>
            <div >작성자: ${board.writer}</div>
            <div>작성 날짜: ${board.date}</div>
            <div >카테고리: ${board.category}</div>
            <c:forEach var="file" items="${board.files}">
                <a href="download?filename=${file}&mid=${board.bid}">${file}</a>
            </c:forEach>


            <div id="content" class="document-content">
                ${board.content}
            </div>
        </div>
        <c:if test="${editRight}">
            <a href="update/${board.bid}">수정하기</a>
            <a href="delete/${board.bid}">삭제</a>
        </c:if>
    </body>
</html>
