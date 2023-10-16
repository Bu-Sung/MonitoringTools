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
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                                        <h5 class="text-primary">${rate.total eq null ? 0 : num}%</h5>
                                    </div>
                                </div>
                                <div class="row mx-auto">
                                    <div class="card card-white-1 mb-4 me-3 col-md-12 col">
                                        <div class="card-body">
                                            <p>D-Day</p>
                                            <h5 class="text-primary">D - <span>${endDay}</span></h5>
                                        </div>
                                    </div>
                                    <div class="card card-white-1 mb-4 col-md-12 col">
                                        <div class="card-body">
                                            <p>시작 전</p>
                                            <h5 class="text-primary">
                                                <sapn>${rate.standBy}</sapn> / <span>${rate.total}</span>
                                            </h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mx-auto">
                                    <div class="card card-white-1 mb-4 me-3 col-md-12 col">
                                        <div class="card-body">
                                            <p>진행 중</p>
                                            <h5 class="text-primary">
                                                <sapn>${rate.total eq null ? 0 :rate.total-rate.standBy-rate.clear}</sapn> / <span>${rate.total}</span>
                                            </h5>
                                        </div>
                                    </div>
                                    <div class="card card-white-1 mb-4 col-md-12 col">
                                        <div class="card-body">
                                            <p>완료</p>
                                            <h5 class="text-primary">
                                                <sapn>${rate.total eq null ? 0 :rate.clear}</sapn> / <span>${rate.total}</span>
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
                                        <a href="/monitoring/project/kanban" class="text-dark fw-600">스프린트<i class="bi bi-chevron-right"></i></a>
                                        <div class="mt-3" style="overflow: auto; white-space: nowrap;">
                                            <table>
                                                <tr class="text-primary">
                                                    <th>요구사항</th>
                                                    <th style="text-align: center;">진행단계</th>
                                                    <th style="text-align: center;">소요기간</th>
                                                </tr>
                                                <c:forEach items="${userSprint}" var="list">
                                                    <tr>
                                                    <td>
                                                        ${list.name}
                                                    </td>
                                              
                                                    <td style="text-align: center;">
                                                        ${list.stage}
                                                    </td>
                                         
                                                    
                                                    <td style="text-align: center;">
                                                        ${list.date}
                                                    </td>
                                                </tr>
                                                </c:forEach>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <!-- 오늘 일정 card -->
                                <div class="card card-white-1 mb-4">
                                    <div class="card-body">
                                        <a href="/monitoring/project/schedule" class="text-dark fw-600">오늘 일정<i class="bi bi-chevron-right"></i></a>
                                        <div class="mt-3">
                                            <table>
                                                <tr class="text-primary">
                                                    <th>시간</th>
                                                    <th>내용</th>
                                                </tr>
                                                <c:forEach items="${todaySchedule}" var="list">
                                                    <tr>
                                                    <td>${list.allTime eq 0 ? 'all-day' : list.start}</td>
                                                    <td>${list.title}</td>
                                                </tr>
                                                </c:forEach>
                                                
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="card card-white-1">
                                    <div class="card-body">
                                        <select id="graphSelect" class="border p-1 fw-600 mb-4">
                                            <option value="request" selected>전체 진행도</option>
                                            <option value="burndown">번다운 차트</option>
                                        </select>
                                        <!-- 종민리 그래프 -->
                                        <div id="requestDiv">

                                            <select id="requestMember" class="border p-1 fw-400 mb-2">
                                                <option value="all">전체</option>
                                            </select>
                                            <div id="requestGraph" style="width: 95%; margin: auto;">  
                                                <canvas id="request" width="500" height="400"></canvas>
                                            </div>
                                        </div>
                                        <!--번다운 차트-->
                                        <div id="burndownDiv" style="display: none;">
                                            <select id="burndownMember" class="border p-1 fw-400 mb-2">
                                                <option value="all">전체</option>
                                            </select>
                                            <div id="burndownGraph" >
                                                <canvas id="burndown" width="400" height="200"></canvas>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <script>
            document.getElementById("graphSelect").addEventListener('change', function () {
                var selectedOption = this.value;

                // 모든 그래프를 숨김

                if (selectedOption === 'request') { // 전체 진행도 선택 시
                    document.getElementById('requestDiv').style.display = 'block';
                    document.getElementById('burndownDiv').style.display = 'none';
                } else if (selectedOption === 'burndown') { // 번다운 차트 선택 시
                    document.getElementById('burndownDiv').style.display = 'block';
                    document.getElementById('requestDiv').style.display = 'none';
                }
            });

            const allData = ${allData};
            const memberData = ${memberData};
            let requestMember = 'all';
            let requestChart;

            // 드롭다운
            function createRDropdown() {
                const dropdown = document.getElementById('requestMember');
                dropdown.innerHTML = ''; // 기존 옵션을 모두 제거

                // 멤버 아이디 리스트 생성 
                const members = ['all'];
                for (let i = 0; i < memberData.length; i++) {
                    const memberId = memberData[i][1]; // 멤버 아이디
                    if (!members.includes(memberId)) {
                        members.push(memberId);  // 멤버 아이디 추가 
                    }
                }

                // 드롭다운 추가
                members.forEach((memberId) => {
                    const option = document.createElement('option');
                    option.value = memberId;
                    option.text = memberId === 'all' ? '전체' : memberId; // 전체 옵션 표시
                    dropdown.appendChild(option);
                });

                // 드롭다운 변경 시 그래프 갱신
                dropdown.addEventListener('change', () => {
                    requestMember = dropdown.value;
                    updateRequest();
                });

                // 드롭다운 초기 
                requestMember = 'all';
                updateRequest();
            }

            // 그래프 갱신
            function updateRequest() {
                document.getElementById('requestGraph').style.display = 'block';
                renderMemberData(requestMember);
            }

            // 멤버 그래프 
            function renderMemberData(memberId) {
                const memberLabels = [];
                const allLabels = [];

                const dataset1 = {
                    label: '총 요구사항 수',
                    data: [],
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 2,
                    fill: false,
                };

                const dataset2 = {
                    label: '완료 요구사항 수',
                    data: [],
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 2,
                    fill: false,
                };

                const dataset3 = {
                    label: '반복 요구사항 수',
                    data: [],
                    borderColor: 'rgba(255, 206, 86, 1)',
                    borderWidth: 2,
                    fill: false,
                };

                const dataset4 = {
                    label: '총 추정치',
                    data: [],
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 2,
                    fill: false,
                };

                const dataset5 = {
                    label: '완료 추정치',
                    data: [],
                    borderColor: 'rgba(153, 102, 255, 1)',
                    borderWidth: 2,
                    fill: false,
                };

                const dataset6 = {
                    label: '반복 추정치',
                    data: [],
                    borderColor: 'rgba(255, 159, 64, 1)',
                    borderWidth: 2,
                    fill: false,
                };

                // 멤버 그래프 데이터 설정 
                for (let i = 0; i < memberData.length; i++) {
                    if (memberData[i][1] === memberId) {
                        const labelValue1 = memberData[i][0];
                        if (!memberLabels.includes(labelValue1)) { // 중복되지 않는 라벨 값만 추가
                            memberLabels.push(labelValue1);
                        }
                        dataset1.data.push(memberData[i][2]);
                        dataset2.data.push(memberData[i][3]);
                        dataset3.data.push(memberData[i][4]);
                        dataset4.data.push(memberData[i][5]);
                        dataset5.data.push(memberData[i][6]);
                        dataset6.data.push(memberData[i][7]);
                    }
                }
                for (let i = 0; i < allData.length; i++) {
                    if (allData[i][1] === 'all') {
                        const labelValue2 = allData[i][0];
                        if (!allLabels.includes(labelValue2)) { // 중복되지 않는 라벨 값만 추가
                            allLabels.push(labelValue2);
                        }
                        dataset1.data.push(allData[i][2]);
                        dataset2.data.push(allData[i][3]);
                        dataset3.data.push(allData[i][4]);
                        dataset4.data.push(allData[i][5]);
                        dataset5.data.push(allData[i][6]);
                        dataset6.data.push(allData[i][7]);
                    }
                }


                var canvas = document.getElementById('request');
                const ctx = canvas.getContext("2d");
                if (requestChart) {
                    requestChart.destroy(); // 기존 차트 제거
                }
                requestChart = new Chart(ctx, {
                    type: 'line', // 꺾은선 그래프
                    data: {
                        labels: requestMember === 'all' ? allLabels : memberLabels,
                        datasets: [dataset1, dataset2, dataset3, dataset4, dataset5, dataset6],
                    },
                    options: {
                        responsive: true,
                        scales: {
                            y: {
                                beginAtZero: true,
                            },
                        },
                    },
                });
            }

            // 초기화 함수 호출
            createRDropdown();

            var burnData = ${burnData};
            let burndownChart;
            let burndownMember = 'all';

            // 멤버 드롭다운 생성 함수
            function createBDropdown() {
                const dropdown = document.getElementById('burndownMember');
                dropdown.innerHTML = ''; // 기존 옵션을 모두 제거

                // 멤버 아이디 리스트 생성 
                const members = ['all'];
                for (let i = 0; i < burnData.length; i++) {
                    const memberId = burnData[i][1]; // 멤버 아이디
                    if (!members.includes(memberId)) {
                        members.push(memberId);  // 멤버 아이디 추가 
                    }
                }

                // 드롭다운 추가
                members.forEach((memberId) => {
                    const option = document.createElement('option');
                    option.value = memberId;
                    option.text = memberId === 'all' ? '전체' : memberId; // 전체 옵션 표시
                    dropdown.appendChild(option);
                });

                // 드롭다운 변경 시 그래프 갱신
                dropdown.addEventListener('change', () => {
                    burndownMember = dropdown.value;
                    updateBurndown();
                });

                // 드롭다운 초기 
                burndownMember = 'all';
                updateBurndown();
            }

            // 그래프 생성 함수
            function createGraph(memberId) {
                var dates = [];
                
                // 해당 멤버 아이디에 대한 데이터 필터링
                var filteredData = burnData.filter(data => data[1] === memberId);

                // 멤버 아이디별 데이터 배열 초기화
                var memberDataMap = {};

                // 데이터 처리
                for (var j = 0; j < filteredData.length; j++) {
                    var data = filteredData[j];

                    var date = data[0];
                    var value = data[3];

                    // 날짜 배열에 날짜 추가 (중복 제거)
                    if (!dates.includes(date)) {
                        dates.push(date);
                    }

                    // 멤버 아이디별 데이터 배열 초기화
                    if (!memberDataMap[memberId]) {
                        memberDataMap[memberId] = [];
                    }

                    // 해당 날짜에 값 추가
                    memberDataMap[memberId].push(value);
                }

                var projectEndDate = ${projectDate[1]}; // 프로젝트 종료 날짜

                if (!dates.includes(projectEndDate)) {
                    dates.push(projectEndDate);
                }
                
                // 날짜 정렬
                dates.sort();

                // 실제 번다운 
                var dataset1 = {
                    label: memberId + " Remaining",
                    data: memberDataMap[memberId],
                    borderColor: 'rgba(54, 162, 235, 1)',
                    fill: false // 라인 그래프로 설정
                };

                // 이상 번다운 
                var startIndex = dates.indexOf(dates[0]);
                var endIndex = dates.indexOf(projectEndDate);
                var dataset2 = {
                    label: "Ideal Burndown",
                    data: dates.map((date, index) => {
                        if (index === startIndex) {
                            // 시작날의 값
                            return memberDataMap[memberId] && memberDataMap[memberId][0] ? memberDataMap[memberId][0] : 0;  // 값이 없는 경우 0으로 설정
                        } else if (index === endIndex) {
                            return 0;
                        } else {
                            // 시작 값에서 마지막 값까지 연결
                            var startValue = memberDataMap[memberId][0]; // 시작값
                            var endValue = 0;   // 마지막값
                            var step = (endValue - startValue) / (endIndex - startIndex);
                            return startValue + step * (index - startIndex);
                        }
                    }),

                    borderColor: 'rgba(255, 99, 132, 1)',
                    fill: false
                };

                // 그래프 데이터 생성
                const ctx = document.getElementById('burndown').getContext('2d');
                if (burndownChart) {
                    burndownChart.destroy(); // 기존 차트 제거
                }
                burndownChart = new Chart(ctx, {
                    type: 'line', // 꺾은선 그래프
                    data: {
                        labels: dates,
                        datasets: [dataset1, dataset2],
                    },
                    options: {
                        responsive: true,
                        scales: {
                            y: {
                                beginAtZero: true,
                            },
                        },
                    },
                });
            }

            // 멤버 드롭다운 변경 시 그래프 갱신
            function updateBurndown() {
                createGraph(burndownMember);
            }

            // 멤버 드롭다운 생성
            createBDropdown();


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