<%-- 
    Document   : meetingSave
    Created on : 2023. 8. 20., 오전 3:48:33
    Author     : qntjd
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>마크다운 에디터</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/document.css">
    <script>
        function saveDocument(){
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
    <h1>회의록 작성 페이지</h1>
    <hr>
    <div id="meeting">
        <form id="documentForm" method="POST" action="addMeeting" enctype="multipart/form-data" onsubmit="saveDocument()" >
            <input type="text" id="title" class="document-title" placeholder="제목을 입력하세요" name="title">
            <table style="width: 100%;">
                <tr class="row">
                    <th>날짜</th>
                    <td>
                        <div class="horizontal-container">
                            <span>시작</span>
                            <input type="datetime-local" id="inputDateStart" name="start">
                        </div>
                        <div class="horizontal-container">
                            <span>종료</span>
                            <input type="datetime-local" id="inputDateEnd" name="end">
                        </div>
                    </td>
                    <th>장소</th>
                    <td>
                        <input type="text" id="inputPlace" autocomplete="off" placeholder="회의 장소를 입력해주세요!" name="place">
                    </td>
                </tr>
            </table>
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
    </div>
    <!--<script src="https://cdn.jsdelivr.net/npm/marked@4.0.3/lib/marked.min.js"></script>-->
            <script charset="UTF-8" src="${pageContext.request.contextPath}/js/document/document.js"></script>
        <script charset="UTF-8" src="${pageContext.request.contextPath}/js/document/keyEvent.js"></script>
        <script charset="UTF-8" src="${pageContext.request.contextPath}/js/document/mdFunction.js"></script>
</body>

</html>