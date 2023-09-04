<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>sw</title>

        <!-- 부트스트랩 CSS 링크 -->
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
    </head>

    <body>
        <!-- navbar 영역 -->
        <%@include file="/jspf/topbar.jspf" %>

        <div class="container-fluid col-lg-8 col-md-10 mt-5">
            <div class="row">
                <!-- side bar -->
                <%@include file="/jspf/sidebar.jspf"%>

                <!-- main content -->
                <div class=" col-lg-9 col-md-9 col-12">
                    <!-- 프로젝트에 초대된 경우, 동적으로 생성 -->
                    <c:forEach var="invitedProject" items="${invitedProjects}">
                        <div class="fw-500 border border-primary rounded bg-skyBlue px-4
                             d-flex flex-column flex-md-row align-items-center justify-content-between">
                            <p class="pt-1">"<span>${invitedProject.name}</span>" 프로젝트에 초대되셨습니다!<span style="font-size: 1.8rem;">📨</span>
                            </p>
                            <a href="invite.jsp/${invitedProject.pid}" class="btn btn-primary mb-md-0 mb-4" style="width: 8rem;">자세히보기</a>
                        </div>
                    </c:forEach>
                    <!-- 참여되어 있는 프로젝트 목록 -->
                    <div class="mt-5 mb-4 d-flex justify-content-between align-items-center">
                        <h5 class="fw-600 mb-0">프로젝트 목록</h5>
                        <form class="d-flex">
                            <input id="search" class="form-control me-2" type="search">
                            <button class="btn btn-primary" style="width: 5rem;">검색</button>
                        </form>
                    </div>
                    <div class="col-12 p-0 mb-3">
                        <c:forEach var="project" items="${projects}">
                            <div class="p-3 rounded border border-gray">
                                <a href="${project.pid}">
                                    <div class="d-flex justify-content-between">
                                        <!-- 프로젝트명 & 설명 -->
                                        <div>
                                            <h6 class="text-primary">${project.name}</h6>
                                            <small class="text-body">${project.content}</small>
                                        </div>
                                        <!-- 프로젝트 기간 -->
                                        <small class="text-gray">
                                            ${project.start} ~ ${project.end}
                                        </small>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>

            </div>
        </div>

        <script>
            /* 메뉴 탭 재사용을 위한 script*/
            const menuContent = document.getElementById("menuContent");
            const offcanvasMenuContent = document.getElementById("offcanvasMenuContent");

            // menuContent의 내용을 offcanvasMenuContent에 가져와서 화면에 출력
            offcanvasMenuContent.innerHTML = menuContent.innerHTML;
        </script>

        <!-- 부트스트랩 script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>