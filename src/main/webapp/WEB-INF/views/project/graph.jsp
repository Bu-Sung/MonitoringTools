<%-- 
    Document   : graph
    Created on : 2023. 9. 4., 오전 6:35:49
    Author     : parkchaebin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>그래프</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>

    <body>

        <!-- 요구사항 그래프 --> 
        <div>
            <select id="requestMember">
                <option value="all">전체</option>
            </select>
        </div>
        <div id="requestGraph" style="width: 30%; margin: auto;">  
            <canvas id="request" width="300" height="300"></canvas>
        </div>

        <script>
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
                const labels = [];

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
                        if (!labels.includes(labelValue1)) { // 중복되지 않는 라벨 값만 추가
                            labels.push(labelValue1);
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
                        if (!labels.includes(labelValue2)) { // 중복되지 않는 라벨 값만 추가
                            labels.push(labelValue2);
                        }
                        dataset1.data.push(allData[i][2]);
                        dataset2.data.push(allData[i][3]);
                        dataset3.data.push(allData[i][4]);
                        dataset4.data.push(allData[i][5]);
                        dataset5.data.push(allData[i][6]);
                        dataset6.data.push(allData[i][7]);
                    }
                }



                const ctx = document.getElementById('request').getContext('2d');
                if (requestChart) {
                    requestChart.destroy(); // 기존 차트 제거
                }
                requestChart = new Chart(ctx, {
                    type: 'line', // 꺾은선 그래프
                    data: {
                        labels: labels,
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
        </script>



        <!-- 번다운 그래프 --> 
        <div>
            <select id="burndownMember">
                <option value="all">전체</option>
            </select>
        </div>
        <div id="burndownGraph" style="width: 30%; margin: auto;">
            <canvas id="burndown" width="400" height="200"></canvas>
        </div>

        <script>
            var burnData = ${burnData};
            let burndownChart;
            let burndownMember = 'all';

            var dates = [];
            var projectStartDate = ${projectDate[0]}; // 프로젝트 시작 날짜
            var projectEndDate = ${projectDate[1]}; // 프로젝트 종료 날짜

            // 프로젝트 시작과 종료 날짜를 날짜 배열에 추가
            if (!dates.includes(projectStartDate)) {
                dates.push(projectStartDate);
            }

            if (!dates.includes(projectEndDate)) {
                dates.push(projectEndDate);
            }

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
        </script>
        
        
    </body>
</html>
