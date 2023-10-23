<%-- Document : meetingSave Created on : 2023. 8. 20., 오전 3:48:33 Author : qntjd --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
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
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- Google Fonts - Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap"
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
                        <h4 class="fw-600 text-dark mb-4">게시글 수정 페이지</h4>
                        <form id="documentForm" method="POST" action="update"
                              enctype="multipart/form-data" onsubmit="updateDocument()">
                            <div class="card card-white-1 p-4">

                                <div id="meeting">
                                    <input type="text" name="bid" value="${board.bid}" hidden>
                                    <div class="align-items-center mb-4">
                                        <div>
                                            <span class="fw-bold">카테고리 : </span>
                                            <select id="category" name="category"
                                                    class="border p-2 fw-500"
                                                    style="border-radius: 0.3rem; appearance: none;">
                                                <c:forEach var="category" items="${category}">
                                                    <option value="${category}" ${board.category==category? 'select' : '' }>${category}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <input class="form-control mb-4 document-title"
                                           style="font-size: 2rem; height: 4rem;" type="text"
                                           id="title" placeholder="제목을 입력하세요"
                                           name="title" value="${board.title}" required maxlength="40">
                                    <div id="file-container">
                                        <ul id="ulfile">
                                            <c:forEach items="${board.files}" var="file">
                                                <li data-filename="${file}"><a
                                                        href="../download?filename=${file}&mid=${board.bid}">${file}</a><span
                                                        onclick="removefile(event)">&nbsp;삭제</span>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                    <input class="form-control border mb-3" id="file" type="file" name="file"
                                           multiple>
                                    <div id="content" class="document-content">
                                        ${board.content}
                                    </div>
                                </div>
                                <button class="btn btn-primary sticky-bottom mt-3" style="bottom:2rem;"
                                        type="submit">저장하기</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
                var linkElement = document.querySelector('#side_list');

                //사이드바에서 게시판 진하게 보이도록 수정
                if (linkElement) {
                    linkElement.classList.remove('img-opacity');
                }


                const dashboardMenu = document.getElementById("dashboardMenu");
                const offcanvasDashboardMenu = document.getElementById("offcanvasDashboardMenu");

                // menuContent의 내용을 offcanvasMenuContent에 가져와서 화면에 출력
                offcanvasDashboardMenu.innerHTML = dashboardMenu.innerHTML;
                //offcanvas에서 게시판 진하게 보이도록 수정
                offcanvasDashboardMenu.classList.remove('img-opacity');
            });
    </script>
    <!--<script src="https://cdn.jsdelivr.net/npm/marked@4.0.3/lib/marked.min.js"></script>-->
    <script charset="UTF-8" src="/monitoring/js/document/document.js"></script>
    <script charset="UTF-8" src="/monitoring/js/document/keyEvent.js"></script>
    <script charset="UTF-8" src="/monitoring/js/document/mdFunction.js"></script>
    <!-- 부트스트랩 script -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>