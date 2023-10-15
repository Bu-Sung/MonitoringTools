<%-- 
    Document   : login
    Created on : 2023. 8. 15., 오전 7:55:43
    Author     : qntjd
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

    </head>
    <body>
        <div class="d-flex justify-content-center align-items-center mt-9">
            <img src="${pageContext.request.contextPath}/asset/logo.png" alt="logo" class="me-3" height="40rem" width="auto">
            <p class="fw-600 text-primary" style="font-size: 2rem;">LOGIN</p>
        </div>

        <div class="d-flex justify-content-center mt-5">
            <div>
                <form action="login" method="POST" style="width: 20rem;">
                    <input type="text" class="form-control mb-3" id="id" name="id"  placeholder="ID">
                    <input type="password" class="form-control mb-4" id="password" name="pw" placeholder="PASSWORD">
                    <button type="submit" class="col-12 btn btn-primary btn btn-block mb-4">LOGIN</button>
                </form>
            </div>
        </div>

        <div class="d-flex justify-content-center">
            <a href="findUser" class="px-2 text-gray">회원 정보 찾기</a>
            <span>|</span>
            <a href="register" class="px-2 text-gray">회원가입</a>
        </div>

        <!-- 부트스트랩 script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>
