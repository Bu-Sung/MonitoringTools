<%-- 
    Document   : details
    Created on : 2023. 8. 27., 오후 11:36:17
    Author     : qntjd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <title>공지사항 수정</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/document.css">
    </head>
    <body>
        <h1>공지사항 수정 페이지</h1>
        <hr>
        <form id="documentForm" method="POST" action="update" enctype="multipart/form-data" onsubmit="updateDocument()" >
            <input type="text" name="bid" value="${board.bid}" hidden>
            <input type="text" id="title" class="document-title" placeholder="제목을 입력하세요" name="title" value="${board.title}">
            <select id="category" name="category">
                <c:forEach var="category" items="${category}">
                    <option value="${category}" ${board.category == category? 'select' : ''}>${category}</option>
                </c:forEach>
            </select>
            <div id="file-container">
                <ul id="ulfile">
                    <c:forEach items="${board.files}" var="file">
                        <li data-filename="${file}"><a href="../download?filename=${file}&mid=${board.bid}">${file}</a><span onclick="removefile(event)">&nbsp;삭제</span></li>
                    </c:forEach>
                </ul>
            </div>
            <input type="file" id="file" name="file"  multiple>
            <div id="content" class="document-content">
                ${board.content}
            </div>
            <button type="submit" >저장하기</button>
        </form>
                <script charset="UTF-8" src="${pageContext.request.contextPath}/js/document/document.js"></script>
        <script charset="UTF-8" src="${pageContext.request.contextPath}/js/document/keyEvent.js"></script>
        <script charset="UTF-8" src="${pageContext.request.contextPath}/js/document/mdFunction.js"></script>
    </body>
</html>
