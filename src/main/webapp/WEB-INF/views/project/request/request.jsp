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
                    <div class="card card-white-0 mx-auto" style="height: 80vh;">
                        <div class="col-md-9 col-11 mx-auto my-5">
                            <h4 class="fw-600 text-dark">
                                <span>요구사항</span> 목록
                            </h4>
                            <a href="createExcel">엑셀 파일 생성</a> <br> <br> 
                            <a href="createDownRequestExcel">엑셀 파일 다운(폴더에 저장하지 않고 엑셀 파일 생성해서 바로 다운)</a> <br> <br> 
                            <div class="card card-white-1 mt-3" style="height: 50vh;">
                                <div class="card-body" style="overflow: auto; white-space: nowrap;">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr class="text-primary">
                                                <th>
                                                    <div class="d-flex justify-content-center align-items-center">
                                                        아이디
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
                                        <tbody id="list">
                                            <tr>
                                                <td>SRF-100</td>
                                                <td>로그인 기능</td>
                                                <td>로그인을 할 수 있다.</td>
                                                <td>
                                                    <div class="d-flex justify-content-center align-items-center">
                                                        <select id="${requestDTO.frid}-date" class="border p-1 fw-500" style="border-radius: 0.3rem; appearance: none;">
                                                            <option value="-1">-1</option>
                                                            <option value="1">1</option>
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
                                                <td>
                                                    <div class="d-flex justify-content-center align-items-center">
                                                        <select id="${requestDTO.frid}-rank" class="border p-1 fw-500" style="border-radius: 0.3rem; appearance: none;">
                                                            <option value="상">상</option>
                                                            <option value="중">중</option>
                                                            <option value="하">하</option>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="d-flex justify-content-center align-items-center">
                                                        <select id="${requestDTO.frid}-stage" class="border p-1 fw-500" style="border-radius: 0.3rem; appearance: none;">
                                                            <option value="대기" >대기</option>
                                                            <option value="분석">분석</option>
                                                            <option value="설계">설계</option>
                                                            <option value="구현">구현</option>
                                                            <option value="테스트">테스트</option>
                                                            <option value="완료">완료</option>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="d-flex justify-content-center align-items-center">
                                                        <select id="${requestDTO.frid}-target" class="border p-1 fw-500" style="border-radius: 0.3rem; appearance: none;">
                                                            <option value="true">true</option>
                                                            <option value="false">false</option>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>김부성</td>
                                                <td></td>  
                                            </tr>
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
        <!-- 부트스트랩 script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>

        </script>
        요구사항 목록 <br> 
        ${requestDTOs}

        <br> <br> <br> <br> 

        <!-- 요구사항 입력할 때 작성자 검색 --> 
        <form action="/monitoring/project/request/searchUserNames" method="get">
            <input type="text" name="username" placeholder="이름 입력" />
            <button type="submit">Search</button>
        </form>

        <br> 
        <!--         유사도 검사 결과 화면에 출력 
                <div id="results"></div>-->

        <a href="createExcel">엑셀 파일 생성</a> <br> <br> 
        <a href="createDownRequestExcel">엑셀 파일 다운(폴더에 저장하지 않고 엑셀 파일 생성해서 바로 다운)</a> <br> <br> 

        생성한 엑셀 파일 리스트 <br> 
        <c:if test="${not empty excelNames}">
            <c:forEach var="file" items="${excelNames}">
                <a href="download?filename=${file}">${file}</a>
            </c:forEach>
        </c:if>

        <script>

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

            const requestDTOs = [
            <c:forEach items="${requestDTOs}" var="requestDTO" varStatus="loop">
            {
            name: '${requestDTO.name}'
            } <c:if test="${!loop.last}">,</c:if>
            </c:forEach>
            ];

            console.log('requestDTOs:', requestDTOs);

            const resultsElement = document.getElementById('results');
            const similarList = []; // 유사한 데이터 쌍 리스트 

            // 유사도 함수 실행 및 결과 출력 
            async function checkSimilarity() {
                for (let i = 0; i < requestDTOs.length; i++) {
                    for (let j = i + 1; j < requestDTOs.length; j++) {
                        const name1 = requestDTOs[i].name;
                        const name2 = requestDTOs[j].name;

                        const {isSimilar} = await similarityAPI(name1, name2);

                        if (isSimilar) {
                            similarList.push([i, j]); // 인덱스를 기록
                        }

                        const resultMessage = isSimilar
                                ? '(' + name1 + ') (' + name2 + ') : 유사O'
                                : '(' + name1 + ') (' + name2 + ') : 유사X';

                        // 유사도 검사 결과 화면에 출력
                        //                        const resultParagraph = document.createElement('p');
                        //                        resultParagraph.textContent = resultMessage;
                        //                        resultsElement.appendChild(resultParagraph);
                    }
                }

                console.log('유사한 데이터 인덱스 쌍 :', similarList);
            }


            // 유사도 함수 실행 
            checkSimilarity();
        </script>


    </body>
</html>
