<%-- 
    Document   : list
    Created on : 2023. 8. 27., 오후 2:45:52
    Author     : qntjd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JSP Page</title>
        <script>
            function loadTableData(nowPage) {
                const categoryInput = document.getElementById("category");
                const category = categoryInput.options[categoryInput.selectedIndex].text;
                const requestData = {
                    category: category,
                    page: nowPage
                };
                fetch('boards', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(requestData)
                })
                        .then(response => response.json())
                        .then(data => {
                            let listElement = document.getElementById('list');
                            listElement.innerHTML = '';
                            for (let item of data) {
                                let row = document.createElement('tr');
                                let categoryCell = document.createElement('td');
                                categoryCell.textContent = item.category;
                                row.appendChild(categoryCell);

                                let titleCell = document.createElement('td');
                                let titleLink = document.createElement('a');
                                titleLink.href = item.bid;
                                titleLink.textContent = item.title;

                                titleCell.appendChild(titleLink);
                                row.appendChild(titleCell);

                                let writerCell = document.createElement('td');
                                writerCell.textContent = item.writer;
                                row.appendChild(writerCell);

                                let dateCell = document.createElement('td');
                                dateCell.textContent = item.date;

                                row.appendChild(dateCell);

                                listElement.appendChild(row);
                            }
                        })
                        .catch(error => console.error('Error:', error));
            }
            document.addEventListener('DOMContentLoaded', function () {
                loadTableData(1);
            });

        </script>
    </head>
    <body>
        <h1>공지사항 목록</h1>
        <a href="save">공지사항 등록하기</a>
        <select id="category" name="category" onchange="loadTableData(1)">
            <c:forEach var="category" items="${category}">
                <option>${category}</option>
            </c:forEach>
        </select>
        <table>
            <thead>
                <tr>
                    <th>카테고리</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody id="list">

            </tbody>
        </table>
        <br>
    </body>
</html>
