<%-- 
    Document   : request
    Created on : 2023. 8. 25., 오전 3:23:49
    Author     : parkchaebin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
                            <h4 class="fw-600 text-dark">
                                <span>요구사항</span> 목록
                            </h4>
                            <div class="card card-white-1 mt-2 mb-2 ">
                                <div class="card-body" style="overflow: auto; white-space: nowrap;">
                                    <!--md 사이즈 이상일 경우에 적용-->
                                    <div class='d-none d-lg-block'>
                                        <div>
                                            <div class="d-flex mt-4 justify-content-end">
                                                <a id="similarityTest">
                                                    <button class="btn btn-secondary" id="similarButton" data-bs-toggle="modal" data-bs-target="#similarModal">요구사항 유사도 검사</button>
                                                    <a href="createExcel" class=" mx-2">
                                                        <c:if test="${sessionScope.myInfo.hasRight != 3}">
                                                            <button id="createExcelButton" class="btn btn-primary">요구사항 파일 생성</button>
                                                        </c:if>
                                                    </a>
                                                    <a href="createDownRequestExcel"><button id="createDownRequestExcelButton" class="btn btn-primary">요구사항 파일 다운</button></a>
                                                    <button id="saveButton" class="btn btn-primary" style="display: none;" ${sessionScope.myInfo.hasRight == 3 ? 'disabled' : ''}>요구사항 저장</button>
                                            </div>
                                            <c:if test="${not empty excelNames}">
                                                <c:forEach var="file" items="${excelNames}">
                                                    <a href="download?filename=${file}">${file}</a>
                                                </c:forEach>
                                            </c:if>
                                            <hr>
                                        </div>
                                        <input id="hasRight" type="text" value="${sessionScope.hasRight}" hidden>
                                        <div style='overflow-x:auto;'>
                                            <table class="table table-hover">
                                                <thead>
                                                    <tr class="text-primary">
                                                        <th>
                                                            <div class="d-flex justify-content-center align-items-center">
                                                                구분
                                                            </div>
                                                        </th>
                                                        <th>
                                                            <div class="d-flex justify-content-center align-items-center">
                                                                요구사항
                                                            </div>
                                                        </th>
                                                        <th>
                                                            <div class="d-flex justify-content-center align-items-center">
                                                                상세설명
                                                            </div>
                                                        </th>
                                                        <th>
                                                            <div class="d-flex justify-content-center align-items-center">
                                                                추정치
                                                            </div>
                                                        </th>
                                                        <th>
                                                            <div class="d-flex justify-content-center align-items-center">
                                                                우선 순위
                                                            </div>
                                                        </th>
                                                        <th>
                                                            <div class="d-flex justify-content-center align-items-center">
                                                                개발단계
                                                            </div>
                                                        </th>
                                                        <th>
                                                            <div class="d-flex justify-content-center align-items-center">
                                                                반복대상
                                                            </div>
                                                        </th>
                                                        <th>
                                                            <div class="d-flex justify-content-center align-items-center">
                                                                담당자
                                                            </div>
                                                        </th>
                                                        <th>
                                                            <div class="d-flex justify-content-center align-items-center">
                                                                <비고>
                                                            </div>
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody id="requestListTable">

                                                </tbody>
                                            </table>
                                        </div>
                                        <c:if test="${sessionScope.myInfo.hasRight != 3}">
                                            <div class="row mx-1 my-4">
                                                <button id="addRequestNew" class="btn btn-sm btn-outline-primary btn-block "><h5>+</h5></button>
                                            </div>
                                        </c:if>
                                    </div>

                                    <!--모바일 크기 이하에만 적용-->
                                    <div class='d-block d-lg-none mt-7'>
                                        <div class='d-flex justify-content-center'>
                                            <a href="createDownRequestExcel" class="m-2">
                                                <button class="btn">
                                                    <img src="${pageContext.request.contextPath}/asset/file_down.png" width='40rem' height='auto'>
                                                    <p class="mt-3 text-dark mb-0">파일 다운받기</p>
                                                    <small class="text-gray">화면 크기가 너무 작은 경우<br>
                                                        파일을 다운받아 보는 것이 더 편해요!</small>
                                                </button>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Modal-->
        <div class="modal fade" id="openModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="w-100 d-flex justify-content-between align-items-center">
                            <h3 class="modal-title fw-600" id="modalTitle">요구사항 등록하기</h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                    </div>
                    <div class="modal-body">
                        <input id="rid" name="rid" type="text" hidden>
                        <input id="frid" name="frid" type="text" hidden>                      
                        <table class="table table-borderless">
                            <tr>
                                <th style="width:25%; vertical-align: middle;"><label for="rname">요구사항 명<span class="text-danger">*</span></label>
                                </th>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <input type="text" id="rname" name="rname" class="form-control"  autocomplete="off" required>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th style="vertical-align: middle;"><label for="content">설명</label></th>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <input type="text" id="content" name="content" class="form-control"  autocomplete="off">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th style="vertical-align: middle;"><label for="date">추정치<span class="text-danger">*</span></label></th>
                                <td>
                                    <div class="d-flex justify-content-center align-items-center">
                                        <select id="date" name="date" class="form-select" style="border-radius: 0.3rem; appearance: none;">
                                            <option value="-1">-1</option>
                                            <option value="1" selected>1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                            <option value="6">6</option>
                                            <option value="7">7</option>
                                            <option value="8">8</option>
                                            <option value="9">9</option>
                                            <option value="10">10</option>
                                            <option value="11">11</option>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th style="vertical-align: middle;"><label for="rank">우선 순위<span class="text-danger">*</span></label></th>
                                <td>
                                    <div class="d-flex justify-content-center align-items-center">
                                        <select id="rank" name="rank" class="form-select" style="border-radius: 0.3rem; appearance: none;">
                                            <option value="상">상</option>
                                            <option value="중">중</option>
                                            <option value="하">하</option>
                                        </select> 
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th style="vertical-align: middle;"><label for="stage">개발단계<span class="text-danger">*</span></label></th>
                                <td>
                                    <div class="d-flex justify-content-center align-items-center">
                                        <select id="stage" name="stage" class="form-select" style="border-radius: 0.3rem; appearance: none;">
                                            <option value="대기" >대기</option>
                                            <option value="분석">분석</option>
                                            <option value="설계">설계</option>
                                            <option value="구현">구현</option>
                                            <option value="테스트">테스트</option>
                                            <option value="완료">완료</option>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th style="vertical-align: middle;"><label for="target">반복 대상<span class="text-danger">*</span></label></th>
                                <td>
                                    <div class="d-flex justify-content-center align-items-center">
                                        <select id="target" name="target" class="form-select" style="border-radius: 0.3rem; appearance: none;">
                                            <option value="true">true</option>
                                            <option value="false" selected>false</option>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th style="vertical-align: middle;"><label for="uid">담당자<span class="text-danger">*</span></label></th>
                                <td>
                                    <div class="d-flex justify-content-center align-items-center">
                                        <div style="width:100%;">
                                            <input type="text" id="uid" name="uid" class="form-control"  autocomplete="off" readonly>
                                            <div id="searchMember" class="dropdown-menu">
                                            </div>
                                        </div>
                                </td>
                            </tr>
                            <tr>
                                <th style="vertical-align: middle;"><label for="note">비고</label></th>
                                <td>
                                    <input type="text" id="note" name="note" class="form-control"  autocomplete="off">
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="saveRequest" class="btn btn-primary fw-500"
                                style="width: 8rem; height: 3rem;" ${sessionScope.myInfo.hasRight == 3 ? 'disabled' : ''}>등록하기</button>
                        <button type="button" id="deleteRequest" class="btn btn-danger fw-500"
                                style="width: 8rem; height: 3rem;" hidden ${sessionScope.myInfo.hasRight == 3 ? 'disabled' : ''}>삭제하기</button>
                    </div>
                </div>
            </div>
        </div>

        <!--유사도 검사 모달-->
        <div class="modal fade" id="similarModal" tabindex="-1" role="dialog" aria-labelledby="similarModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="similarModalLabel">요구사항 유사도 검사 결과</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="d-flex justify-content-center">
                            <div class="spinner-border text-primary my-5" role="status" id="loadingSpinner">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                        </div>
                        <div id="modalContent"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- 부트스트랩 script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            var requestList = []; // 요구사항 리스트
            var similarList = []; // 유사한 데이터 쌍 리스트 
            const baseRequest = {
                frid: 0,
                rid: '',
                name: '',
                content: '',
                date: 1,
                rank: '하',
                stage: "대기",
                target: "false",
                uid: '',
                note: ''
            };

            function requestModal(request) {
                var myModal = new bootstrap.Modal(document.getElementById('openModal'), {});
                frid.value = request.frid;
                rid.value = request.rid;
                rname.value = request.name;
                content.value = request.content;
                date.value = request.date;
                rank.value = request.rank;
                stage.value = request.stage;
                target.value = request.target;
                uid.value = request.uid;
                note.value = request.note;
                myModal.show();
            }
            function getRequestList() {
                fetch("getRequests", {
                })
                        .then(response => response.json())
                        .then(data => {
                            data.forEach(item => {
                                requestList.push(item);
                            });
                            settingRequestList();
                        })
                        .catch((error) => console.error('Error:', error));
            }
            function saveRequest(request) {
                fetch("save", {
                    method: "POST",
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(request)
                })
                        .then(response => response.json())
                        .then(data => {
                            if (data) {
                                location.reload();
                                return true;
                            } else {
                                return false;
                            }
                        })
                        .catch((error) => console.error('Error:', error));
            }

            function settingRequestList() {
                var idx = 1;
                for (var item of requestList) {
                    var tr = document.createElement('tr');
                    tr.id = item.frid;

                    var rid = document.createElement('td');
                    var ridDiv = document.createElement('div');
                    ridDiv.innerText = idx;
                    ridDiv.className = "d-flex justify-content-center align-items-center";
                    rid.appendChild(ridDiv);
                    tr.appendChild(rid);

                    var name = document.createElement('td');
                    name.innerText = item.name;
                    tr.appendChild(name);

                    var content = document.createElement('td');
                    content.innerText = item.content;
                    tr.appendChild(content);

                    var date = document.createElement('td');
                    var dateDiv = document.createElement('div');
                    dateDiv.innerText = item.date;
                    dateDiv.className = "d-flex justify-content-center align-items-center";
                    if (item.date === -1) {
                        tr.style.backgroundColor = "#D3D3D3";
                    }
                    date.appendChild(dateDiv);
                    tr.appendChild(date);

                    var rank = document.createElement('td');
                    var rankDiv = document.createElement('div');
                    rankDiv.innerText = item.rank;
                    rankDiv.className = "d-flex justify-content-center align-items-center";
                    rank.appendChild(rankDiv)
                    tr.appendChild(rank);

                    if (item.date === -1) {
                        var stage = document.createElement('td');
                        var stageDiv = document.createElement('div');
                        stageDiv.className = "d-flex justify-content-center align-items-center";
                        stageDiv.innerText = item.stage;
                        stage.appendChild(stageDiv);
                        tr.appendChild(stage);

                        var target = document.createElement('td');
                        var targetDiv = document.createElement('div');
                        targetDiv.className = "d-flex justify-content-center align-items-center";
                        targetDiv.innerText = item.target;
                        target.appendChild(targetDiv);
                        tr.appendChild(target);
                    } else {
                        var stage = document.createElement('td');
                        var stageDiv = document.createElement('div');
                        stageDiv.className = "d-flex justify-content-center align-items-center";

                        var selectStage = document.createElement('select');
                        selectStage.name = "stage";
                        selectStage.className = "border p-1 text-center";
                        selectStage.style.borderRadius = "0.3rem";
                        selectStage.style.appearance = "none";

                        var stagesArray = ["대기", "분석", "설계", "구현", "테스트", "완료"];

                        stagesArray.forEach(function (stageOption) {
                            var option = document.createElement("option");
                            option.value = stageOption;
                            option.text = stageOption;
                            if (item.stage === stageOption) { // 현재 아이템의 상태와 일치하는 옵션 선택
                                option.selected = true;
                            }
                            selectStage.appendChild(option);
                        });

                        selectStage.addEventListener('change', function (e) {
                            e.stopPropagation();
                            var tmp = requestList.find(item => item.frid === parseInt(this.parentNode.parentNode.parentNode.id));
                            var request = {
                                frid: tmp.frid,
                                rid: tmp.rid,
                                name: tmp.name,
                                content: tmp.content,
                                date: tmp.date,
                                rank: tmp.rank,
                                stage: this.value,
                                target: tmp.target,
                                uid: tmp.uid,
                                note: tmp.note
                            };
                            if (saveRequest(request)) {
                                alert("변경에 실패했습니다.");
                            }
                        });

                        selectStage.addEventListener('focus', function (e) {
                            this.parentNode.parentNode.parentNode.classList.add('dontClick');
                        });

                        selectStage.addEventListener('blur', function (e) {
                            this.parentNode.parentNode.parentNode.classList.remove('dontClick');
                        });
                        stageDiv.appendChild(selectStage);
                        stage.appendChild(stageDiv);
                        tr.appendChild(stage);

                        var target = document.createElement('td');
                        var targetDiv = document.createElement('div');
                        targetDiv.className = "d-flex justify-content-center align-items-center";


                        var selectTarget = document.createElement('select');
                        selectTarget.className = "border p-1";
                        selectTarget.style.borderRadius = "0.3rem";
                        selectTarget.style.appearance = "none";

                        var targetArray = ["true", "false"];

                        targetArray.forEach(function (targetOption) {
                            var option = document.createElement("option");
                            option.value = targetOption;
                            option.text = targetOption;
                            if (item.target === targetOption) { // 현재 아이템의 대상과 일치하는 옵션 선택
                                option.selected = true;
                                if (item.target === "true") {
                                    tr.style.backgroundColor = "#FFFF99";
                                }
                            }
                            selectTarget.appendChild(option);
                        });

                        selectTarget.addEventListener('change', function (e) {
                            e.stopPropagation();
                            var tmp = requestList.find(item => item.frid === parseInt(this.parentNode.parentNode.parentNode.id));
                            var request = {
                                frid: tmp.frid,
                                rid: tmp.rid,
                                name: tmp.name,
                                content: tmp.content,
                                date: tmp.date,
                                rank: tmp.rank,
                                stage: tmp.stage,
                                target: this.value,
                                uid: tmp.uid,
                                note: tmp.note
                            };
                            if (saveRequest(request)) {
                                alert("변경에 실패했습니다.");
                            }
                        });

                        selectTarget.addEventListener('focus', function (e) {
                            this.parentNode.parentNode.parentNode.classList.add('dontClick');
                        });

                        selectTarget.addEventListener('blur', function (e) {
                            this.parentNode.parentNode.parentNode.classList.remove('dontClick');
                        });

                        targetDiv.appendChild(selectTarget);
                        target.appendChild(targetDiv);
                        tr.appendChild(target);
                    }

                    var username = document.createElement('td');
                    var usernameDiv = document.createElement('div');
                    usernameDiv.innerText = item.username;
                    usernameDiv.className = "d-flex justify-content-center align-items-center";
                    username.appendChild(usernameDiv);
                    tr.append(username);

                    var note = document.createElement('td');
                    note.innerText = item.note;
                    tr.appendChild(note);

                    tr.addEventListener('click', function (e) {
                        if (!this.classList.contains('dontClick') && hasRight.value !== 3) {
                            var tmp = requestList.find(item => item.frid === parseInt(this.id));
                            var request = {
                                frid: tmp.frid,
                                rid: tmp.rid,
                                name: tmp.name,
                                content: tmp.content,
                                date: tmp.date,
                                rank: tmp.rank,
                                stage: tmp.stage,
                                target: tmp.target,
                                uid: tmp.uid,
                                note: tmp.note
                            };
                            document.getElementById("deleteRequest").hidden = false;
                            requestModal(request);
                        }
                    });
                    document.getElementById("requestListTable").appendChild(tr);
                    idx++;
                }
            }

            document.addEventListener('DOMContentLoaded', function () {

                getRequestList(); // 요구사항 설정
                getAllMemberInfo(); // 멤버 인원 설정

                document.getElementById('saveRequest').addEventListener('click', function () {
                    (async () => { // 즉시 실행되는 비동기 함수 생성
                        if (rname.value === '') {
                            alert("요구사항 명을 입력해 주세요");
                            rname.focus();
                        } else if (uid.value === '') {
                            alert("담당자를 선택해 주세요");
                            uid.focus();
                        } else {
                            request = {
                                frid: parseInt(frid.value),
                                rid: requestList.length + 1,
                                name: rname.value,
                                content: content.value,
                                date: date.value,
                                rank: rank.value,
                                stage: stage.value,
                                target: target.value,
                                uid: uid.value,
                                note: note.value
                            }

                            // checkSimilarity가 끝날 때까지 기다림
                            const isSimilar = await checkSimilarity(request);

                            if (isSimilar) {
                                if (!saveRequest(request)) {
                                    alert("요구사항을 저장했습니다.");
                                } else {
                                    alert("요구사항 저장에 실패했습니다.");
                                }
                            } else {
                                let allElements = '요구사항 유사도를 확인해 주세요!\n';
                                for (let i = 0; i < similarList.length; i++) {
                                    allElements += '유사 요구사항 ' + (i + 1) + ' = ' + similarList[i][0] + ' : ' + similarList[i][1] + '\n';
                                }
                                if (confirm(allElements) == true) {
                                    if (!saveRequest(request)) {
                                        alert("요구사항을 저장했습니다.");
                                    } else {
                                        alert("요구사항 저장에 실패했습니다.");
                                    }
                                }
                            }
                        }
                    })();
                });

                document.getElementById("deleteRequest").addEventListener("click", function () {
                    if (confirm("정말 삭제하시겠습니까??") == true) {
                        fetch('/monitoring/project/request/delete?frid=' + frid.value, {})
                                .then(response => response.json())
                                .then(data => {
                                    if (data) {
                                        alert("요구사항이 삭제되었습니다.");
                                    } else {
                                        alert("요구사항삭제에 실패하였습니다.");
                                    }
                                });
                        location.reload();
                    }
                });

                document.getElementById("date").addEventListener("change", function () {
                    var stage = document.getElementById("stage");
                    var target = document.getElementById("target");
                    if (document.getElementById("date").value === "-1") {
                        stage.selectedIndex = 0;
                        target.selectedIndex = 1;
                        stage.disabled = true;
                        target.disabled = true;
                    } else {
                        stage.disabled = false;
                        target.disabled = false;
                    }
                });
            });

            const resultsElement = document.getElementById('results');



            // 요구사항 유사도 검사 함수 
            async function checkSimilarity(requestList) {
                const similarList = [];

                for (let i = 0; i < requestList.length; i++) {
                    for (let j = i + 1; j < requestList.length; j++) {
                        const requestA = requestList[i];
                        const requestB = requestList[j];

                        const {isSimilar} = await similarityAPI(requestA.name, requestB.name);

                        if (isSimilar) {
                            similarList.push([requestList[i], requestList[j]]);
                        }
                    }
                }

                return similarList;
            }

            // 서버의 API를 호출하여 유사성을 확인하는 함수
            async function similarityAPI(name1, name2) {
                const openApiURL = 'http://aiopen.etri.re.kr:8000/ParaphraseQA';
                const accessKey = '<spring:eval expression="@environment.getProperty('similarity.api.key')" />'; // API Key
                const requestObject = {
                    argument: {
                        sentence1: name1,
                        sentence2: name2,
                    },
                };

                const requestData = JSON.stringify(requestObject);

                const options = {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json; charset=UTF-8',
                        'Authorization': accessKey,
                    },
                    body: requestData,
                };

                try {
                    const response = await fetch(openApiURL, options);
                    const data = await response.json();

                    const isSimilar = data.return_object.result === 'paraphrase';

                    return {
                        isSimilar,
                        pair: isSimilar ? [name1, name2] : null, // 유사하면 쌍 추가, 아니면 null
                    };
                } catch (error) {
                    console.error('API 오류:', error);
                    return {
                        isSimilar: false,
                        pair: null,
                    };
                }
            }

            // 뷰포트의 세로 길이
            var viewportHeight = window.innerHeight || document.documentElement.clientHeight;

            document.addEventListener("DOMContentLoaded", function () {
                const addRequestButton = document.getElementById("addRequestNew");
                const newRequestTable = document.getElementById("requestListTable");
                const saveButton = document.getElementById("saveButton");
                const createExcelButton = document.getElementById("createExcelButton");
                const createDownRequestExcelButton = document.getElementById("createDownRequestExcelButton");

                // 데이터를 저장할 배열 선언
                const requestData = [];

                addRequestButton.addEventListener("click", function () {
                    const newRow = newRequestTable.insertRow(newRequestTable.rows.length);

                    // 각 열의 입력 필드 생성
                    const cell1 = newRow.insertCell(0);
                    const deleteButton = document.createElement('button');
                    deleteButton.classList.add('btn', 'btn-outline-danger', 'border-0', 'fw-900');
                    deleteButton.textContent = '-';
                    deleteButton.addEventListener('click', function () {
                        // 해당 행을 삭제
                        newRow.remove();
                    });
                    cell1.appendChild(deleteButton);

                    const cell2 = newRow.insertCell(1);
                    const textarea2 = document.createElement('textarea');
                    textarea2.classList.add('form-control', 'auto-height');
                    textarea2.setAttribute('name', 'newColumn2');
                    textarea2.addEventListener('input', function () {
                        autoAdjustHeight(this);
                    });

                    cell2.appendChild(textarea2);
                    const cell3 = newRow.insertCell(2);
                    const textarea3 = document.createElement('textarea');
                    textarea3.classList.add('form-control', 'auto-height');
                    textarea3.setAttribute('name', 'newColumn3');
                    textarea3.addEventListener('input', function () {
                        autoAdjustHeight(this);
                    });

                    cell3.appendChild(textarea3);
                    const cell4 = newRow.insertCell(3);
                    const selectBox = document.createElement('select');
                    selectBox.classList.add('form-control', 'text-center', 'p-0');
                    selectBox.setAttribute('name', 'newColumn4');

                    // Option 요소 추가
                    const option1 = document.createElement('option');
                    option1.text = '1';
                    option1.selected = true; // 이 옵션을 기본값으로 설정
                    selectBox.add(option1);
                    for (let i = -1; i <= 11; i++) {
                        const option = document.createElement('option');
                        option.text = i.toString();
                        selectBox.add(option);
                    }

                    cell4.appendChild(selectBox);
                    const cell5 = newRow.insertCell(4);
                    const selectBox2 = document.createElement('select');
                    selectBox2.classList.add('form-control', 'text-center', 'p-0');
                    selectBox2.setAttribute('name', 'newColumn5');

                    // Option 요소 추가
                    const optionTop = document.createElement('option');
                    optionTop.text = '상';
                    selectBox2.add(optionTop);
                    const optionMiddle = document.createElement('option');
                    optionMiddle.text = '중';
                    selectBox2.add(optionMiddle);
                    const optionBottom = document.createElement('option');
                    optionBottom.text = '하';
                    selectBox2.add(optionBottom);
                    cell5.appendChild(selectBox2);

                    const cell6 = newRow.insertCell(5);
                    const selectBox3 = document.createElement('select');
                    selectBox3.classList.add('form-control', 'text-center', 'p-0');
                    selectBox3.setAttribute('name', 'newColumn6');

                    // Option 요소 추가
                    const op1 = document.createElement('option');
                    op1.text = '대기';
                    selectBox3.add(op1);
                    const op2 = document.createElement('option');
                    op2.text = '분석';
                    selectBox3.add(op2);
                    const op3 = document.createElement('option');
                    op3.text = '설계';
                    selectBox3.add(op3);
                    const op4 = document.createElement('option');
                    op4.text = '구현';
                    selectBox3.add(op4);
                    const op5 = document.createElement('option');
                    op5.text = '테스트';
                    selectBox3.add(op5);
                    const op6 = document.createElement('option');
                    op6.text = '완료';
                    selectBox3.add(op6);
                    cell6.appendChild(selectBox3);

                    const cell7 = newRow.insertCell(6);
                    const selectBox4 = document.createElement('select');
                    selectBox4.classList.add('form-control', 'text-center', 'p-0');
                    selectBox4.setAttribute('name', 'newColumn7');

                    // Option 요소 추가
                    const optionFalse = document.createElement('option');
                    optionFalse.text = 'false';
                    selectBox4.add(optionFalse);
                    const optionTrue = document.createElement('option');
                    optionTrue.text = 'true';
                    selectBox4.add(optionTrue);
                    cell7.appendChild(selectBox4);

                    // cell8에 input 요소 추가
                    const cell8 = newRow.insertCell(7);
                    const input = document.createElement('input');
                    input.type = 'text';
                    input.classList.add('form-control');
                    input.setAttribute('name', 'newColumn8');
                    cell8.appendChild(input);

                    // cell9에 textarea 요소 추가
                    const cell9 = newRow.insertCell(8);
                    const textarea = document.createElement('textarea');
                    textarea.classList.add('form-control', 'auto-height');
                    textarea.setAttribute('name', 'newColumn9');
                    textarea.addEventListener('input', function () {
                        autoAdjustHeight(this);
                    });
                    cell9.appendChild(textarea);

                    // + 버튼을 클릭하면 저장 버튼을 보이게 설정
                    saveButton.style.display = "inline";
                    // 나머지 버튼 숨김
                    similarButton.style.display = 'none';
                    createExcelButton.style.display = "none";
                    createDownRequestExcelButton.style.display = "none";
                    console.log(textarea2);
                });

                saveButton.addEventListener("click", function () {
                    console.log(requestData);
                    if (saveData(requestData)) {
                        // 저장에 성공하면 저장 버튼을 다시 숨김
                        saveButton.style.display = "none";
                        // 나머지 버튼 보이게 설정
                        similarButton.style.display = 'inline';
                        createExcelButton.style.display = "inline";
                        createDownRequestExcelButton.style.display = "inline";
                    }
                });

                function saveData(requestData) {
                    console.log("저장 버튼이 클릭되었습니다.");

                    // 데이터를 검증
                    let hasEmptyCell2 = false;
                    let hasEmptyCell8 = false;

                    let listCount = requestList.length;

                    const rows = newRequestTable.rows; // 모든 행 가져오기
                    console.log(rows);
                    for (let i = 1; i < rows.length; i++) { // 첫 번째 행은 헤더이므로 1부터 시작
                        const row = rows[i];

                        const textarea2 = row.cells[1].querySelector('textarea');
                        const textarea3 = row.cells[2].querySelector('textarea');
                        const selectBox = row.cells[3].querySelector('select');
                        const selectBox2 = row.cells[4].querySelector('select');
                        const selectBox3 = row.cells[5].querySelector('select');
                        const selectBox4 = row.cells[6].querySelector('select');
                        const input = row.cells[7].querySelector('input');
                        const textarea = row.cells[8].querySelector('textarea');

                        if (textarea2 && input) {
                            if (textarea2.value.trim() === "") { //요구사항 공백인지 체크
                                hasEmptyCell2 = true;
                                requestData = [];
                            }

                            if (input.value.trim() === "") { //담당자 공백인지 체크
                                hasEmptyCell8 = true;
                                requestData = [];
                            }

                            // 각 행의 데이터를 requestData 배열에 추가
                            requestData.push({
                                rid: listCount + i,
                                name: textarea2.value,
                                content: textarea3.value,
                                date: selectBox.value,
                                rank: selectBox2.value,
                                stage: selectBox3.value,
                                target: selectBox4.value,
                                uid: input.value,
                                note: textarea.value
                            });
                        }
                    }

                    // 새로 추가하려다가 행을 다 지우고 저장 버튼을 클릭하면
                    if (requestData.length == 0) {
                        location.reload(); // 페이지 리로드
                        return false;
                    }

                    if (hasEmptyCell2 && hasEmptyCell8) {
                        alert("요구사항과 담당자는 빈 값일 수 없습니다.");
                        return false;
                    } else if (hasEmptyCell2) {
                        alert("요구사항에 빈 값은 허용되지 않습니다.");
                        return false;
                    } else if (hasEmptyCell8) {
                        alert("담당자에 빈 값은 허용되지 않습니다.");
                        return false;
                    } else {
                        console.log(requestData);
                        // 값이 모두 유효한 경우에만 데이터를 서버로 보냄
                        fetch("save-multiple", {
                            method: "POST",
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify(requestData)
                        })
                                .then(response => response.json())
                                .then(result => {
                                    if (result) {
                                        location.reload();
                                        return true;
                                    } else {
                                        return false;
                                    }
                                })
                                .catch((error) => console.error('Error:', error));
                    }
                }
            });

            function autoAdjustHeight(textarea) {
                textarea.style.height = "auto"; // 먼저 높이를 'auto'로 설정하여 기존 높이를 재설정합니다.
                textarea.style.height = (textarea.scrollHeight) - 1 + "px"; // 스크롤 높이에 따라 높이를 설정합니다.
            }


            // 화면 크기 조절 이벤트를 감지하여 textarea 높이 조절
            window.addEventListener('resize', function () {
                const textareas = document.querySelectorAll('textarea');
                textareas.forEach(function (textarea) {
                    autoAdjustHeight(textarea);
                });
            });

            // 요구사항 유사도 검사 버튼 호출 
            document.addEventListener("DOMContentLoaded", function () {
                const similarityTest = document.getElementById("similarityTest");
                const modalContent = document.getElementById("modalContent");
                const loadingSpinner = document.getElementById("loadingSpinner"); // 추가된 Spinner 엘리먼트

                // 모달이 열릴 때 내용 비우기
                $('#similarModal').on('show.bs.modal', function () {
                    modalContent.innerHTML = '';
                });

                similarityTest.addEventListener("click", function () {
                    // Spinner 표시
                    loadingSpinner.style.display = "block";

                    checkSimilarity(requestList)
                            .then(similarList => {
                                if (similarList.length === 0) {
                                    modalContent.innerHTML = '유사한 요구사항 없음';
                                    console.log('유사한 요구사항 없음');
                                } else {
                                    let result = '';
                                    for (const pair of similarList) {
                                        const requestA = pair[0];
                                        const requestB = pair[1];

                                        result += '유사한 요구사항:';

                                        // 결과를 나타내는 <ul> 생성
                                        result += '<ul>';

                                        // 요구사항 A와 B를 <li>로 나타내기
                                        result += '<li>' + requestA.name + '</li>';
                                        result += '<li>' + requestB.name + '</li>';

                                        // </ul> 닫기
                                        result += '</ul>';
                                        result += '<br>';
                                    }
                                    // 결과를 모달에 추가
                                    modalContent.innerHTML = result;
                                }

                                // Spinner 감추기
                                loadingSpinner.style.display = "none";
                            })
                            .catch(error => {
                                console.error('Error:', error);

                                // Spinner 감추기 (에러 발생 시도)
                                loadingSpinner.style.display = "none";
                            });
                });
            });


            document.addEventListener("DOMContentLoaded", function () {
                var linkElement = document.querySelector('#side_request');

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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script src="/monitoring/js/user/search.js"></script>
    </body>
</html>