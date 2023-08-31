<%-- 
    Document   : manageMember
    Created on : 2023. 8. 21., 오전 12:59:10
    Author     : parkchaebin
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>멤버 관리 페이지</title>
        <script>
            <c:if test="${!empty msg}">
            alert("${msg}");
            </c:if>
        </script>
    </head>



    <body>
        
        <!-- 팀원 권한 수정 및 삭제 --> 
        <form method="post">
            <table>
                <thead>
                    <tr>
                        <th> </th>
                        <th>팀원</th>
                        <th>권한</th>
                        <th>초대 수락 상태</th>
                    </tr>
                </thead>
                <c:forEach items="${memberDetails}" var="member">
                    <tr>
                        <td>
                            <input type="checkbox" name="selectedMember" value="${member.uid}" />
                        </td>
                        <td>${member.uid}</td>
                        <td>
                            <input type="hidden" name="uids" value="${member.uid}" />
                            <input type="hidden" name="pid" value="${member.pid}" />
                            <select name="rights">
                                <option value="1" ${member.right == 1 ? 'selected' : ''}>마스터 권한</option>
                                <option value="2" ${member.right == 2 ? 'selected' : ''}>게시물 작성 및 편집 권한</option>
                                <option value="3" ${member.right == 3 ? 'selected' : ''}>보기 권한</option>
                            </select>
                        </td>
                        <td>
                            ${member.state == 0 ? '생성자' : member.state == 1 ? '미수락' : member.state == 2 ? '수락' : ''}
                        </td>
                    </tr>
                </c:forEach>
            </table>

            <button type="submit" ${editright == 1? '' : 'disabled'} formaction="/monitoring/project/updateRight/${memberDetails[0].pid}" >권한 수정</button>

            <button type="submit" ${editright == 1? '' : 'disabled'} formaction="/monitoring/project/deleteMember/${memberDetails[0].pid}" formmethod="post">팀원 삭제</button>
        </form>

        <br> <br> <br> 
        
        <!-- 팀원 추가 --> 
        <form action="/monitoring/project/addMember/${memberDetails[0].pid}" method="post">
            <input type="text" name="addUid" placeholder="아이디를 입력하세요." required />
            <select name="right">
                <option value="1" ${member.right == 1 ? 'selected' : ''}>마스터 권한</option>
                <option value="2" ${member.right == 2 ? 'selected' : 'selected'}>게시물 작성 및 편집 권한</option>
                <option value="3" ${member.right == 3 ? 'selected' : ''}>보기 권한</option>
            </select>
            <button type="submit" ${editright == 1 ? '' : 'disabled'}>팀원 추가</button> 
        </form>

        
        <form action="/monitoring/project/searchUsers" method="get">
            <input type="text" name="uid" placeholder="아이디 입력" />
            <button type="submit">Search</button>
        </form>
        
    </body>

</html>
