<%-- 
    Document   : login
    Created on : 2023. 8. 15., 오전 7:55:43
    Author     : qntjd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>로그인</h1>
    <form action="login" method="POST">
        <label for="id">아이디:</label>
        <input type="text" id="id" name="id" required>
        <br><br>
        
        <label for="password">비밀번호:</label>
        <input type="password" id="password" name="pw" required>
        <br><br>
        
        <input type="submit" value="로그인">
    </form>
    <p>아직 회원이 아니신가요? <a href="/signup">회원 가입하기</a></p>
    </body>
</html>
