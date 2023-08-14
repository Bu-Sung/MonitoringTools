<%-- 
    Document   : register
    Created on : 2023. 8. 15., 오전 7:26:57
    Author     : qntjd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JSP Page</title>
    </head>
    <body>
        <body>
    <h1>회원 가입</h1>
    <form action="signup" method="POST">
        <label for="id">아이디:</label>
        <input type="text" id="id" name="id" required>
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
