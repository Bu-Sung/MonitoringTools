<!--<%-- Document : meetingSave Created on : 2023. 8. 20., 오전 3:48:33 Author : qntjd --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                        <h4 class="fw-600 text-dark mb-4">게시글 상세</h4>
                        <div class="card card-white-1 p-4">
                            <div id="meeting">
                                <div class="d-flex justify-content-between">
                                    <div class="meeing-title" style="font-size: 2rem; height: 4rem;">
                                        ${board.title}</div>
                                        <c:if
                                            test="${sessionScope.hasRight == 1 || (sessionScope.hasRight == 2 && sessionScope.user.name == meeting.writer)}">
                                        <div>
                                            <a href="update/${board.bid}"><button type="button"
                                                                                  class="btn btn-primary">수정</button></a>
                                            <a href="delete/${board.bid}"><button type="button"
                                                                                  class="btn btn-danger">삭제</button></a>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="align-items-center mb-2">
                                            <span class="fw-bold">카테고리</span>
                                            <div>${board.category}</div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="align-items-center mb-2">
                                            <span class="fw-bold">작성날짜</span>
                                            <div>${board.date}</div>
                                        </div>
                                        <div class="align-items-center">
                                            <span class="fw-bold">작성자</span>
                                            <div>${board.writer}</div>
                                        </div>
                                    </div>
                                </div>
                                <ul class='list-unstyled' id="ulfile">
                                    <c:forEach var="file" items="${board.files}">
                                        <li class="m-0" ><a href="download?filename=${file}&bid=${board.bid}">${file}</a></li>
                                        </c:forEach>
                                </ul>
                                <div id="content" class="document-content">
                                    ${board.content}
                                </div>
                            </div>
                            <button type="button" class="btn btn-sm btn-secondary" id="commentToggle">댓글 보기</button>

                        </div>
                        <div id="commentContainer" class="card card-white-1 p-4" style="display: none;">
                            <div class="card card-white-0 p-4">
                                <div class="d-flex justify-content-between">
                                    <span>작성자</span>
                                    <div>
                                        <span>날짜</span>
                                        <span>삭제</span>
                                    </div>
                                </div>
                                <hr>
                                <div>내용</div>
                                <button type="button" class="btn btn-sm btn-secondary">답글</button>
                                <div class="card card-white-1 p-4 border-gray">
                                    <div class="d-flex">
                                        <div class="flex-shrink-0">
                                            →
                                        </div>
                                        <div  class="flex-grow-1 ps-4">
                                            <div class="d-flex justify-content-between">
                                                <span>작성자</span>
                                                <div>
                                                    <span>날짜</span>
                                                    <span>삭제</span>
                                                </div>

                                            </div>
                                            <hr>
                                            <div>내용</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="commentList" class="commentList">

                            </div>
                            <input type="text" id="comment" placeholder="댓글을 입력해주세요"><button id="commentButton">작성</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script charset="UTF-8" src="${pageContext.request.contextPath}/js/comment/comment.js"></script>
    <script>
        const dashboardMenu = document.getElementById("dashboardMenu");
        const offcanvasDashboardMenu = document.getElementById("offcanvasDashboardMenu");

        // menuContent의 내용을 offcanvasMenuContent에 가져와서 화면에 출력
        offcanvasDashboardMenu.innerHTML = dashboardMenu.innerHTML;
    </script>
    <!--<script src="https://cdn.jsdelivr.net/npm/marked@4.0.3/lib/marked.min.js"></script>-->
    <!-- 부트스트랩 script -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>