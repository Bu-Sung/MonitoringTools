<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    </head>

    <body>
        <!-- navbar 영역 -->
        <%@include file="/jspf/topbar.jspf" %>

        <div class="container-fluid col-lg-8 col-md-10 mt-5">
            <div class="row">
                <!-- side bar -->
                <%@include file="/jspf/sidebar.jspf"%>

                <div class="col-lg-9 col-11 mt-4 mx-auto">
                    <h5 class="card-title fw-600 mb-5">회원정보<span class="text-danger" style="font-size: 1rem;">(*필수입력)</span>
                    </h5>
                    <form action="update/${user.getId()}" method="POST" onsubmit="return checkSignUp()">
                        <table class="table table-borderless">
                            <!-- 아이디 -->
                            <tr>
                                <th style="width:25%"><label for="username">아이디</label></th>
                                <td>
                                    <input value="${user.id}" type="text" id="id" name="id"
                                           class="form-control text-gray mb-4" readonly>
                                </td>
                            </tr>
                            <!-- 비밀번호 -->
                            <tr>
                                <th><label for="password">비밀번호</label></th>
                                <td>
                                    <input type="password" id="pw" name="pw" class="form-control">
                                    <small class="form-text text-muted mb-3">비밀번호는 영문, 숫자를 포함하여 8자 이상 입력해주세요.</small>
                                </td>
                            </tr>
                            <!-- 비밀번호 확인 -->
                            <tr>
                                <th><label for="password">비밀번호<br>확인</label></th>
                                <td>
                                    <input type="password" id="pw2" name="pw2" class="form-control mb-4">
                                    <small id="pw-result"  style="display: none;"></small>
                                </td>
                            </tr>

                            <tr>
                                <th><label for="name">이름<span class="text-danger">*</span></label></th>
                                <td>
                                    <input value="${user.name}" type="text" id="name" name="name" class="form-control mb-4" required>
                                </td>
                            </tr>

                            <tr>
                                <th><label for="phone">전화번호<span class="text-danger">*</span></label></th>
                                <td>
                                    <div class="d-flex">
                                        <select class="form-select ps-2" style="width: 6rem;" id="phone1">
                                            <option value="010" selected>010</option>
                                            <option value="011">011</option>                 
                                        </select>
                                        <input  type="text" class="form-control mx-2" style="width: 6rem;" id="phone2" required>
                                        <input  type="text" class="form-control mb-4" style="width: 6rem;"
                                               id="phone3" required>
                                    </div>
                                    <input type="text" id="phone" name="phone" value="${user.phone}" hidden >
                                </td>
                            </tr>

                            <tr>
                                <th><label for="birthdate">생년월일<span class="text-danger">*</span></label></th>
                                <td>
                                    <div class="d-flex">
                                        <select id="year" class="form-select me-2 ps-2 mb-4" style="width: 6rem;" required>
                                            <option value="년" hidden>년</option>
                                        </select>
                                        <select id="month" class="form-select me-2 ps-2" style="width: 6rem;" required>
                                            <option value="월" hidden>월</option>
                                        </select>
                                        <select id="day"  class="form-select ps-2" style="width: 6rem;" required>
                                            <option value="일" hidden>일</option>
                                        </select>
                                        <input type="text" id="birth" name="birth" hidden value="${user.birth}" >
                                    </div>
                                </td>
                            </tr>

                            <!-- email type은 required가 있어야 유효성 검사를 함 -->
                            <tr>
                                <th><label for="email">이메일<span class="text-danger">*</span></label></th>
                                <td><input value="${user.email}" type="email" id="email" name="email" class="form-control mb-5"
                                           required>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="2" class="text-center">
                                    <button type="submit" class="btn btn-primary fw-500"
                                            style="width: 8rem; height: 3rem;">수정하기</button>
                                    <button type="submit" class="btn btn-outline-danger fw-500"
                                            style="width: 8rem; height: 3rem;">탈퇴하기</button>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>

                <script src="/monitoring/js/user/user.js"></script>
                <script src="/monitoring/js/recycleSetting.js"></script>

                <!-- 부트스트랩 script -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

                </body>

                </html>