<%-- 
    Document   : schedule
    Created on : 2023. 9. 3., 오후 2:55:23
    Author     : qntjd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="/monitoring/css/calender.css">
    </head>
    <body>
        <div class="d-flex col-11 mx-auto mt-5">
            <!-- side bar -->
            <%@include file="/jspf/projectSidebar.jspf"%>

            <div class="w-100">
                <!-- navbar -->
                <%@include file="/jspf/projectTopbar.jspf"%>
                <!-- 제일 아래에 깔려 있는 파란색 card -->
                <div class="card card-blue row mx-auto" style="height: viewportHeight;">
                    <!-- 중간에 깔려 있는 card -->
                    <div class="card card-white-0 mx-auto" style="height: 80vh;">
                        <div class="col-md-9 col-11 mx-auto my-5">
                            <h4 class="fw-600 text-dark">
                                <span>일정</span> 목록
                            </h4>
                            <div class="card card-white-1 mt-3" style="height: 50vh;">
                                <div class="card-body" style="overflow: auto; white-space: nowrap;">
                                    <div id='calendar'></div>
                                    <div id="myModal" class="modal"></div>
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
            <!-- 부트스트랩 script -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

            <script src='/monitoring/js/schedule/index.global.js'></script>
            <script src='/monitoring/js/schedule/schedule.js'></script>
            <script src='/monitoring/js/schedule/calendar.js'></script>
    </body>
</html>
