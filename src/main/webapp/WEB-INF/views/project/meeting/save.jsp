
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
        <%@include file="/jspf/projectSidebar.jspf"%>

        <div class="w-100">
            <!-- navbar -->
            <%@include file="/jspf/projectTopbar.jspf"%>
            <!-- 제일 아래에 깔려 있는 파란색 card -->
            <div class="card card-blue row mx-auto mb-5" style="height: viewportHeight;">
                <!-- 중간에 깔려 있는 card -->
                <div class="card card-white-0 mx-auto" style="height: viewportHeight;">
                    <div class="col-md-10 col-11 mx-auto my-5">
                        <h4 class="fw-600 text-dark mb-4">회의록 작성 페이지</h4>
                        <div class="card card-white-1 p-4">
                            <div id="meeting">
                                <form id="documentForm" method="POST" action="addMeeting" enctype="multipart/form-data"
                                      onsubmit="saveDocument()">
                                    <input class="form-control mb-4" style="font-size: 2rem; height: 4rem;" type="text"
                                           id="title" class="document-title" placeholder="제목을 입력하세요" name="title" required maxlength="40">
                                    <div class="row">
                                        <div class="col-md-6"> <!-- 중간 크기 이상의 화면에서는 날짜 영역을 절반의 너비로 표시 -->
                                            <table style="width: 100%;">
                                                <tr class="row">
                                                    <th>날짜</th>
                                                    <td>
                                                        <div class="d-flex align-items-center mb-2">
                                                            <span style="width: 3rem;">시작</span>
                                                            <input class="form-control form-control-sm"
                                                                   type="datetime-local" id="inputDateStart" name="start" required="">
                                                        </div>
                                                        <div class="d-flex align-items-center mb-md-5 mb-4">
                                                            <span style="width: 3rem;">종료</span>
                                                            <input class="form-control form-control-sm"
                                                                   type="datetime-local" id="inputDateEnd" name="end" required>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="col-md-6 mb-5">
                                            <div class="align-items-center">
                                                <span class="fw-bold">장소</span>
                                                <input class="form-control" type="text" class="form-control"
                                                       id="inputPlace" autocomplete="off" placeholder="회의 장소를 입력해주세요!"
                                                       name="place">
                                            </div>
                                        </div>
                                    </div>

                                    <input class="form-control border mb-3" type="file" name="file" multiple>
                                    <div id="content" class="document-content">
                                        <div class="document-content-explanation">
                                            <h2>단축키 설명</h2>
                                            <div style="text-align: left;" class="mb-5">
                                                # => h1<br>
                                                ## => h2<br>
                                                ### => h3<br>
                                                - => •<br>
                                                /일정 => 일정 등록<br>
                                            </div>
                                        </div>
                                    </div>

                            </div>
                            <button class="btn btn-primary sticky-bottom mt-3" style="bottom:2rem;"
                                    type="submit">저장하기</button>
                            </form>
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
                        <h3 class="modal-title" id="modalTitle">일정</h3>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                </div>
                <div class="modal-body">
                    <table class="table table-borderless">
                        <tr>
                            <th style="width:25%"><label for="title">제목<span class="text-danger">*</span></label>
                            </th>
                            <td>
                                <div class="d-flex align-items-center">
                                    <input type="text" id="scheduleTitle" class="form-control" required>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="startDate">시작 날짜<span class="text-danger">*</span></label></th>
                            <td>
                                <div class="d-flex align-items-center">
                                    <input type="date" id="startDate" class="form-control">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="endDate">종료 날짜<span class="text-danger">*</span></label></th>
                            <td>
                                <div class="d-flex align-items-center">
                                    <input type="date" id="endDate" class="form-control">
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
                                       <input type="text" id="addMember" class="form-control"  autocomplete="off" readonly>
                                       <div id="searchMember" class="dropdown-menu">
                                       </div>
                                   </div>
                                   <button id="addMemberBtn" type="button" class="btn btn-gray fw-500 ms-2" style="width: 8rem;">추가</button>
                               </div>
                           </div>
                           <div id="memberListDiv" class="p-1">
                           </div>
                       </td>
                   </tr>
               </table> 
           </div>
           <div class="modal-footer">
               <button type="button" id="addSchedule" class="btn btn-primary fw-500"
                   style="width: 8rem; height: 3rem;">등록하기</button>
               <button type="button" id="editSchedule" class="btn btn-primary fw-500"
                       style="width: 8rem; height: 3rem;">수정하기</button>
           </div>
       </div>
    </div>

    <script>
            //날짜 유효성 검사
            const startDateInput = document.getElementById('inputDateStart');
            const endDateInput = document.getElementById('inputDateEnd');

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
                var linkElement = document.querySelector('#side_meeting');
                let paramPage = new URLSearchParams(window.location.search).get('page');
                //사이드바에서 회의록 진하게 보이도록 수정
                if (linkElement) {
                    linkElement.classList.remove('img-opacity');
                }

                var liItems = document.querySelectorAll("#pageList .page-item a");
                liItems.forEach(function (item) {
                    if (item.textContent.trim() === String(paramPage)) {
                        item.style.backgroundColor = "#369FFF";
                        item.style.color = "white";
                    }
                });

                const dashboardMenu = document.getElementById("dashboardMenu");
                const offcanvasDashboardMenu = document.getElementById("offcanvasDashboardMenu");

                // menuContent의 내용을 offcanvasMenuContent에 가져와서 화면에 출력
                offcanvasDashboardMenu.innerHTML = dashboardMenu.innerHTML;
                //offcanvas에서 회의록 진하게 보이도록 수정
                offcanvasDashboardMenu.classList.remove('img-opacity');
            });
        </script>
    <!--<script src="https://cdn.jsdelivr.net/npm/marked@4.0.3/lib/marked.min.js"></script>-->
    <script charset="UTF-8" src="/monitoring/js/document/document.js"></script>
    <script charset="UTF-8" src="/monitoring/js/document/keyEvent.js"></script>
    <script charset="UTF-8" src="/monitoring/js/document/mdFunction.js"></script>
    <script charset="UTF-8" src="/monitoring/js/schedule/schedule.js"></script>
    <script charset="UTF-8" src="/monitoring/js/user/search.js"></script>
    <!-- 부트스트랩 script -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>