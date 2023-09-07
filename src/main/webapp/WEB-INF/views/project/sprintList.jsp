<%-- 
    Document   : sprintList
    Created on : 2023. 9. 7., 오후 4:41:22
    Author     : qntjd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    </head>

    <body>
        <div class="d-flex col-11 mx-auto mt-5">
            <!-- side bar -->
            <%@include file="/jspf/projectSidebar.jspf"%>

            <div class="w-100">
                <!-- navbar -->
                <%@include file="/jspf/projectTopbar.jspf"%>
                <!-- 제일 아래에 깔려 있는 파란색 card -->
                <div class="card card-blue row mx-auto" style="max-height: viewportHeight;">
                    <!-- 중간에 깔려 있는 card -->
                    <div class="card card-white-0 mx-auto"
                         style="max-height: viewportHeight; min-height: 80vh; overflow: auto;">
                        <div class="col-md-9 col-11 mx-auto my-5">
                            <h4 class="mb-4 fw-600">스프린트 리스트</h4>
                            <c:forEach items="${request}" var="list" varStatus="status">
                                <c:if test="${status.index > 0}">
                                    <c:set var="prevItem" value="${request[status.index - 1].requestDate}" />
                                </c:if>
                                <c:if test="${list.requestDate != prevItem or status.index == 0}">
                                    <div class="card card-white-1 mb-3">
                                        <div class="card-body" style="overflow: auto; white-space: nowrap;">
                                            <p class="px-2 fw-600 mb-3 bg-yellow">No.<span>1</span></p>

                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th>진행날짜</th>
                                                        <th>요구사항 명</th>
                                                        <th>추정치</th>
                                                        <th>진행사항</th>
                                                        <th>담당자</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </c:if>
                                                <tr>
                                                    <td>${list.requestDate}</td>
                                                    <td>${list.name}</td>
                                                    <td>${list.date}</td>
                                                    <td>${list.stage}</td>
                                                    <td>${list.username}</td>
                                                </tr>
                                                <c:if test="${list.requestDate != prevItem or status.index == 0}">
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
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
        <!-- 부트스트랩 script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>