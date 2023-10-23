

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
        <form id="registerForm" action="register" method="POST" onsubmit="return checkSignUp()">
            <div class="mt-6 d-flex justify-content-center">
                <!-- 정보 입력 영역 -->
                <div class="card mb-3 col-lg-6 col-md-9 col-12">
                    <div class="card-body mt-3 mx-md-4">
                        <h5 class="card-title fw-600 mb-5">개인정보입력<span class="text-danger"
                            style="font-size: 1rem;">(*필수입력)</span>
                        </h5>
                        <table class="table table-borderless">
                            <tr>
                                <th style="width:25%"><label for="id">아이디<span class="text-danger">*</span></label>
                                </th>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <input type="text" id="id" name="id" class="form-control me-3" required minlength="5" maxlength="20">
                                        <button type="button" class="btn btn-gray" id="checkid" style="width: 10rem;">중복확인</button>
                                    </div>
                                    <small class="form-text text-muted mb-3 p-1">아이디는 영문, 숫자를 포함하여 5자 이상 입력해주세요.</small>
                                </td>
                            </tr>

                            <tr>
                                <th><label for="pw">비밀번호<span class="text-danger">*</span></label></th>
                                <td>
                                    <input type="password" id="pw" name="pw" class="form-control" required  minlength="8" maxlength="20">
                                    <small class="form-text text-muted mb-3 p-1">비밀번호는 영문, 숫자를 포함하여 8자 이상 입력해주세요.</small>
                                </td>
                            </tr>

                            <tr>
                                <th><label for="pw2">비밀번호<br>확인<span class="text-danger">*</span></label></th>
                                <td class="position-relative">
                                    <input type="password" id="pw2" name="pw2" class="form-control" required  maxlength="20">
                                    <small id="pw-result" class=" px-1 position-absolute"></small>
                                </td>
                            </tr>

                            <tr>
                                <th><label for="name" class="mt-4">이름<span class="text-danger">*</span></label></th>
                                <td>
                                    <input type="text" id="name" name="name" class="form-control mt-4 mb-4" required maxlength="20">
                                </td>
                            </tr>

                            <tr>
                                <th><label for="phone">전화번호<span class="text-danger">*</span></label></th>
                                <td>
                                    <div class="d-flex">
                                        <select id="phone1" class="form-select ps-2" style="width: 6rem;">
                                            <option value="010" selected>010</option>
                                            <option value="011">011</option>
                                        </select>
                                        <input type="text" class="form-control mx-2" style="width: 6rem;" id="phone2" required>
                                        <input type="text" class="form-control mb-4" style="width: 6rem;" id="phone3" required>
                                    </div>
                                    <input type="text" id="phone" name="phone" hidden >
                                </td>
                            </tr>

                            <tr>
                                <th><label for="birth">생년월일<span class="text-danger">*</span></label></th>
                                <td>
                                    <div class="d-flex">
                                        <select id="year" class="form-select me-2 ps-2 mb-4" style="width: 6rem;" required>
                                            <option value="년" hidden>년</option>
                                        </select>
                                        <select id="month" class="form-select me-2 ps-2" style="width: 6rem;" required>
                                            <option value="월" hidden>월</option>
                                        </select>
                                        <select id="day" class="form-select ps-2" style="width: 6rem;" required>
                                            <option value="일" hidden>일</option>
                                        </select>
                                        <input type="text" id="birth" name="birth" hidden >
                                    </div>
                                </td>
                            </tr>

                            <!-- email type은 required가 있어야 유효성 검사를 함 -->
                            <tr>
                                <th><label for="email">이메일<span class="text-danger">*</span></label></th>
                                <td><input type="email" id="email" name="email" class="form-control mb-5" required maxlength="30"></td>
                            </tr>

                            <tr>
                                <td colspan="2" class="text-center">
                                    <button type="submit" class="btn btn-primary fw-500"
                                            style="width: 8rem; height: 3rem;">가입하기</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </form>
        <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/js/user/user.js"></script>
    </body>
</html>
