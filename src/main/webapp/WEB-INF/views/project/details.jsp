<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

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
            <%@include file="/jspf/projectSidebar.jspf" %>

            <div class="w-100">
                <!-- navbar -->
                <%@include file="/jspf/projectTopbar.jspf" %>
                <!-- 제일 아래에 깔려 있는 파란색 card -->
                <div class="card card-blue row mx-auto" style="height: viewportHeight;">
                    <!-- 중간에 깔려 있는 card -->
                    <div class="card card-white-0 mx-auto">

                        <div class="col-md-9 col-11 mx-auto my-5">
                            <form action="/monitoring/project/updateProject" method="post">
                                <input class="form-control form-control-primary" value="${project.pid}"
                                       hidden name="pid">

                                <div class="card card-white-1 p-3 mb-3">
                                    <h6 class="mb-1 fw-600">프로젝트 명<span class="text-danger">*</span></h6>
                                    <small class="text-gray mb-3">20자 이하로 작성해주세요</small>
                                    <input type="text" name="name" class="form-control form-control-primary"
                                           value="${project.name}" required maxlength="20">
                                </div>

                                <div class="card card-white-1 p-3 mb-3">
                                    <h6 class="mb-1 fw-600">프로젝트 설명</h6>
                                    <small class="text-gray mb-3">30자 이하로 작성해주세요</small>
                                    <textarea class="form-control form-control-primary"
                                              style="height: 5rem;" name="content" maxlength="30">${project.content}</textarea>
                                </div>

                                <div class="card card-white-1 p-3 mb-3">
                                    <div class="row">
                                        <div class="col-md-6 col-12">
                                            <h6 class="mb-3 fw-600"> 프로젝트 시작 기간<span class="text-danger">*</span></h6>
                                            <input type="date" id="start_date"
                                                   class="form-control form-control-primary mb-md-0 mb-4"
                                                   value="${project.start}" name="start" required>
                                        </div>
                                        <div class="col-md-6 col-12">
                                            <h6 class="mb-3 fw-600"> 프로젝트 종료 기간<span class="text-danger">*</span></h6>
                                            <input type="date" id="end_date" class="form-control form-control-primary"
                                                   value="${project.end}" name="end" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="card card-white-1 p-3 mb-3">
                                    <h6 class="mb-1 fw-600">스프린트 주기<span class="text-danger">*</span></h6>
                                    <small class="text-gray mb-3">주기를 일(날짜) 단위로 작성해주세요</small>
                                    <input type="number" min="1" class="form-control form-control-primary"
                                           value="${project.cycle}" name="cycle" required>
                                </div>

                                <div class="card card-white-1 p-3 mb-3">
                                    <h6 class="mb-3 fw-600">게시글 카테고리</h6>
                                    <button type="button" class="btn btn-gray mb-2" style="border-width: 2px;"
                                            data-bs-toggle="modal" data-bs-target="#categoryModal" ${sessionScope.myInfo.hasRight == 3 ? 'disabled' : ''}>카테고리
                                        관리</button>
                                </div>

                                <div class="card card-white-1 p-3 mb-3">
                                    <h6 class="mb-3 fw-600">팀원</h6>
                                    <button type="button" class="btn btn-gray mb-2" style="border-width: 2px;"
                                            data-bs-toggle="modal" data-bs-target="#teamModal" ${sessionScope.myInfo.hasRight == 3 ? 'disabled' : ''}>팀원 관리</button>
                                </div>

                                <div class="card card-white-1 p-3 mb-5">
                                    <h6 class="mb-1 fw-600">프로젝트 삭제하기</h6>
                                    <small class="text-gray mb-3">프로젝트를 삭제하면 되돌리 수 없으니 신중하게 생각해주세요</small>
                                    <a href="delete/${project.pid}"><button type="button" class="btn btn-danger w-100 mt-2"  ${sessionScope.myInfo.hasRight == 1 ? '' : 'disabled'}>삭제하기</button></a>
                                </div>
                                <button type="submit" class="btn btn-primary w-100 position-sticky fs-5 fw-600" style="bottom:20px; height: 3rem;" ${sessionScope.myInfo.hasRight == 1 ? '' : 'disabled'}>저장하기</button>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 카테고리 관리 모달 창 -->
        <div class="modal fade" id="categoryModal" tabindex="-1" aria-labelledby="categoryModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content" style="max-height: 40rem; overflow-y: auto;">
                    <div class="modal-header">
                        <h5 class="modal-title fw-600" id="categoryModalLabel">카테고리 관리</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="white-space: normal;">
                        <!-- 입력 폼 -->
                        <div class="d-flex justify-content-between mb-4">
                            <input type="text" class="form-control form-control-secondary me-2" id="taskInput" placeholder="카테고리명을 입력하세요" maxlength="15">
                            <button type="button" class="btn btn-secondary" style="width: 5rem;" id="addTask" ${sessionScope.myInfo.hasRight == 1 ? '' : 'disabled'}>추가</button>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <p class="fw-600 m-0">카테고리 목록</p>
                            <button id="deleteTasks" class="text-danger" style="border-style: none; background-color: #fff;" ${sessionScope.myInfo.hasRight == 1 ? '' : 'disabled'}>삭제</button>
                        </div>
                        <div id="taskList">
                            <c:forEach var="cat" items="${project.categoryList}">
                                <div class="form-check mb-2">
                                    <input type="checkbox" class="form-check-input" data-cat="${cat}" ${cat eq '공지사항' ? 'disabled' : ''}>
                                    <label class="form-check-label ms-2" for="noticeCheckbox">${cat}</label>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <!--                    <div class=" modal-footer">
                                                                    <button type="button" class="btn btn-danger" id="deleteTasks">삭제</button>
                                            <button type="button" class="btn btn-primary" id="saveTasks" >저장</button>
                                        </div>-->
                </div>
            </div>
        </div>

        <!-- 팀원 관리 모달 창 -->
        <div class="modal fade" id="teamModal" tabindex="-1" aria-labelledby="teamModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title fw-600" id="teamModalLabel">팀원 관리</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="white-space: normal;">
                        <!-- 입력 폼 -->
                        <div class="d-flex justify-content-between mb-4">    
                            <div style="position: relative; flex-grow: 1;">
                                <input type="text" class="form-control form-control-secondary me-2" id="teamMemberInput"
                                       placeholder="팀원의 아이디를 입력하세요" autocomplete="off" maxlength="20">
                                <div id="searchMember" class="dropdown-menu "></div>
                            </div>
                            <button type="button" class="btn btn-secondary ms-2" style="width: 4rem" id="addTeamMember" ${sessionScope.myInfo.hasRight == 1 ? '' : 'disabled'}>추가</button>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <p class="fw-600 m-0" style="width: 8rem;">팀원 목록</p>
                            <button type="button" class="text-danger my-auto" style="border-style: none; background-color: #fff; height: fit-content" id="deleteTeamMembers" ${sessionScope.myInfo.hasRight == 1 ? '' : 'disabled'}>삭제</button>
                        </div>
                        <div id="teamList">
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <script>
            /*카테고리 관리*/
//            document.addEventListener('DOMContentLoaded', function () {
//                const input = document.getElementById('taskInput');
//                const addTaskButton = document.getElementById('addTask');
//                const taskList = document.getElementById('taskList');
//                const deleteTasksButton = document.getElementById('deleteTasks');
//                const saveTaskButton = document.getElementById("saveTasks");
//                const noticeCheckbox = document.getElementById('noticeCheckbox');
//                const existingCheckboxes = Array.from(document.querySelectorAll('.modal-body .form-check .form-check-input'));
//                //추가된 체크박스 리스트
//                let baseCat = existingCheckboxes;
//                let checkboxes = [];
//                // 추가 버튼 클릭 시 체크박스 추가
//                addTaskButton.addEventListener('click', function () {
//                    const taskContent = input.value.trim();
//                    if (taskContent) {
//                        const taskItem = document.createElement('div');
//                        taskItem.classList.add('form-check', 'mb-2');
//                        const checkbox = document.createElement('input');
//                        checkbox.type = 'checkbox';
//                        checkbox.classList.add('form-check-input');
//                        checkbox.setAttribute('data-cat', taskContent);
//                        taskItem.appendChild(checkbox);
//                        const label = document.createElement('label');
//                        label.classList.add('form-check-label', 'ms-2');
//                        label.textContent = taskContent;
//                        taskItem.appendChild(label);
//                        taskList.appendChild(taskItem);
//                        // 입력 필드 비우기
//                        // 체크박스 리스트에 추가
//                        input.value = '';
//                        checkboxes.push(checkbox);
//                    }
//                });
//                // 삭제 버튼 클릭 시 체크된 체크박스 삭제
//                deleteTasksButton.addEventListener('click', function () {
//                    baseCat = baseCat.filter(function (checkbox) {
//                        if (checkbox.checked) {
//                            checkbox.closest('.form-check').remove();
//                            return false; // 삭제된 체크박스는 리스트에서 제외
//                        }
//                        return true; // 그 외의 체크박스는 리스트에 유지
//                    });
//                    checkboxes = checkboxes.filter(function (checkbox) {
//                        if (checkbox.checked) {
//                            checkbox.closest('.form-check').remove();
//                            return false; // 삭제된 체크박스는 리스트에서 제외
//                        }
//                        return true; // 그 외의 체크박스는 리스트에 유지
//                    });
//                    });
//                //저장하기 버튼
//                saveTaskButton.addEventListener('click', function () {
//                    let saveList = [];
//                    baseCat.forEach(item => {
//                        saveList.push(item.dataset.cat);
//                    });
//                    checkboxes.forEach(item => { // 오타를 수정하였습니다.
//                        saveList.push(item.dataset.cat);
//                    });
//                    const data = {
//                        str: saveList.join(',')
//                    };
//                    fetch("/monitoring/project/updateCategory", {
//                        method: 'POST', // or ''
//                        headers: {
//                            'Content-Type': 'application/json',
//                        },
//                        body: JSON.stringify(data),
//                    })
//                            .then(response => response.text())
//                            .then(data => {
//
//                                if (data) {
//                                    location.reload();
//                                }
//                            })
//                            .catch((error) => {
//                                console.error('Error:', error);
//                            });
//                });
//                searchUsersList();
//                getMemberList().then(() => {
//                    reloadBaseTeam();
//                });
//
//            });



            document.addEventListener('DOMContentLoaded', function () {
                searchUsersList();
                getMemberList().then(() => {
                    reloadBaseTeam();
                });
            });


            // 카테고리 관리 
            let basecat = [];

            function getCategoryList() {
                basecat = [];
                return fetch('/monitoring/project/getCategory')  // fetch 요청은 Promise를 반환합니다.
                        .then(response => response.json())
                        .then(data => {
                            data.forEach(item => {
                                basecat.push(item);
                            });
                        })
                        .catch(error => {
                            console.error('Error:', error);
                        });
            }

            const addTaskButton = document.getElementById('addTask');
            const taskInput = document.getElementById('taskInput');
            const deleteTaskButton = document.getElementById('deleteTasks');
            const saveTaskButton = document.getElementById('saveTasks');

            function reloadBaseCategory() {
                const taskList = document.getElementById('taskList');

                taskList.innerHTML = '';
                for (let item of basecat) {
                    // 체크박스 생성
                    const taskcheckbox = document.createElement('input');
                    taskcheckbox.type = 'checkbox';
                    taskcheckbox.className = 'form-check-input me-2';
                    // 라벨 생성
                    const tasklabel = document.createElement('label');
                    tasklabel.className = 'form-check-label mx-2';
                    tasklabel.textContent = item;

                    // 공지사항인 체크박스 비활성화 
                    if (item === '공지사항') {
                        taskcheckbox.disabled = true;
                    }

                    // 모든 요소를 함께 랩핑
                    const taskDiv = document.createElement('div');
                    taskDiv.className = 'form-check mb-2 d-flex';
                    taskDiv.appendChild(taskcheckbox);
                    taskDiv.appendChild(tasklabel);

                    // 리스트에 추가
                    taskList.appendChild(taskDiv);
                }
            }

            addTaskButton.addEventListener('click', function () {
                const cate = taskInput.value.trim();
                if (cate === '') {
                    alert("카테고리를 입력해주세요.");
                    return;
                }

                fetch('/monitoring/project/addCategory', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: cate
                })
                        .then(response => response.json())
                        .then(isAvailable => {
                            if (isAvailable) {
                                getCategoryList().then(() => {
                                    reloadBaseCategory();
                                });
                            } else {
                                alert("이미 존재하는 카테고리입니다.");
                            }
                        })
                        .catch(error => console.error('Error:', error));

            });

            deleteTaskButton.addEventListener('click', function () {
                const taskcheckboxes = taskList.querySelectorAll('input[type="checkbox"]:checked');
                let tasks = [];
                taskcheckboxes.forEach(function (taskcheckbox) {
                    // 가장 가까운 '.form-check' 요소를 찾습니다.
                    const taskDiv = taskcheckbox.closest('.form-check');
                    // 해당 요소 내부의 라벨을 찾아 uid 값을 가져옵니다.
                    const tasklabel = taskDiv.querySelector('.form-check-label');
                    task = tasklabel.textContent;
                    tasks.push(task);

                });

                if (tasks.length === 0) {
                    alert("선택된 카테고리가 없습니다.");
                    return;
                }

                fetch(`/monitoring/project/deleteCategory`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(tasks)
                })
                        .then(response => response.json())
                        .then(data => {
                            getCategoryList().then(() => {
                                reloadBaseCategory();
                            });
                        })
                        .catch(error => console.error('Error:', error));
            });


            let baseteam = [];

            function getMemberList() {
                baseteam = [];
                return fetch('/monitoring/project/getMember')  // fetch 요청은 Promise를 반환합니다.
                        .then(response => response.json())
                        .then(data => {
                            data.forEach(item => {
                                baseteam.push(item);
                            });
                        })
                        .catch(error => {
                            console.error('Error:', error);
                        });
            }

            const addButton = document.getElementById('addTeamMember');
            const input = document.getElementById('teamMemberInput');
            //const teamList = document.getElementById('teamList');
            const deleteButton = document.getElementById('deleteTeamMembers');
            const saveButton = document.getElementById('saveTeam');

            // 작업 상태에 따른 상태 텍스트 매핑
            const statusText = {
                0: '생성자',
                1: '미수락',
                2: '수락',
            };

            function reloadBaseTeam() {
                const teamList = document.getElementById('teamList');
                teamList.innerHTML = '';
                for (let item of baseteam) {
                    // 체크박스 생성
                    const checkbox = document.createElement('input');
                    checkbox.type = 'checkbox';
                    checkbox.className = 'form-check-input me-2';
                    // 라벨 생성
                    const label = document.createElement('label');
                    label.className = 'form-check-label mx-2';
                    label.textContent = item.uid;
                    // 선택 옵션 생성 (마스터 권한, 게시물 작성 및 편집 권한, 보기 권한)
                    const select = document.createElement('select');
                    select.className = 'form-select-gray form-select-sm';
                    select.name = 'rights';
                    const option1 = document.createElement('option');
                    option1.value = '1';
                    option1.textContent = '마스터 권한';
                    const option2 = document.createElement('option');
                    option2.value = '2';
                    option2.textContent = '게시물 작성 및 편집 권한';
                    const option3 = document.createElement('option');
                    option3.value = '3';
                    option3.textContent = '보기 권한';
                    select.appendChild(option1);
                    select.appendChild(option2);
                    select.appendChild(option3);
                    option1.selected = item.right == '1';
                    option2.selected = item.right == '2';
                    option3.selected = item.right == '3';
                    select.addEventListener("change", function () {
                        fetch('/monitoring/project/updateRight', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify({uid: item.uid, right: this.value, state: item.state})
                        })
                                .then(response => response.json())
                                .then(data => getMemberList().then(() => {
                                        reloadBaseTeam()
                                    }))
                                .catch(error => console.error('Error:', error));
                    });
                    // 작업 상태에 따른 상태 텍스트 생성
                    // 여기에 작업 상태를 설정 (0, 1 또는 2)
                    // 작업 상태에 따른 상태 텍스트 생성
                    const statusSmall = document.createElement('small'); // 변수명 변경
                    statusSmall.className = 'text-gray my-auto ps-2';
                    statusSmall.textContent = statusText[item.state]; // 여기에 작업 상태를 설정 (0, 1 또는 2)


                    if (item.state === 0) {
                        checkbox.disabled = true;
                        select.disabled = true;
                    }

                    // 모든 요소를 함께 랩핑
                    const memberDiv = document.createElement('div');
                    memberDiv.className = 'form-check mb-2 d-flex';
                    memberDiv.appendChild(checkbox);
                    memberDiv.appendChild(label);
                    memberDiv.appendChild(select);
                    memberDiv.appendChild(statusSmall);
                    // 리스트에 추가
                    teamList.appendChild(memberDiv);
                }
            }

            addButton.addEventListener('click', function () {
                const memberName = input.value.trim();
                if (memberName === '') {
                    alert("아이디를 입력해주세요.");
                    return;
                }
                fetch(`/monitoring/idcheck/` + memberName, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: new URLSearchParams({id: memberName})
                })
                        .then(response => response.json())
                        .then(isAvailable => {
                            if (isAvailable) {
                                fetch('/monitoring/project/addMember', {
                                    method: 'POST',
                                    headers: {
                                        'Content-Type': 'application/json'
                                    },
                                    body: JSON.stringify({uid: memberName})
                                })
                                        .then(response => response.json())
                                        .then(isAvailable => {
                                            if (isAvailable) {
                                                getMemberList().then(() => {
                                                    reloadBaseTeam();
                                                });
                                            } else {
                                                alert("이미 참여 중인 팀원입니다.");
                                            }
                                        })
                                        .catch(error => console.error('Error:', error));

//                                }
                            } else {
                                alert("아이디가 존재하지 않습니다.");
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                        });


            });

            deleteButton.addEventListener('click', function () {
                const checkboxes = teamList.querySelectorAll('input[type="checkbox"]:checked');
                let uids = [];
                checkboxes.forEach(function (checkbox) {
                    // 가장 가까운 '.form-check' 요소를 찾습니다.
                    const memberDiv = checkbox.closest('.form-check');
                    // 해당 요소 내부의 라벨을 찾아 uid 값을 가져옵니다.
                    const label = memberDiv.querySelector('.form-check-label');
                    uid = label.textContent;
                    uids.push(uid);

                });

                if (uids.length === 0) {
                    alert("선택된 팀원이 없습니다.");
                    return;
                }

                fetch(`/monitoring/project/deleteMember`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(uids)
                })
                        .then(response => response.json())
                        .then(data => {
                            getMemberList().then(() => {
                                reloadBaseTeam();
                            });
                        })
                        .catch(error => console.error('Error:', error));
            });

            var observer = new MutationObserver(function (mutations) {
                mutations.forEach(function (mutation) {
                    if (mutation.attributeName === "class") {
                        var attributeValue = $(mutation.target).prop(mutation.attributeName);
                        if (!attributeValue.includes('show')) {
                            reloadBaseTeam();
                        }
                    }
                });
            });

            observer.observe(teamModal, {
                attributes: true
            });

            //날짜 유효성 검사
            const startDateInput = document.getElementById('start_date');
            const endDateInput = document.getElementById('end_date');

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
                var linkElement = document.querySelector('#side_details');

                //사이드바에서 요구사항 진하게 보이도록 수정
                if (linkElement) {
                    linkElement.classList.remove('img-opacity');
                }


                const dashboardMenu = document.getElementById("dashboardMenu");
                const offcanvasDashboardMenu = document.getElementById("offcanvasDashboardMenu");

                // menuContent의 내용을 offcanvasMenuContent에 가져와서 화면에 출력
                offcanvasDashboardMenu.innerHTML = dashboardMenu.innerHTML;
                //offcanvas에서 요구사항 진하게 보이도록 수정
                offcanvasDashboardMenu.classList.remove('img-opacity');
            });
        </script>
        <script src="/monitoring/js/user/search.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- 부트스트랩 script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>

</html>