<%-- 
    Document   : schedule
    Created on : 2023. 9. 3., 오후 2:55:23
    Author     : qntjd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset='utf-8' />
  <script src='${pageContext.request.contextPath}/js/schedule/index.global.js'></script>
  <script src='${pageContext.request.contextPath}/js/schedule/schedule.js'></script>
  <script src='${pageContext.request.contextPath}/js/schedule/calendar.js'></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/calender.css">
  <title>일정</title>
</head>
<body>
  <div id='calendar'></div>
  <div id="myModal" class="modal"></div>
</body>
</html>
