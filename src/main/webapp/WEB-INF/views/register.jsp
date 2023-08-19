<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JSP Page</title>

        <script>
            //아이디 중복 확인 함수
            function checkId() {
                const id = document.getElementById('id').value;

                if (id === '') {
                    alert("아이디를 입력해주세요.");
                    return;
                }

                fetch(`idcheck/`+id , {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: new URLSearchParams({id: id})
                })
                        .then(response => response.json())
                        .then(isAvailable => {
                            if (isAvailable) {
                                alert("사용 불가");
                            } else {
                                alert("사용 가능");
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert("아이디 중복 확인에 실패했습니다.");
                        });
            }
        </script>
    </head>
    <body>
        <h1>회원 가입</h1>
        <form action="register" method="POST">
            <label for="id">아이디:</label>
            <input type="text" id="id" name="id" required>
            <button type="button" onclick="checkId()">아이디 중복 확인</button>
            <br><br>

            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="pw" required>
            <br><br>

            <label for="name">이름:</label>
            <input type="text" id="name" name="name" required>
            <br><br>

            <label for="email">이메일:</label>
            <input type="email" id="email" name="email" required>
            <br><br>

            <label for="phone">전화번호:</label>
            <input type="tel" id="phone" name="phone" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" required>
            <small>형식: 010-1234-5678</small>
            <br><br>

            <label for="birth">생년월일:</label>
            <input type="date" id="birth" name="birth" required>
            <br><br>

            <input type="submit" value="가입하기">
        </form>
    </body>
</html>
