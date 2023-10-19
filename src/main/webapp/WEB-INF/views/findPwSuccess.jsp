<%-- 
    Document   : findPwSuccess(비밀번호 찾기 성공 화면)
    Created on : 2023. 10. 8., 오전 5:07:38
    Author     : 이수진
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>sw</title>

        <!-- 부트스트랩 CSS 링크-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Google Fonts - Inter -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap"
              rel="stylesheet">

        <!-- CSS 파일 연결 -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/kimleepark.css">
        <script>
            function checkPwAndPw2() {
                var pw = document.getElementById("pw").value;
                var pw2 = document.getElementById("pw2").value;
                if (pw !== pw2) {
                    alert("비밀번호가 일치하지 않습니다.");
                    return false;
                } else {
                    return true;
                }
            }
        </script>
    </head>
    <body class="bg-gray">
        <!-- navbar-->
        <nav class="navbar bg-white">
            <div class="container-fluid col-lg-8 col-md-10">
                <a class="navbar-brand" href="login">
                    <div class="d-flex px-2 py-3">
                        <!-- 로고 이미지 -->
                        <img src="${pageContext.request.contextPath}/asset/logo.png" alt="Logo" class="img-fluid me-3" width="60rem" height="auto">
                        <!-- 프로젝트명 -->
                        <h5 class="fw-900 m-auto">SCRUMBLE</h5>
                    </div>
                </a>
                <a href="login" class="text-gray fw-600">로그인</a>
            </div>
        </nav>
        <div class="d-flex justify-content-center">
            <div class="card mt-8 col-lg-7 col-md-9 col-12">
                <div class="card-body mt-3 mx-4">
                    <h5 class="fw-700">✨ 비밀번호 찾기 결과 ✨</h5>
                    <small class="text-gray">비밀번호를 재설정하세요.</small>
                    <form id="chagePwForm" action="chagePw" method="POST"  onsubmit="return checkPwAndPw2()">
                        <div class="d-flex align-items-center mt-5">
                            <b class="me-3" style="white-space: nowrap; width: 9rem;">비밀번호</b>
                            <div class="w-100 position-relative">
                                <input type="password" id="pw" name="pw" class="form-control" required>
                                <small class="form-text text-muted px-1 position-absolute">영문, 숫자를 포함하여 8자 이상 입력해주세요.</small>
                            </div>
                        </div>
                        <div class="d-flex align-items-center mt-5 mb-3">
                            <b class="me-3" style="white-space: nowrap; width: 9rem;">비밀번호 확인</b>
                            <input type="password" id="pw2" name="pw2" class="form-control" required>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary mt-5 mb-3" style="white-space: nowrap; display: inline-block;">비밀번호 변경</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
