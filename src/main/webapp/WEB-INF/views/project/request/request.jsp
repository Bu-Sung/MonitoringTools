<%-- 
    Document   : request
    Created on : 2023. 8. 25., 오전 3:23:49
    Author     : parkchaebin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                    <div class="card card-white-0 mx-auto" style="height: 90vh;">
                        <div class="col-md-9 col-11 mx-auto my-5">
                            <h4 class="fw-600 text-dark">
                                <span>요구사항</span> 목록
                            </h4>
                            <div class="card card-white-1 mt-2 mb-2 " style="height: 75vh;">
                                <div class="card-body" style="overflow: auto; white-space: nowrap;">
                                    <div>
                                        <div class="d-flex mt-4 justify-content-end">
                                            <a href="createExcel" class="m-2"><button class="btn btn-primary">요구사항 파일 생성</button></a>
                                            <a href="createDownRequestExcel" class="m-2"><button class="btn btn-primary">요구사항 파일 다운</button></a>
                                        </div>
                                        <c:if test="${not empty excelNames}">
                                            <c:forEach var="file" items="${excelNames}">
                                                <a href="download?filename=${file}">${file}</a>
                                            </c:forEach>
                                        </c:if>
                                        <hr>
                                    </div>
                                    <input id="hasRight" type="text" value="${sessionScope.hasRight}" hidden>
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
                                    <c:if test="${sessionScope.hasRight != 3}">
                                        <div class="row">
                                            <button id="addRequest" class="btn btn-sm btn-outline-primary">+</button>
                                        </div>
                                    </c:if>
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
                                <th style="width:25%"><label for="rname">요구사항 명<span class="text-danger">*</span></label>
                                </th>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <input type="text" id="rname" name="rname" class="form-control"  autocomplete="off" required>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th><label for="content">설명</label></th>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <input type="text" id="content" name="content" class="form-control"  autocomplete="off">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th><label for="date">추정치<span class="text-danger">*</span></label></th>
                                <td>
                                    <div class="d-flex justify-content-center align-items-center">
                                        <select id="date" name="date" class="border p-1 fw-500" style="border-radius: 0.3rem; appearance: none;">
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
                                <th><label for="rank">우선 순위<span class="text-danger">*</span></label></th>
                                <td>
                                    <div class="d-flex justify-content-center align-items-center">
                                        <select id="rank" name="rank" class="border p-1 fw-500" style="border-radius: 0.3rem; appearance: none;">
                                            <option value="상">상</option>
                                            <option value="중">중</option>
                                            <option value="하">하</option>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th><label for="stage">개발단계<span class="text-danger">*</span></label></th>
                                <td>
                                    <div class="d-flex justify-content-center align-items-center">
                                        <select id="stage" name="stage" class="border p-1 fw-500" style="border-radius: 0.3rem; appearance: none;">
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
                                <th><label for="target">반복 대상<span class="text-danger">*</span></label></th>
                                <td>
                                    <div class="d-flex justify-content-center align-items-center">
                                        <select id="target" name="target" class="border p-1 fw-500" style="border-radius: 0.3rem; appearance: none;">
                                            <option value="true">true</option>
                                            <option value="false" selected>false</option>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th><label for="uid">담당자<span class="text-danger">*</span></label></th>
                                <td>
                                    <div class="d-flex justify-content-center align-items-center">
                                        <div style="position: relative; width: auto;">
                                            <input type="text" id="uid" name="uid" class="form-control"  autocomplete="off">
                                            <div id="searchMember" class="dropdown-menu">
                                            </div>
                                        </div>
                                </td>
                            </tr>
                            <tr>
                                <th><label for="note">비고</label></th>
                                <td>
                                    <input type="text" id="note" name="note" class="form-control"  autocomplete="off">
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="saveRequest" class="btn btn-primary fw-500"
                                style="width: 8rem; height: 3rem;">등록하기</button>
                        <button type="button" id="deleteRequest" class="btn btn-danger fw-500"
                                style="width: 8rem; height: 3rem;" hidden>삭제하기</button>
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
                        selectStage.className = "border p-1 fw-500";
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
                        selectTarget.className = "border p-1 fw-500";
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

                getRequestList();// 요구사항 설정
                getAllMemberInfo(); // 멤버 인원 설정

                document.getElementById('addRequest').addEventListener('click', function () {
                    document.getElementById("deleteRequest").hidden = true;
                    requestModal(baseRequest);
                });


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


            // 유사도 함수 실행 및 결과 출력 
            async function checkSimilarity(request) {
                similarList = [];
                for (let item of requestList) {
                    const comparison = item.name;
                    const {isSimilar} = await similarityAPI(comparison, request.name);
                    if (isSimilar) {
                        similarList.push([item.name, request.name]);
                    }
                }
                if (similarList.length === 0) { // 배열이 비어있는지 확인
                    return true;
                }
                return false;
            }

            // 서버의 API를 호출하여 유사성을 확인하는 함수
            async function similarityAPI(name1, name2) {
                const openApiURL = 'http://aiopen.etri.re.kr:8000/ParaphraseQA';
                const accessKey = 'd398ab55-1d02-4d4c-b985-160d6654d72a'; // API Key

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
        </script>
        <script src="/monitoring/js/user/search.js"></script>
    </body>
</html>