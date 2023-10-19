<%-- 
    Document   : projectSave
    Created on : 2023. 8. 10., 오전 5:29:13
    Author     : parkchaebin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>sw</title>

        <!-- 부트스트랩 CSS 링크 -->
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
        <%@include file="/jspf/topbar.jspf"%>

        <div class="container-fluid col-lg-8 col-md-10 mt-5">
            <div class="row">
                <%@include file="/jspf/sidebar.jspf"%>
                <div class="col-lg-9 col-11 mt-4 mx-auto">
                    <h5 class="card-title fw-600 mb-5">프로젝트등록
                        <span class="text-danger" style="font-size: 1rem;">(*필수입력)</span>
                    </h5>
                    <form action="addProject" method="post">
                        <table class="table table-borderless">
                            <!-- 프로젝트명 -->
                            <tr>
                                <th style="width:25%"><label for="projectname">프로젝트명<span class="text-danger">*</span></label>
                                </th>
                                <td>
                                    <input type="text" id="projectName" name="name" class="form-control" required>
                                    <small class="form-text text-muted mb-3">n자 이하로 작성해주세요.</small>
                                </td>
                            </tr>
                            <!-- 프로젝트설명 -->
                            <tr>
                                <th><label for="explanation">프로젝트<br>설명<span class="text-danger">*</span></label></th>
                                <td>
                                    <input type="text" id="explanation" name="content" class="form-control" required>
                                    <small class="form-text text-muted mb-3">n자 이하로 작성해주세요.</small>
                                </td>
                            </tr>
                            <!-- 프로젝트기간 -->
                            <tr>
                                <th><label for="date">프로젝트<br>기간</label></th>
                                <td>
                                    <div class="input-group">
                                        <input type="date" id="start_date" name="start" class="form-control">
                                        <span class="mx-3 my-auto">-</span>
                                        <input type="date" id="end_date" name="end" class="form-control">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th><label for="cycle">스프린트<br>주기</label></th>
                                <td>
                                    <input type="number" id="cycle" name="cycle" class="form-control" required>
                                    <small class="form-text text-muted mb-3">일 단위로 작성해주세요.</small>
                                </td>
                            </tr>
                            <!-- 프로젝트등록 버튼 -->
                            <tr>
                                <td colspan="2" class="text-center">
                                    <button type="submit" class="btn btn-primary fw-500 mt-5"
                                            style="width: 8rem; height: 3rem;">등록하기</button>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>
        <script src="/monitoring/js/recycleSetting.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
