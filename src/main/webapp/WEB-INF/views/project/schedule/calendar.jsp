<%-- 
    Document   : schedule
    Created on : 2023. 9. 3., 오후 2:55:23
    Author     : qntjd
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                    <div class="card card-white-0 mx-auto">
                        <div class="col-lg-10 col-md-11 col-12 mx-auto my-5">
                            <h4 class="fw-600 mb-4">
                                일정목록
                            </h4>
                            <div class="card card-white-1 mt-3">
                                <div class="card-body">
                                    <div id='calendar'></div>
                                    <div id="myModal" class="modal"></div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Modal -->
        <div class="modal fade" id="openModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="w-100 d-flex justify-content-between align-items-center">
                            <h3 class="modal-title fw-600" id="modalTitle">일정</h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                    </div>
                    <div class="modal-body">
                        <input id="sid" type="text" hidden>
                        <input id="msid" type="text" hidden>
                        <input id="mid" type="text" hidden>
                        <input id="hasRight" type="text" value="${sessionScope.hasRight}" hidden>
                        <table class="table table-borderless">
                            <tr>
                                <th style="width:25%"><label for="title">제목<span class="text-danger">*</span></label>
                                </th>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <input type="text" id="title" name="title" class="form-control" required>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th><label for="startDate">시작 날짜<span class="text-danger">*</span></label></th>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <input type="date" id="startDate" name="startDate" class="form-control">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th><label for="endDate">종료 날짜<span class="text-danger">*</span></label></th>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <input type="date" id="endDate" name="endDate" class="form-control">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th></th>
                                <td>
                                    <div class="d-flex align-items-center justify-content-end">
                                        <button id="changeTypeBtn" type="button" class="btn btn-gray fw-500" style="width: 8rem;">시간 사용하기</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th><label for="content">내용</label></th>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <textArea id="content" class="form-control"></textArea>
                                    </div>
                                </td>
                            </tr>
                            <tr id="colorSelectDiv">
                                <th><label for="colorSelect">배경</label></th>
                                <td>
                                    <div class="w-100">
                                        <select id="colorSelect" class="w-100 form-select" style="background-color: #43aef2; appearance: none;">
                                            <option value="#43aef2" class="m-1" style="background-color: #43aef2;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                            <option value="#84e45c" class="m-1" style="background-color: #84e45c;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                            <option value="#f24d43" class="m-1" style="background-color: #f24d43;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th><label for="addMember">팀원</label></th>
                                <td>
                                    <div id="addMemberDiv">
                                        <div class=" d-flex align-items-center w-100">
                                            <div style="position: relative; width: auto;">
                                                <input type="text" id="addMember" name="addMember" class="form-control"  autocomplete="off" readonly>
                                                <div id="searchMember" class="dropdown-menu">
                                                </div>
                                            </div>
                                            <button id="addMemberBtn" type="button" class="btn btn-gray fw-500 ms-2" style="width: 8rem;">추가</button>
                                        </div>
                                    </div>
                                    <div id="memberListDiv" class="p-1">
                                        <div class="p-1 rounded" style="border: 1px solid #c4c4c4;">
                                            <img src="/monitoring/asset/profile.png" alt="프로필 이미지" class="rounded-circle">
                                            <span class="bold">asd</span>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="saveSchedule" class="btn btn-primary fw-500"
                            style="width: 7rem;">등록하기</button>
                        <button type="button" id="updateSchedule" class="btn btn-primary fw-500"
                            style="width: 7rem;">수정하기</button>
                        <button type="button" id="editSchedule" class="btn btn-primary fw-500"
                                style="width: 7rem;">수정하기</button>
                        <button type="button" id="deleteSchedule" class="btn btn-danger fw-500"
                        style="width: 7rem;">삭제하기</button>
                    </div>
                </div>
            </div>
        </div>

                        

        <script>
            //날짜 유효성 검사
            const startDateInput = document.getElementById('startDate');
            const endDateInput = document.getElementById('endDate');

            startDateInput.addEventListener('change', () => {
                const startDate = new Date(startDateInput.value);
                const endDate = new Date(endDateInput.value);

                if (startDate > endDate) {
                    alert('종료 날짜는 시작 날짜보다 빠를 수 없습니다.');
                    startDateInput.value = ''; // 입력 내용 초기화
                }
            });

            endDateInput.addEventListener('change', () => {
                const startDate = new Date(startDateInput.value);
                const endDate = new Date(endDateInput.value);

                if (endDate < startDate) {
                    alert('종료 날짜는 시작 날짜보다 빠를 수 없습니다.');
                    endDateInput.value = ''; // 입력 내용 초기화
                }
            });
            
            document.addEventListener("DOMContentLoaded", function () {
                var linkElement = document.querySelector('#side_calendar');

                //사이드바에서 일정 진하게 보이도록 수정
                if (linkElement) {
                    linkElement.classList.remove('img-opacity');
                }


                const dashboardMenu = document.getElementById("dashboardMenu");
                const offcanvasDashboardMenu = document.getElementById("offcanvasDashboardMenu");

                // menuContent의 내용을 offcanvasMenuContent에 가져와서 화면에 출력
                offcanvasDashboardMenu.innerHTML = dashboardMenu.innerHTML;
                //offcanvas에서 일정 진하게 보이도록 수정
                offcanvasDashboardMenu.classList.remove('img-opacity');
            });
        </script>
        <!-- 부트스트랩 script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src='/monitoring/js/schedule/index.global.js'></script>
        <script src='/monitoring/js/schedule/schedule.js'></script>
        <script src='/monitoring/js/schedule/calendar.js'></script>
        <script src='/monitoring/js/user/search.js'></script>
    </body>
</html>
