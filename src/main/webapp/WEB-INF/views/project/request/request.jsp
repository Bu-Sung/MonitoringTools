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
        <title>요구사항 목록</title>
    </head>
    <body>
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