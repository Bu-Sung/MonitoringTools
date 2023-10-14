<%-- 
    Document   : findUser(아이디 찾기, 비밀번호 찾기)
    Created on : 2023. 10. 8., 오전 3:42:52
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
        <div class="mt-6 d-flex justify-content-center">
            <div class="card mb-3 col-lg-6 col-md-9 col-12">
                <div class="card-body mt-3 mx-md-4">
                    <h5 class="fw-600">아이디 찾기🔍</h5>
                    <small class="text-gray">회원 정보에 등록된 <span class="text-dark">이름</span>과 <span class="text-dark">전화번호</span>를 입력하세요.</small>
                    <form id="findIdForm" action="findId" method="POST" class="my-5 d-flex justify-content-center">
                        <div class="w-100 me-4" style="max-width: 30rem;">
                            <div class="d-flex align-items-center mb-3">
                                <b class="me-3" style="white-space: nowrap; width: 5rem;">이름</b>
                                <input type="text" name="name" class="form-control">
                            </div>
                            <div class="d-flex align-items-center">
                                <b class="me-3" style="white-space: nowrap; width: 5rem;">전화번호</b>
                                <input type="text" class="form-control" name="phone" placeholder="'-'을 제외한 숫자만 입력하세요.">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary" style="white-space: nowrap; width: 7rem;">아이디<br>찾기</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="mt-4 d-flex justify-content-center">
            <div class="card mb-3 col-lg-6 col-md-9 col-12">
                <div class="card-body mt-3 mx-md-4">
                    <h5 class="fw-600">비밀번호 찾기🔍</h5>
                    <small class="text-gray">회원 정보에 등록된 <span class="text-dark">아이디</span>, <span class="text-dark">이름</span>, <span class="text-dark">전화번호</span>를 입력하세요.</small>
                    <form id="findIdForm" action="findPw" method="POST" onsubmit="return findUser()" class="my-5 d-flex justify-content-center">
                        <div class="w-100 me-4" style="max-width: 30rem;">
                            <div class="d-flex align-items-center mb-3">
                                <b class="me-3" style="white-space: nowrap; width: 5rem;">아이디</b>
                                <input type="text" name="id" class="form-control">
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <b class="me-3" style="white-space: nowrap; width: 5rem;">이름</b>
                                <input type="text" name="name" class="form-control">
                            </div>
                            <div class="d-flex align-items-center">
                                <b class="me-3" style="white-space: nowrap; width: 5rem;">전화번호</b>
                                <input type="text" name="phone" class="form-control" placeholder="'-'을 제외한 숫자만 입력하세요.">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary" style="white-space: nowrap; width: 7rem;">비밀번호<br>찾기</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
