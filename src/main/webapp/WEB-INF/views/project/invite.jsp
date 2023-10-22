<%-- 
    Document   : invite
    Created on : 2023. 9. 3., 오전 6:56:22
    Author     : parkchaebin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

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
    </head>

    <body>
        <!-- navbar 영역 -->
        <%@include file="/jspf/topbar.jspf" %>
        <form method="post">
            <div class="d-flex justify-content-center flex-column align-items-center text-center">
                <img src="/monitoring/asset/cow.png" class="my-5" width="200rem;">
                <h4 class="fw-600 mb-3">"<span class="text-primary">${pName}</span>" 프로젝트에 초대되셨습니다</h4>
                <p class="mb-5">이 프로젝트는 <span class="text-primary">${inviteUserName}</span>님에 의해 초대된 프로젝트입니다.<br>초대에 응하시겠습니까?</p>
                <div>
                    <button type="submit" formaction="/monitoring/project/refuseInvite/${pid}" class="btn btn-outline-primary me-2" style="width:5rem;">거절</button>
                    <button type="submit" formaction="/monitoring/project/acceptInvite/${pid}" class="btn btn-primary" style="width:5rem;">수락</button>
                </div>
            </div>
        </form>


        <!-- 부트스트랩 script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>