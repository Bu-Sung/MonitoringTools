<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

    <head>
        <meta charset="UTF-8">
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
        <link rel="stylesheet" href="/monitoring/css/document.css">
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
                                <span>공지사항</span> 목록
                            </h4>    
                            <div class="d-flex justify-content-between align-items-center mt-5">
                                <c:if test="${sessionScope.hasRight != 3}">
                                    <a href="save"><button class="btn btn-sm btn-primary">등록하기</button></a>
                                </c:if>
                                <select id="category" class="border p-1 fw-500" style="border-radius: 0.3rem;">
                                    <c:forEach var="category" items="${category}">
                                        <option value="${category}">${category}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="card card-white-1 mt-3" style="height: 50vh;">
                                <div class="card-body">
                                    <table class="table">
                                        <thead>
                                            <tr class="text-primary">
                                                <th>카테고리</th>
                                                <th>제목</th>
                                                <th>작성자</th>
                                                <th>작성일</th>
                                            </tr>
                                        </thead>
                                        <tbody id="list">
                                            <c:forEach items="${list.getContent()}" var="list">
                                                <tr>
                                                    <th>${list.category}</th>
                                                    <th><a href="${list.bid}">${list.title}</a></th>
                                                    <th>${list.writer}</th>
                                                    <th>${list.date}</th>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <%@include file="/jspf/listNav.jspf" %>
                        </div>
                    </div>
                </div>
            </div>
            <script src="/monitoring/js/board/boardTable.js"></script>
            <!-- 부트스트랩 script -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>