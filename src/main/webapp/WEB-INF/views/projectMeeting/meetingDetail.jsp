<%-- 
    Document   : meetingDetail
    Created on : 2023. 8. 22., 오전 7:20:21
    Author     : qntjd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            <div class="meeing-title">${meeting.getTitle()}</div>
            <table style="width: 100%;">
                <tr class="row">
                    <th>날짜</th>
                    <td>
                        <div class="horizontal-container">
                            <span>시작</span>
                            <div>${meeting.getStart()}</div>
                        </div>
                        <div class="horizontal-container">
                            <span>종료</span>
                            <div>${meeting.getEnd()}</div>
                        </div>
                    </td>
                    <th>장소</th>
                    <td>
                        <div>${meeting.getPlace()}</div>
                    </td>
                </tr>
            </table>
            <input type="file" name="file"  multiple>
            <div id="content" class="meeting-content">
                <div class="content-explanation">
                    <h2>단축키 설명</h2>
                    <div style="text-align: left;">
                        # => h1<br>
                        ## => h2<br>
                        ### => h3<br>
                        - => •<br>
                    </div>
                </div>
            </div>
            <button type="sumit" >저장하기</button>
        </form>
    </div>
    </body>
</html>
