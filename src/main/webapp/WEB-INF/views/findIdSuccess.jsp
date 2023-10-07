<%-- 
    Document   : findIdSuccess(아이디 찾기 성공 화면)
    Created on : 2023. 10. 8., 오전 4:54:10
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
            <div class="card mt-8 col-lg-5 col-md-8 col-sm-11">
                <div class="card-body my-4 text-center mx-4">
                    <h5 class="fw-700 mb-4">✨ 아이디 찾기 결과 ✨</h5>
                    <div class="d-flex justify-content-center">아이디는&nbsp<h5 class="text-primary">아이디값 불러오기</h5>&nbsp입니다.</div>
                    <a href="login" class="btn btn-outline-primary mt-4">로그인 페이지로 이동</a>
                </div>
            </div>
        </div>
    </body>
</html>
