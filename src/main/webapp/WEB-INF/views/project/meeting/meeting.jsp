<!--<%-- Document : meetingSave Created on : 2023. 8. 20., 오전 3:48:33 Author : qntjd --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>sw</title>

    <!-- 부트스트랩 CSS 링크-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- 부트스트랩 Icons 링크 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- Google Fonts - Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap"
          rel="stylesheet">

    <!-- CSS 파일 연결 -->
    <link rel="stylesheet" href="/monitoring/css/kimleepark.css">
    <link rel="stylesheet" href="/monitoring/css/document.css">
</head>

<body>
    <div class="d-flex col-11 mx-auto mt-5">
        <!-- side bar -->
        <%@include file="/jspf/projectSidebar.jspf" %>

        <div class="w-100">
            <!-- navbar -->
            <%@include file="/jspf/projectTopbar.jspf" %>
            <!-- 제일 아래에 깔려 있는 파란색 card -->
            <div class="card card-blue row mx-auto mb-5" style="height: viewportHeight;">
                <!-- 중간에 깔려 있는 card -->
                <div class="card card-white-0 mx-auto" style="height: viewportHeight;">
                    <div class="col-md-10 col-11 mx-auto my-5">
                        <h4 class="fw-600 text-dark mb-4">회의록 상세</h4>
                        <div class="card card-white-1 p-4">
                            <div id="meeting">
                                <div class="d-flex justify-content-between">
                                    <div class="meeing-title" style="font-size: 2rem; height: 4rem;">${meeting.title}</div>
                                    <c:if test="${sessionScope.hasRight == 1 || (sessionScope.hasRight == 2 && sessionScope.user.name == meeting.writer)}">
                                        <div>
                                            <a href="update/${meeting.id}"><button type="button" class="btn btn-primary">수정</button></a>
                                            <a href="delete/${meeting.id}"><button type="button" class="btn btn-danger">삭제</button></a>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="row">
                                    <div class="col-md-6"> <!-- 중간 크기 이상의 화면에서는 날짜 영역을 절반의 너비로 표시 -->
                                        <table style="width: 100%;">
                                            <tr class="row">
                                                <th>날짜</th>
                                                <td>
                                                    <div class="d-flex align-items-center mb-2">
                                                        <span style="width: 3rem;">시작</span>
                                                        <div>${meeting.start}</div>
                                                    </div>
                                                    <div class="d-flex align-items-center mb-md-5 mb-4">
                                                        <span style="width: 3rem;">종료</span>
                                                        <div>${meeting.end}</div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="align-items-center mb-2">
                                            <span class="fw-bold">장소</span>
                                            <div>${meeting.place}</div>
                                        </div>
                                        <div class="align-items-center">
                                            <span class="fw-bold">작성자</span>
                                            <div>${meeting.writer}</div>
                                        </div>
                                    </div>
                                </div>
                                <ul class='list-unstyled' id="ulfile">
                                    <c:forEach items="${meeting.files}" var="file">
                                        <li class="m-0" ><a href="download?filename=${file}&mid=${meeting.id}">${file}</a></li>
                                        </c:forEach>
                                </ul>
                                <div id="content" class="document-content">
                                    ${meeting.content}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        const dashboardMenu = document.getElementById("dashboardMenu");
        const offcanvasDashboardMenu = document.getElementById("offcanvasDashboardMenu");

        // menuContent의 내용을 offcanvasMenuContent에 가져와서 화면에 출력
        offcanvasDashboardMenu.innerHTML = dashboardMenu.innerHTML;
    </script>
    <!--<script src="https://cdn.jsdelivr.net/npm/marked@4.0.3/lib/marked.min.js"></script>-->
    <!-- 부트스트랩 script -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>