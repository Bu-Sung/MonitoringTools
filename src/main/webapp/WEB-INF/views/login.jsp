<%-- 
    Document   : login
    Created on : 2023. 8. 15., 오전 7:55:43
    Author     : qntjd
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JSP Page</title>

        <!-- 부트스트랩 CSS 링크-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Google Fonts - Inter -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap"
              rel="stylesheet">

        <!-- CSS 파일 연결 -->
        <link rel="stylesheet" href="kimleepark.css">

        <script>
            <c:if test="${!empty msg}">
            alert("${msg}");
            </c:if>
        </script>
        <script>
            const urlParams = new URL(location.href).searchParams;
            if (urlParams.get('session_expired') === "true") {
                alert("로그인 세션이 만료되었습니다.");
                history.replaceState({}, document.title, window.location.pathname);
            }
        </script>
    </head>
    <body>
        <div class="d-flex justify-content-center align-items-center mt-9">
            <img src="./asset/logo.png" alt="logo" class="me-3" height="40rem;" width="auto">
            <p class="fw-600 text-primary" style="font-size: 2rem;">LOGIN</p>
        </div>

        <div class="d-flex justify-content-center mt-5">
            <div>
                <form style="width: 20rem;">
                    <input type="text" class="form-control mb-3" id="id" name="id"  placeholder="ID">
                    <input type="password" class="form-control mb-4" id="password" name="pw" placeholder="PASSWORD">
                    <button type="submit" class="col-12 btn btn-primary btn btn-block mb-4">LOGIN</button>
                </form>
            </div>
        </div>

        <div class="d-flex justify-content-center">
            <a href="#" class="px-2 text-gray">아이디 찾기</a>
            <span>|</span>
            <a href="#" class="px-2 text-gray">비밀번호 찾기</a>
            <span>|</span>
            <a href="./signUp.html" class="px-2 text-gray">회원가입</a>
        </div>

        <!-- 부트스트랩 script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>
