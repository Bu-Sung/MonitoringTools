<%-- 
    Document   : meetingSave
    Created on : 2023. 8. 20., 오전 3:48:33
    Author     : qntjd
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>마크다운 에디터</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/meeting.css">
    <script>
        function saveMeeting() {
            const formDiv = document.getElementById("meetingForm");
            const text = document.getElementById("content");
            const content = document.createElement('input');

            content.setAttribute("type", "hidden");
            content.setAttribute("name", "content");
            content.setAttribute("value", text.innerHTML);

            formDiv.appendChild(content);
            checkupdatefile();
        }

        let delfile = [];

        function removefile(event) {
            const listItem = event.target.parentElement;
            delfile.push(listItem.getAttribute(`data-filename`));
            listItem.remove();
        }

        function checkupdatefile() {
            const newfile = document.getElementById('file');
            const container = document.getElementById('file-container');
            //삭제할 파일
            const delinput = document.createElement('input');
            delinput.type = 'hidden';
            delinput.name = 'dellist';
            delinput.value = delfile;
            container.appendChild(delinput);
            //남아있는 파일
            const remaininput = document.createElement('input');
            remaininput.type = 'hidden';
            remaininput.name = 'fileExist';
            remaininput.value = 0;
            if (document.getElementById("ulfile").getElementsByTagName("li") > 0 || newfile.files.length !== 0) {
                remaininput.value = 1;
            }
            container.appendChild(remaininput);
        }
    </script>
</head>

<body>
    <h1>회의록 작성 페이지</h1>
    <hr>
    <div id="meeting">
        <form id="meetingForm" method="POST" action="update" enctype="multipart/form-data" onsubmit="saveMeeting()" >
            <input type="text" name="id" value="${meeting.id}" hidden>
            <input type="text" id="title" class="meeting-title" placeholder="제목을 입력하세요" name="title" value="${meeting.title}">
            <table style="width: 100%;">
                <tr class="row">
                    <th colspan="2" rowspan="2">날짜</th>
                    <td>
                        <span>시작</span>
                        <input type="datetime-local" id="inputDateStart" name="start" value="${meeting.start}" >
                    </td>
                    <th>작성자</th>
                    <td>
                        <input type="text" name="writer" value="${meeting.writer}" disabled>
                    </td>
                </tr>
                <tr class="row">
                    <td>
                        <span>종료</span>
                        <input type="datetime-local" id="inputDateEnd" name="end" value="${meeting.end}">
                    </td>
                    <th>장소</th>
                    <td>
                        <input type="text" id="inputPlace" autocomplete="off" placeholder="회의 장소를 입력해주세요!" name="place" value="${meeting.place}">
                    </td>
                </tr>
                        
            </table>
            <div id="file-container" class="col-10">
                <ul class='list-unstyled' id="ulfile">
                    <c:forEach items="${meeting.files}" var="file">
                        <li class="m-0" data-filename="${file}"><a href="download?filename=${file}&mid=${meeting.id}">${file}</a><span onclick="removefile(event)">&nbsp;삭제</span></li>
                            </c:forEach>
                </ul>
            </div>
            <input type="file" id="file" name="file"  multiple>
            <div id="content" class="meeting-content">
                ${meeting.content}
            </div>
            <button type="submit">저장하기</button>
        </form>
    </div>
    <!--<script src="https://cdn.jsdelivr.net/npm/marked@4.0.3/lib/marked.min.js"></script>-->
    <script charset="UTF-8" src="${pageContext.request.contextPath}/js/meeting/meeting.js"></script>
    <script charset="UTF-8" src="${pageContext.request.contextPath}/js/meeting/keyEvent.js"></script>
    <script charset="UTF-8" src="${pageContext.request.contextPath}/js/meeting/mdFunction.js"></script>
</body>

</html>