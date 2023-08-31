<%-- 
    Document   : request
    Created on : 2023. 8. 25., 오전 3:23:49
    Author     : parkchaebin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>요구사항 목록</title>
    </head>
    <body>
        ${requestDTOs}
        
        <br> <br> <br> <br> 
        
        <a href="createExcel">엑셀 파일 생성</a> <br> <br> 
        
        엑셀 파일 리스트 <br> 
        <c:if test="${not empty excelNames}">
            <c:forEach var="file" items="${excelNames}">
                <a href="download?filename=${file}">${file}</a>
            </c:forEach>
        </c:if>

    
    </body>
</html>
