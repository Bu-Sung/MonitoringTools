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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/kimleepark.css">
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
                    <div class="row mx-auto px-0">
                        <div class="col-md-3 col-12 order-md-2">
                            <div class="col-11 mx-auto mt-5 mb-4">
                                <div class="card card-white-1 mb-4">
                                    <div class="card-body">
                                        <p>진행률</p>
                                        <!--그래프 들어갈 자리-->
                                    </div>
                                </div>
                                <div class="row mx-auto">
                                    <div class="card card-white-1 mb-4 me-3 col-md-12 col">
                                        <div class="card-body">
                                            <p>D-Day</p>
                                            <h5 class="text-primary">D - <span>10</span></h5>
                                        </div>
                                    </div>
                                    <div class="card card-white-1 mb-4 col-md-12 col">
                                        <div class="card-body">
                                            <p>시작 전</p>
                                            <h5 class="text-primary">
                                                <sapn>5</sapn> / <span>35</span>
                                            </h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mx-auto">
                                    <div class="card card-white-1 mb-4 me-3 col-md-12 col">
                                        <div class="card-body">
                                            <p>진행 중</p>
                                            <h5 class="text-primary">
                                                <sapn>5</sapn> / <span>35</span>
                                            </h5>
                                        </div>
                                    </div>
                                    <div class="card card-white-1 mb-4 col-md-12 col">
                                        <div class="card-body">
                                            <p>완료</p>
                                            <h5 class="text-primary">
                                                <sapn>25</sapn> / <span>35</span>
                                            </h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- 중간에 깔려 있는 card -->
                        <div class="card card-white-0 col-md-9 col-12 mx-auto order-md-1" style="height: viewportHeight;">
                            <div class="col-11 mx-auto my-5">
                                <!-- 스프린트 card -->
                                <div class="card card-white-1 mb-4">
                                    <div class="card-body">
                                        <a href="#" class="text-dark fw-600">스프린트<i class="bi bi-chevron-right"></i></a>
                                        <div class="mt-3" style="overflow: auto; white-space: nowrap;">
                                            <table>
                                                <tr class="text-primary">
                                                    <th>요구사항</th>
                                                    <th>진행단계</th>
                                                    <th>소요기간</th>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        요구사항 내용sadfasdasdfa
                                                    </td>
                                                    <td>
                                                        진행단계 1
                                                    </td>
                                                    <td>
                                                        소요기간 1
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        요구사항 내용 2
                                                    </td>
                                                    <td>
                                                        진행단계 2
                                                    </td>
                                                    <td>
                                                        소요기간 2
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <!-- 오늘 일정 card -->
                                <div class="card card-white-1 mb-4">
                                    <div class="card-body">
                                        <a href="#" class="text-dark fw-600">오늘 일정<i class="bi bi-chevron-right"></i></a>
                                        <div class="mt-3">
                                            <table>
                                                <tr class="text-primary">
                                                    <th>시간</th>
                                                    <th>내용</th>
                                                </tr>
                                                <tr>
                                                    <td>12:00</td>
                                                    <td>오늘 일정 1</td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="card card-white-1">
                                    <div class="card-body">
                                        <select class="border p-1 fw-600">
                                            <option value="#" selected>전체 진행도</option>
                                            <option value="#">그래프2</option>
                                            <option value="#">그래프3</option>
                                        </select>
                                        <p class="my-8">그래프 들어갈 자리</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <script>
            // 뷰포트의 세로 길이
            var viewportHeight = window.innerHeight || document.documentElement.clientHeight;

            const dashboardMenu = document.getElementById("dashboardMenu");
            const offcanvasDashboardMenu = document.getElementById("offcanvasDashboardMenu");

            // menuContent의 내용을 offcanvasMenuContent에 가져와서 화면에 출력
            offcanvasDashboardMenu.innerHTML = dashboardMenu.innerHTML;
        </script>
        <!-- 부트스트랩 script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>