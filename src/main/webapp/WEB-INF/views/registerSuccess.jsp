
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

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
                        <h5 class="fw-900 m-auto">프로젝트명</h5>
                    </div>
                </a>
                <a href="login" class="text-gray fw-600">로그인</a>
            </div>
        </nav>

    <div class="row d-flex justify-content-center">
        <div class="flex-column accordion-header col-md-10"> <!-- 수직 정렬 -->

            <!-- 회원가입 진행 설명 영역 -->
            <div class=" col-12 mb-5">
                <h5 class="text-center fw-600 mt-6 mb-4">회원가입</h5>
                <div class="d-flex justify-content-center align-items-center">
                    <div class="text-center">
                        <img src="${pageContext.request.contextPath}/asset/pencil_blue.png" width="40" height="auto">
                        <p class="text-center mt-2 fw-500 text-gray">정보입력
                        <p>
                    </div>
                    <svg class="mb-5" xmlns="http://www.w3.org/2000/svg" width="55" height="10" viewBox="0 0 93 4"
                        fill="none">
                        <path d="M2 2H91" stroke="#b5b5b5" stroke-width="3" stroke-linecap="round"
                            stroke-dasharray="6 6" />
                    </svg>
                    <div class="text-center">
                        <img src="${pageContext.request.contextPath}/asset/check_blue.png" width="40" height="auto">
                        <p class="text-center mt-2 fw-500">가입완료</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="card mb-3 col-lg-5 col-md-8 col-sm-9">
            <div class="card-body mt-3 text-center">
                <h4 class="card-title fw-600 text-primary">회원가입이 완료되었습니다!</h4>
                <p class="fw-300" style="font-size:small;">로그인하고 서비스를 이용해보세요<span>🎉</span></p>
                <a href="login" class="btn btn-outline-primary mt-4 mb-3">로그인 페이지로 이동</a>
            </div>
        </div>
    </div>

    <!-- 부트스트랩 script -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>