<%-- 
    Document   : save
    Created on : 2023. 8. 27., 오후 3:14:40
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
        <title>공지사항 작성</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/meeting.css">
        <script>
            function saveDocument() {
                const formDiv = document.getElementById("documentForm");
                const text = document.getElementById("content");
                const content = document.createElement('input');

                content.setAttribute("type", "hidden");
                content.setAttribute("name", "content");
                content.setAttribute("value", text.innerHTML);

                formDiv.appendChild(content);
            }
        </script>
    </head>
    <body>
        <h1>공지사항 작성 페이지</h1>
        <hr>
        <form id="documentForm" method="POST" action="addBoard" enctype="multipart/form-data" onsubmit="saveDocument()" >
            <input type="text" id="title" class="document-title" placeholder="제목을 입력하세요" name="title">
            <select id="category" name="category">
                <c:forEach var="category" items="${category}">
                    <option value="${category}">${category}</option>
                </c:forEach>
            </select>
            <input type="file" name="file"  multiple>
            <div id="content" class="document-content">
                <div class="document-content-explanation">
                    <h2>단축키 설명</h2>
                    <div style="text-align: left;">
                        # => h1<br>
                        ## => h2<br>
                        ### => h3<br>
                        - => •<br>
                    </div>
                </div>
            </div>
            <button type="submit" >저장하기</button>
        </form>
        <script charset="UTF-8" src="${pageContext.request.contextPath}/js/meeting/meeting.js"></script>
        <script charset="UTF-8" src="${pageContext.request.contextPath}/js/meeting/keyEvent.js"></script>
        <script charset="UTF-8" src="${pageContext.request.contextPath}/js/meeting/mdFunction.js"></script>
    </body>

</html>
