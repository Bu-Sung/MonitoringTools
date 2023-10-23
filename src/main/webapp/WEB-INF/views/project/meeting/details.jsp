<%-- Document : meetingSave Created on : 2023. 8. 20., 오전 3:48:33 Author : qntjd --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
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
                        <h4 class="fw-600 text-dark mb-4">회의록 작성 페이지</h4>
                        <div class="card card-white-1 p-4">
                            <div id="meeting">
                                <form id="documentForm" method="POST" action="update"
                                      enctype="multipart/form-data" onsubmit="updateDocument()">
                                    <input type="text" name="id" value="${meeting.id}" hidden>
                                    <input type="text" name="writer" value="${meeting.writer}" hidden>
                                    <input class="form-control mb-4 document-title"
                                           style="font-size: 2rem; height: 4rem;" type="text" id="title"
                                           placeholder="제목을 입력하세요" name="title"  value="${meeting.title}" required maxlength="40">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <!-- 중간 크기 이상의 화면에서는 날짜 영역을 절반의 너비로 표시 -->
                                            <table style="width: 100%;">
                                                <tr class="row">
                                                    <th>날짜</th>
                                                    <td>
                                                        <div class="d-flex align-items-center mb-2">
                                                            <span style="width: 3rem;">시작</span>
                                                            <input class="form-control form-control-sm"
                                                                   type="datetime-local"
                                                                   id="inputDateStart" name="start"
                                                                   value="${meeting.start}">
                                                        </div>
                                                        <div
                                                            class="d-flex align-items-center mb-md-5 mb-4">
                                                            <span style="width: 3rem;">종료</span>
                                                            <input class="form-control form-control-sm"
                                                                   type="datetime-local" id="inputDateEnd"
                                                                   name="end" value="${meeting.end}">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="col-md-6 mb-5">
                                            <div class="align-items-center">
                                                <span class="fw-bold">장소</span>
                                                <input class="form-control" type="text"
                                                       class="form-control" id="inputPlace"
                                                       autocomplete="off" placeholder="회의 장소를 입력해주세요!"
                                                       name="place" value="${meeting.place}">
                                            </div>
                                        </div>
                                    </div>
                                    <div id="file-container" class="col-10">
                                        <ul class='list-unstyled' id="ulfile">
                                            <c:forEach items="${meeting.files}" var="file">
                                                <li class="m-0" ><a href="../download?filename=${file}&mid=${meeting.id}">${file}</a><span
                                                        onclick="removefile(event)">&nbsp;삭제</span></li>
                                                    </c:forEach>
                                        </ul>
                                    </div>
                                    <input class="form-control border mb-3" id="file" type="file" name="file"
                                           multiple>
                                    <div id="content" class="document-content">
                                        ${meeting.content}
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
                    <table class="table table-borderless">
                        <tr>
                            <th style="width:25%"><label for="title">제목<span class="text-danger">*</span></label>
                            </th>
                            <td>
                                <div class="d-flex align-items-center">
                                    <input type="text" id="scheduleTitle" class="form-control" required maxlength="40">
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
                                    
    
    <!--<script src="https://cdn.jsdelivr.net/npm/marked@4.0.3/lib/marked.min.js"></script>-->
    <script charset="UTF-8" src="/monitoring/js/document/document.js"></script>
    <script charset="UTF-8" src="/monitoring/js/document/keyEvent.js"></script>
    <script charset="UTF-8" src="/monitoring/js/document/mdFunction.js"></script>
    <script charset="UTF-8" src="/monitoring/js/schedule/schedule.js"></script>
    <script charset="UTF-8" src="/monitoring/js/user/search.js"></script>
    <script>
      const startDateInput = document.getElementById('startDate');
      const endDateInput = document.getElementById('endDate');

      startDateInput.addEventListener('input', () => {
        const startDate = new Date(startDateInput.value);
            const endDate = new Date(endDateInput.value);

        // 시작 날짜가 미래 날짜일 경우 경고 표시
        if (startDate > endDate) {
            alert('종료 날짜는 시작 날짜보다 빠를 수 없습니다.');
          startDateInput.value = '';
        }
      });

      endDateInput.addEventListener('input', () => {
            const startDate = new Date(startDateInput.value);
        const endDate = new Date(endDateInput.value);

                // 종료 날짜가 과거 날짜일 경우 경고 표시
        if (endDate < startDate) {
          alert('종료 날짜는 시작 날짜보다 빠를 수 없습니다.');
          endDateInput.value = '';
        }
                });

        
            let pageSchedule = document.querySelectorAll("div[name]");
             scheduleList = ${scheduleList};

            // scheduleList에서 모든 msid 값을 추출
                     let msidValues = scheduleList.map(schedule => schedule.msid);

            // 각 pageSchedule 요소를 순회하며 이름이 msidValues에 포함되어 있는지 확인
                         pageSchedule.forEach(element => {
                setScheduleClickEvent(element);
                         if (!msidValues.includes(Number(element.getAttribute('name')))) {
                    element.remove();
                }
                     });
        
                 //        var divs = document.querySelectorAll('div[name]'); // class가 'scheduleDiv'이며 name 속성을 가진 모든 div 요소를 가져옵니다.
                 //        let max = 0;
    //        for (var i = 0; i < divs.length; i++) { // 각각의 div에 대하여
                     //            setScheduleClickEvent(divs[i]);
    //            var nameValue = Number(divs[i].getAttribute('name')); // name 속성 값을 숫자로 변환합니다.
                     //            if (!isNaN(nameValue)) { // 만약 nameValue가 유효한 숫자라면
                     //                listCount = Math.max(max, nameValue); // 현재 최대값과 비교하여 더 큰 값으로 업데이트합니다.
    //                listCount++;
    //            }
    //        }
                 
            let max = 0;
            scheduleList.forEach(element => {
            
                         var nameValue = element.msid; // name 속성 값을 숫자로 변환합니다.
                         if (!isNaN(nameValue)) { // 만약 nameValue가 유효한 숫자라면
                     listCount = Math.max(max, nameValue); // 현재 최대값과 비교하여 더 큰 값으로 업데이트합니다.
                    listCount++;
                }
                 console.log(listCount);
            });
            console.log(scheduleList);
        
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
    <!-- 부트스트랩 script -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>