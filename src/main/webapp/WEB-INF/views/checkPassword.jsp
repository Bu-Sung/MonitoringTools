<%-- 
    Document   : checkPassword
    Created on : 2023. 10. 20., 오전 5:03:37
    Author     : qntjd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
        <%@include file="/jspf/msg.jspf"%>
    </head>
    <body>
        <!-- navbar 영역 -->
        <%@include file="/jspf/topbar.jspf" %>

        <div class="container-fluid col-lg-8 col-md-10 mt-5">
            <div class="row justify-content-center">
                <!-- side bar -->
                <%@include file="/jspf/sidebar.jspf"%>
                <div class="col-lg-9 col-md-9 col-11 mb-5 mt-2">
                    <h5 class="fw-700 mb-4">회원정보 관리📌️</h5> <hr class="my-1"><hr class="m-0">
                    <div class="row justify-content-center">
                        <form method="POST" action="pwcheck" class=" col-lg-6 col-md-8 col-9">
                            <div class="align-items-center text-center">
                                <h5 class="fw-600 mt-8">비밀번호 확인</h5>
                                <small class="text-muted" style="white-space: nowrap;">회원님의 정보를 안전하게 보관하기 위해<br>비밀번호를 한 번 더 확인하고 있어요!</small>
                                <div class="d-flex mt-5 align-items-center">
                                    <input class="form-control me-3" type="password" id="checkpw" name="pw" required maxlength="30"/>
                                    <button type="submit" class="btn btn-primary fw-500" style="white-space: nowrap;">확인</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="/monitoring/js/recycleSetting.js"></script>

        <script>
            window.addEventListener('load', function () {
                var sideMainLink = document.getElementById('side_main');

                if (sideMainLink) {
                    // 현재 클래스명에서 text-dark를 찾아 text-gray로 대체
                    var classes1 = sideMainLink.className.replace('text-dark', 'text-gray');
                    sideMainLink.className = classes1;
                }

                var offcanvasMenuContent = document.getElementById('offcanvasMenuContent');
                var menuContent = document.getElementById('menuContent');

                if (offcanvasMenuContent && menuContent) {
                    // menuContent의 내용을 offcanvasMenuContent의 내용으로 설정
                    menuContent.innerHTML = offcanvasMenuContent.innerHTML;
                }
            });
        </script>
        <!-- 부트스트랩 script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
