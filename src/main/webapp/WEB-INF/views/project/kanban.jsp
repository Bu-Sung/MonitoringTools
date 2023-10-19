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
                    <div class="card card-white-0 mx-auto" style="height: viewportHeight;">
                        <div class="col-11 mx-auto my-5">
                            <div class="row row-cols-lg-5 row-cols-md-3 row-cols-2 mx-auto">
                                <!-- 백로그 영역 -->
                                <div class="col mb-3">
                                    <div class="card card-white-1 align-items-center mx-1">
                                        <div class="card-header py-3 fw-600 text-primary">
                                            백로그
                                        </div>
                                        <div id="backlog" class="card-body w-100 memo-list">
                                            <c:forEach items="${request}" var="list">
                                                <c:if test="${list.stage eq '대기' && list.target != 'true'}">
                                                    <div class="memo-yellow" data-bs-toggle="modal" data-memoid="${list.frid}" data-requestUser="${list.uid}"  data-bs-target="#myModal">
                                                        ${list.name}
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                                <!-- 할 일 영역 -->
                                <div class="col mb-3">
                                    <div class="card card-white-1 align-items-center mx-1">
                                        <div class="card-header py-3 fw-600 text-primary">
                                            할 일
                                        </div>
                                        <div id="todo" class="card-body w-100 memo-list">
                                            <c:forEach items="${request}" var="list">
                                                <c:if test="${list.stage != '대기' && list.stage != '테스트' && list.stage != '완료' && list.target != 'true'}">
                                                    <div class="memo-yellow" data-bs-toggle="modal" data-memoid="${list.frid}" data-requestUser="${list.uid}"  data-bs-target="#myModal">
                                                        ${list.name}
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                                <!-- 진행 중 영역 -->
                                <div class="col mb-3">
                                    <div class="card card-white-1 align-items-center mx-1">
                                        <div class="card-header py-3 fw-600 text-primary">
                                            진행 중
                                        </div>
                                        <div id="progress" class="card-body w-100 memo-list">
                                            <c:forEach items="${request}" var="list">
                                                <c:if test="${list.stage != '대기' && list.stage != '완료' && list.target == 'true'}">
                                                    <div class="memo-yellow" data-bs-toggle="modal" data-memoid="${list.frid}" data-requestUser="${list.uid}"  data-bs-target="#myModal">
                                                        ${list.name}
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                                <!-- 테스트 영역 -->
                                <div class="col mb-3">
                                    <div class="card card-white-1 align-items-center mx-1">
                                        <div class="card-header py-3 fw-600 text-primary">
                                            테스트
                                        </div>
                                        <div id="test" class="card-body w-100 memo-list">
                                            <c:forEach items="${request}" var="list">
                                                <c:if test="${list.stage eq '테스트' && list.target != 'true'}">
                                                    <div class="memo-yellow" data-bs-toggle="modal" data-memoid="${list.frid}" data-requestUser="${list.uid}" data-bs-target="#myModal">
                                                        ${list.name}
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                                <!-- 완료 영역 -->
                                <div class="col mb-3">
                                    <div class="card card-white-1 align-items-center mx-1">
                                        <div class="card-header py-3 fw-600 text-primary">
                                            완료
                                        </div>
                                        <div id="clear" class="card-body w-100 memo-list">
                                            <c:forEach items="${request}" var="list">
                                                <c:if test="${list.stage eq '완료' && list.target != 'true'}">
                                                    <div class="memo-yellow" data-bs-toggle="modal" data-memoid="${list.frid}" data-requestUser="${list.uid}" data-bs-target="#myModal">
                                                        ${list.name}
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <!-- 모달 제목을 동적으로 설정할 수 있도록 모달에 id를 부여합니다. -->
            <div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <!-- 모달 헤더 -->
                        <div class="modal-header">
                            <!-- 모달 제목 = 영역 이름 (ex. 백로그) -->
                            <h5 class="modal-title fw-600" id="modalTitle"></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <!-- 모달 내용 -->
                        <div class="modal-body">
                            <table class="table">
                                <tr>
                                    <th style="width: 25%">담당자</th>
                                    <td><input type="text" id="user" class="form-control" readonly></td>
                                </tr>
                                <tr>
                                    <th>내용</th>
                                    <td><textarea class="form-control custom-textarea" id="memoContent"
                                                  style="height: 7rem;" readonly>

                                            <!-- 여기 내용은 노란 영역에서 불러온 내용 가져와서 출력됨. 여기다가 또 불러올 필요 x -->
                                            <!-- script 참고 -->

                                        </textarea>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                let requestList = [];

                // 뷰포트의 세로 길이
                var viewportHeight = window.innerHeight || document.documentElement.clientHeight;

                const dashboardMenu = document.getElementById("dashboardMenu");
                const offcanvasDashboardMenu = document.getElementById("offcanvasDashboardMenu");

                // menuContent의 내용을 offcanvasMenuContent에 가져와서 화면에 출력
                offcanvasDashboardMenu.innerHTML = dashboardMenu.innerHTML;

                document.addEventListener('DOMContentLoaded', function () {
                    let lastDragStartEvent; // 메모지를 선택 했을 때 memo-list의 제목 값을 담을 외부 변수
                    let draggedItem = null;
                    //getAllRequest();
                    // memo-yellow를 드래그 시작할 때 이벤트 핸들러
                    document.addEventListener('dragstart', function (e) {
                        let target = e.target;
                        if (e.target.classList.contains('memo-yellow')) {
                            draggedItem = target;
                            lastDragStartEvent = target.parentNode.id;
                        }
                    });

                    // memo-list에 드롭할 때 이벤트 핸들러
                    document.addEventListener('dragover', function (e) {
                        e.preventDefault();
                    });

                    // memo-list에 드롭했을 때 이벤트 핸들러
                    document.addEventListener('drop', function (e) {
                        e.preventDefault();
                        if (lastDragStartEvent !== e.srcElement.id) {
                            if (draggedItem && e.target.classList.contains('memo-list')) {
                                // 드래그된 memo-yellow 요소를 이동
                                const memoList = e.target;

                                memoList.appendChild(draggedItem);

                                const request = {
                                    frid: draggedItem.dataset.memoid,
                                    stage: e.srcElement.id
                                };
                                let xhr = new XMLHttpRequest();
                                xhr.open("POST", "/monitoring/project/changeSprint", false);
                                xhr.setRequestHeader("Content-Type", "application/json");

                                xhr.onreadystatechange = function () {
                                    if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
                                        xhr.responseText;
                                    }
                                }

                                xhr.send(JSON.stringify(request));
                                draggedItem = null; // 드롭 후에는 draggedItem 초기화
                            }
                        }
                    });

                    // 같은 memo-list 내에서 위에서 아래로 드래그 앤 드롭 기능 활성화
                    const memoLists = document.querySelectorAll('.memo-list');
                    memoLists.forEach(function (memoList) {
                        new Sortable(memoList, {
                            animation: 150, // 드래그 앤 드롭 애니메이션 지속 시간 (밀리초)
                            swap: true // 위에서 아래로, 아래에서 위로 모두 이동 가능하도록 설정
                        });
                    });

                    const memoContentTextarea = document.getElementById('memoContent');

                    // memo-yellow 요소들의 드래그 기능 활성화
                    const memoYellows = document.querySelectorAll('.memo-yellow');
                    memoYellows.forEach(function (yellow) {
                        yellow.draggable = true;
                        yellow.addEventListener('click', function () {
                            const content = yellow.textContent.trim(); // 선택한 memo-yellow의 텍스트 내용 가져오기
                            memoContentTextarea.value = content; // 모달 내용 textarea에 내용 설정
                        });
                    });

                    // 모달 제목  = 영역 이름으로 설정
                    const memoDivLists = document.querySelectorAll('.card-white-1');

                    memoDivLists.forEach(function (memoList) {
                        memoList.addEventListener('click', function (e) {
                            // 클릭한 영역의 제목을 가져와 모달 제목으로 설정합니다.
                            const clickedTitle = memoList.querySelector('.card-header').textContent.trim();
                            const modalTitle = document.getElementById('modalTitle');
                            modalTitle.textContent = clickedTitle;
                            const modalUser = document.getElementById('user');
                            modalUser.value = e.target.dataset.requestuser;
                        });
                    });
                });
            </script>

            <!-- 부트스트랩 script -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

            <!-- Sortable.js 라이브러리 추가 -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.14.0/Sortable.min.js"></script>


    </body>

</html>