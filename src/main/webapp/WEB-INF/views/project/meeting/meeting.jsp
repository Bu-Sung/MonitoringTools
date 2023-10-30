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
                                    <div class="meeing-title" style="font-size: 2rem; overflow-wrap: break-word; word-break: break-all;">${meeting.title}</div>
                                    <c:if test="${sessionScope.myInfo.hasRight == 1 || (sessionScope.myInfo.hasRight == 2 && sessionScope.myInfo.uname == meeting.writer)}">
                                        <div class="d-flex">
                                            <a href="update/${meeting.id}" style="height: 2rem;"><button type="button" class="btn btn-primary me-2" style="width: 4rem;">수정</button></a>
                                            <a href="delete/${meeting.id}" style="height: 2rem;"><button type="button" class="btn btn-danger" style="width: 4rem;">삭제</button></a>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="row mt-3">
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
                    <table class="table table-borderless">
                        <tr>
                            <th style="width:25%"><label for="title">제목<span class="text-danger">*</span></label>
                            </th>
                            <td>
                                <div class="d-flex align-items-center">
                                    <input type="text" id="scheduleTitle" class="form-control" readonly>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="startDate">시작 날짜<span class="text-danger">*</span></label></th>
                            <td>
                                <div class="d-flex align-items-center">
                                    <input type="date" id="startDate" class="form-control" readonly>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="endDate">종료 날짜<span class="text-danger">*</span></label></th>
                            <td>
                                <div class="d-flex align-items-center">
                                    <input type="date" id="endDate" class="form-control" readonly>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="content">내용</label></th>
                            <td>
                                <div class="d-flex align-items-center">
                                    <textArea id="scheduleContent" class="form-control" readonly></textArea>
                           </div>
                       </td>
                   </tr>
                   <tr id="colorSelectDiv">
                       <th><label for="colorSelect">배경</label></th>
                       <td>
                           <div class="w-100" >
                               <div id="colorSelect" class="w-100" style="height: 2.5rem; border-radius:0.3rem;">&nbsp</div>
                           </div>
                       </td>
                   </tr>
                   <tr>
                       <th><label for="addMember">팀원</label></th>
                       <td>
                           <div id="memberListDiv" class="p-1">
                           </div>
                       </td>
                   </tr>
               </table> 
           </div>
       </div>
    </div>

    <script charset="UTF-8" src="/monitoring/js/schedule/schedule.js"></script>
    <script>

        document.addEventListener('DOMContentLoaded', function () {
            let editableElements = document.querySelectorAll('[contenteditable="true"]');

            editableElements.forEach(function (element) {
                element.setAttribute('contenteditable', 'false');
                if(element.innerHTML ===''){
                    element.innerHTML ='&nbsp;';
                }
            });

            let pageSchedule = document.querySelectorAll("div[name]");

            scheduleList = ${scheduleList};
            settingReadScheduleList();
            // scheduleList에서 모든 msid 값을 추출
//            let msidValues = scheduleList.map(schedule => schedule.msid);
//            console.log(scheduleList);
//            // 각 pageSchedule 요소를 순회하며 이름이 msidValues에 포함되어 있는지 확인
//            pageSchedule.forEach(element => {
//                if (!msidValues.includes(Number(element.getAttribute('name')))) {
//                    element.remove();
//                }
//            });
//
//            document.querySelectorAll('small').forEach(function (element) {
//                element.addEventListener('click', function (event) {
//                    settingReadSchedule(event);
//                    var myModal = new bootstrap.Modal(document.getElementById('openModal'), {});
//                    myModal.show();
//                });
//            });


        });

        async function settingReadScheduleList() {
            let pageSchedule = document.querySelectorAll("div[name]");

            let msidValues = scheduleList.map(schedule => schedule.msid);

            for (let element of pageSchedule) {
                let num = Number(element.getAttribute('name'));
                if (!msidValues.includes(num)) {
                    element.remove();
                } else {
                    let targetSchedule = scheduleList[num];
                    let startDateValue = targetSchedule.start;
                    let endDateValue = targetSchedule.end;
                    if (!targetSchedule.allTime) {
                        startDateValue = changeDateTimeToDate(targetSchedule.start);
                        var tmp = new Date(targetSchedule.end);
                        endDateValue = changeDateTimeToDate(toLocalISOString(tmp.setDate(tmp.getDate() - 1)));
                    }
                    element.innerHTML = '';
                    var small = document.createElement('small');
                    small.className = 'scheduleText';
                    if (startDateValue === endDateValue) {
                        small.textContent = startDateValue.replace("T", " ");
                    } else {
                        small.textContent = startDateValue.replace("T", " ") + ' ~ ' + endDateValue.replace("T", " ");
                    }
                    element.appendChild(small);
                    settingReadSchedule(element);
                    scheduleList[num].memberList = await getScheduleMemberList(targetSchedule.sid);
                }
            }
        }

        function settingReadSchedule(div) {
            div.addEventListener("click", function (event){
                var eventDiv = null;
                if (!event.target.getAttribute('name')) {
                    eventDiv = event.target.parentNode;
                } else {
                    eventDiv = event.target;
                }
                console.log(eventDiv);
                var item = scheduleList.find(function (element) {
                    return element.msid === Number(eventDiv.getAttribute('name'));
                });
                var start = toLocalISOString(item.start);
                var end = toLocalISOString(item.end);
                var dateType = "datetime-local";
                var startDateValue = start;
                var endDateValue = end;
                if (!item.allDay) {
                    dateType = "date";
                    startDateValue = changeDateTimeToDate(start);
                    var tmp = new Date(end);
                    endDateValue = changeDateTimeToDate(toLocalISOString(tmp.setDate(tmp.getDate() - 1)));
                }
                console.log(item);
                document.getElementById("scheduleTitle").value = item.title;
                document.getElementById("startDate").type = dateType;
                document.getElementById("startDate").value = startDateValue;
                document.getElementById("endDate").type = dateType;
                document.getElementById("endDate").value = endDateValue;
                document.getElementById("scheduleContent").value = item.content;
                document.getElementById("colorSelect").style.backgroundColor = item.color;
                memberList = item.memberList;
                memberListDiv.innerHTML = '';
                memberList.forEach(element => {
                    var card = createProfileCard(element.name, element.id);
                    var cardDiv = document.createElement("div");
                    cardDiv.className = "d-flex flex-column col-11";
                    cardDiv.appendChild(card);
                    memberListDiv.appendChild(cardDiv);      
                });
                var myModal = new bootstrap.Modal(document.getElementById('openModal'), {});
                myModal.show();
            });
            
        }

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
            <script charset="UTF-8" src="/monitoring/js/user/search.js"></script>
    <!--<script src="https://cdn.jsdelivr.net/npm/marked@4.0.3/lib/marked.min.js"></script>-->
    <!-- 부트스트랩 script -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>