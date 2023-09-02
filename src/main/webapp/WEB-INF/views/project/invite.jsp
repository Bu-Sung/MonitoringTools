<%-- 
    Document   : invite
    Created on : 2023. 9. 3., 오전 6:56:22
    Author     : parkchaebin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form method="post">
            프로젝트 아이디 : ${pid}
            프로젝트 초대한 사람 이름 : ${inviteUserName}
            프로젝트 이름 : ${pName}

            <br> 
            
            <input type="hidden" name="selectedPid" value="${pid}" />
            <button type="submit" formaction="/monitoring/project/acceptInvite">초대 수락</button>
            <button type="submit" formaction="/monitoring/project/refuseInvite">초대 거절</button>
        </form>
    </body>
</html>
