<%-- 
    Document   : update
    Created on : 2023. 8. 20., 오전 12:57:16
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
        <h1>회원정보 수정</h1>
        <form action="update/${user.getId()}" method="POST">
            <label for="id">아이디:</label>
            <input type="text" id="id" name="id" value="${user.getId()}" required disabled>
            <br><br>

            <label for="name">이름:</label>
            <input type="text" id="name" name="name" value="${user.getName()}" required>
            <br><br>

            <label for="email">이메일:</label>
            <input type="email" id="email" name="email" value="${user.getEmail()}" required>
            <br><br>

            <label for="phone">전화번호:</label>
            <input type="tel" id="phone" name="phone" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" value="${user.getPhone()}" required>
            <small>형식: 010-1234-5678</small>
            <br><br>

            <label for="birth">생년월일:</label>
            <input type="date" id="birth" name="birth" value="${user.getBirth()}" required>
            <br><br>

            <input type="submit" value="변경하기">
        </form>
    </body>
</html>
