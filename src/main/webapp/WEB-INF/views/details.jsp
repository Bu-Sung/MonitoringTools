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
            <div class="row justify-content-center">
                <!-- side bar -->
                <%@include file="/jspf/sidebar.jspf"%>

                <div class="col-lg-9 col-md-9 col-11 mb-5 mt-2">
                    <h5 class="fw-700 mb-5">회원정보 관리📌<span class="text-danger" style="font-size: 0.8rem;">(*필수입력)</span></h5>

                    <ul class="nav nav-underline mt-4" id="myTab">
                        <li class="nav-item" role="presentation">
                            <a class="nav-link active" id="profile-tab" data-bs-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="true">프로필 수정</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="edit-password-tab" data-bs-toggle="tab" href="#edit-password" role="tab" aria-controls="edit-password" aria-selected="false">비밀번호 변경</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="delete-user-tab" data-bs-toggle="tab" href="#delete-user" role="tab" aria-controls="delete-user" aria-selected="false">회원탈퇴</a>
                        </li>
                    </ul>

                    <div class="tab-content" id="myTabContent">
                        <!--회원정보 수정 탭-->
                        <div class="tab-pane fade show active" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                            <form id="updateUserInfo" action="update/${user.getId()}" method="POST">
                                <table class="table table-borderless mt-4">
                                    <!-- 아이디 -->
                                    <tr>
                                        <th style="width:25%"><label for="username">아이디</label></th>
                                        <td>
                                            <input value="${user.id}" type="text" id="id" name="id" class="form-control text-gray mb-4" readonly>
                                        </td>
                                    </tr>

                                    <tr>
                                        <th><label for="name">이름<span class="text-danger">*</span></label></th>
                                        <td>
                                            <input value="${user.name}" type="text" id="name" name="name" class="form-control mb-4" required maxlength="30">
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
                                                <input  type="text" class="form-control mx-2 form-control" style="width: 6rem;" id="phone2" required maxlength="4">
                                                <input  type="text" class="form-control mb-4" style="width: 6rem;"
                                                        id="phone3" required maxlength="4">
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
                                        <td><input value="${user.email}" type="email" id="email" name="email" class="form-control mb-5" required maxlength="50">
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="2" class="text-center">
                                            <button type="submit" class="btn btn-primary fw-500"
                                                    style="width: 8rem; height: 3rem;">수정하기</button>
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>

                        <!--비밀번호 변경 탭-->
                        <div class="tab-pane fade" id="edit-password" role="tabpanel" aria-labelledby="edit-password-tab">
                            <form id="pwChangeForm" method="POST" action="chagePw">
                                <div class="d-flex row mt-5 mb-3 p-2">
                                    <b class="col-3" style="white-space: nowrap;">비밀번호<span class="text-danger">*</span></b>
                                    <div class="col-9">
                                        <input type="password" id="pw" name="pw" class="form-control" required maxlength="20">
                                        <small class="form-text text-muted p-1">비밀번호는 영문, 숫자를 포함하여 8자 이상 입력해주세요.</small>
                                    </div>
                                </div>
                                <div class="d-flex row p-2">
                                    <b class="col-3" style="white-space: nowrap;">비밀번호 확인<span class="text-danger">*</span></b>
                                    <div class="col-9">
                                        <input type="password" id="pw2" class="form-control" required maxlength="20">
                                        <small id="pw-result" class=" px-1 position-absolute"></small>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-center mt-5">
                                    <button id="changePwBtn" type="submit" class="btn btn-primary fw-500" style="width: 8rem; height: 3rem;">변경하기</button>
                                </div>
                            </form>
                        </div>

                        <!--회원탈퇴 탭-->
                        <div class="tab-pane fade" id="delete-user" role="tabpanel" aria-labelledby="delete-user-tab">
                            <div class="text-center">
                                <p class="mt-7 mb-5">탈퇴하기 전 신중하게 생각해주세요 💔</p>
                                <form>
                                    <button id="deleteUser" type="button" class="btn btn-danger fw-500"
                                            style="width: 8rem; height: 3rem;">탈퇴하기</button>
                                </form>
                            </div>
                        </div>
                    </div>

                </div>
                <script src="/monitoring/js/user/user.js"></script>
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
                <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/js/user/user.js"></script>
                <!-- 부트스트랩 script -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

                </body>

                </html>