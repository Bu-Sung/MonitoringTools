<%-- 
    Document   : meetingDetail
    Created on : 2023. 8. 22., 오전 7:20:21
    Author     : qntjd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/meeting.css">
    </head>
    <body>
        <div id="meeting">
            <div class="meeing-title">${meeting.title}</div>
            <table style="width: 100%;">
                <tr class="row">
                    <th colspan="2" rowspan="2">날짜</th>
                    <td>
                        <span>시작</span>
                        <div>${meeting.start}</div>
                    </td>
                    <th>작성자</th>
                    <td>
                        <div>${meeting.writer}</div>
                    </td>
                </tr>
                <tr class="row">
                    <td>
                        <span>종료</span>
                        <div>${meeting.end}</div>
                    </td>
                    <th>장소</th>
                    <td>
                        <div>${meeting.place}</div>
                    </td>
                </tr>
                        
            </table>
  
                        <c:forEach var="file" items="${meeting.files}">
                            <a href="download?filename=${file}&mid=${meeting.id}">${file}</a>
            </c:forEach>

                    
            <div id="content" class="meeting-content">
                ${meeting.content}
            </div>
    </div>
            <a href="details/${meeting.id}">수정하기</a>
            <a>삭제</a>
    </body>
</html>
