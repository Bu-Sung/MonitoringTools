<%-- 
    Document   : board
    Created on : 2023. 8. 27., 오후 10:42:18
    Author     : qntjd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/document.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/comment.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <title>JSP Page</title>
        <script>
            let sort = 'none'; // 댓글 위치 구분을 위한 변수
            let sid = 0; // 게시물 번호 구분을 위한 변수

            function loadTableData() {
                const url = `${pageContext.request.contextPath}/comment/comments?sort=` + sort + `&sid=` + sid;
                fetch(url, )
                        .then(response => response.json())
                        .then(data => {
                            if (data && data.length > 0) {
                                let listElement = document.getElementById('commentList');
                                let childCommentList = []; // 대댓글 리스트
                                listElement.innerHTML = '';
                                for (let item of data) {
                                    let commentDiv = createComment(item);
                                    if (item.parent !== 0) {
                                        childCommentList.push(item);
                                    } else {
                                        let wrapperDiv = document.createElement('div'); // Wrapper div
                                        wrapperDiv.className = "wrapperCommentDiv";
                                        commentDiv.className = "commentDiv";
                                        wrapperDiv.appendChild(commentDiv);
                                        listElement.appendChild(wrapperDiv);
                                    }
                                }
                                if (childCommentList && childCommentList.length > 0) { // 대댓글이 존재 하면
                                    settingChildComment(childCommentList);
                                }
                            }
                        })
                        .catch(error => console.error('Error:', error));
            }

            function createCommentInput(id) {
                let divElement = document.createElement('div'); // 댓글 div

                divElement.id = "childCommentInput";

                let inputElement = document.createElement('INPUT');
                inputElement.type = 'text';
                inputElement.id = 'childComment';
                inputElement.placeholder = '댓글을 입력해주세요';

                let buttonElement = document.createElement('BUTTON');
                buttonElement.innerHTML = '작성';

                divElement.appendChild(inputElement);
                divElement.appendChild(buttonElement);

                buttonElement.addEventListener('click', function () { // 댓글 작성
                    var comment = document.getElementById('childComment').value;
                    if (comment !== '') {
                        saveComment(comment, id);
                    }
                });
                return divElement;
            }

            function settingComentInput(id) {
                let commentId = "comment-" + id;
                let oldElement = document.getElementById('childCommentInput');
                if (oldElement !== null) {
                    oldElement.remove();
                }
                let newElement = createCommentInput(id);
                let commentDiv = document.getElementById(commentId);

                if (commentDiv !== null) {
                    commentDiv.appendChild(newElement);
                }
            }

            function createComment(item) {

                let divElement = document.createElement('div'); // 댓글 div
                divElement.id = "comment-" + item.cid;

                let writerPara = document.createElement('p');
                writerPara.textContent = "작성자: " + item.writer;
                divElement.appendChild(writerPara);

                let contentPara = document.createElement('p');
                contentPara.textContent = "내용: " + item.content;
                divElement.appendChild(contentPara);

                let datePara = document.createElement('p');
                datePara.textContent = "날짜: " + item.date;
                divElement.appendChild(datePara);

                let replyButton = document.createElement('button');
                replyButton.textContent = '답글';

                replyButton.addEventListener('click', function (event) {
                    let spiltId = event.currentTarget.parentNode.id.split("-");
                    settingComentInput(spiltId[spiltId.length - 1]);
                });

                divElement.appendChild(replyButton);

                return divElement;
            }


            function createChildComment(commentDiv, id) {
                let containerDiv = document.createElement('div'); // Container div
                containerDiv.className = "childCommentContainerDiv";


                let arrowDiv = document.createElement('div'); // Small div (10%)
                arrowDiv.className = "arrowDiv";
                arrowDiv.textContent = "→";
                containerDiv.appendChild(arrowDiv);

                commentDiv.className = "childCommentDiv";
                commentDiv.id = "child-" + id;


                containerDiv.appendChild(commentDiv);

                return containerDiv;
            }

            function settingChildComment(childCommentList) {
                for (let item of childCommentList) {
                    let parentDiv = document.getElementById("comment-" + item.parent);
                    let commentDiv = createComment(item);
                    let childCommentDiv = createChildComment(commentDiv, parentDiv.id);
                    parentDiv.appendChild(childCommentDiv);
                }
            }

            function saveComment(comment, parentComment) {
                const requestData = {
                    content: comment,
                    parent: parentComment,
                    sort: sort,
                    sid: sid
                };
                fetch('${pageContext.request.contextPath}/comment/addComment', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(requestData)
                })
                        .then(response => response.json())
                        .then(data => {
                            if (data) {
                                loadTableData();
                            } else {
                                alert("댓글 작성에 실패 했습니다.");
                            }
                        })
                        .catch(error => console.error('Error:', error));
            }

        </script>
    </head>
    <body>
        <div id="board">
            <div class="document-title">제목: ${board.title}</div>
            <div >작성자: ${board.writer}</div>
            <div>작성 날짜: ${board.date}</div>
            <div >카테고리: ${board.category}</div>
            <c:forEach var="file" items="${board.files}">
                <a href="download?filename=${file}&mid=${board.bid}">${file}</a>
            </c:forEach>


            <div id="content" class="document-content">
                ${board.content}
            </div>
        </div>
        <c:if test="${editRight}">
            <a href="update/${board.bid}">수정하기</a>
            <a href="delete/${board.bid}">삭제</a>
        </c:if>
        <button id="commentToggle">댓글 보기</button>
        <div id="commentContainer" style="display: none;">
        <div id="commentList" class="commentList"></div>
        <input type="text" id="comment" placeholder="댓글을 입력해주세요"><button id="commentButton">작성</button>
        </div>
        <!--관련 스크립트 라이브러리-->
        <script charset="UTF-8" src="${pageContext.request.contextPath}/js/comment/comment.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () { // 페이지 로드 시
                const splitUrl = window.location.href.split('/'); // url을 가져온다
                sort = splitUrl[splitUrl.length - 2];
                sid = splitUrl[splitUrl.length - 1];
                loadTableData();
            });

            document.getElementById('commentButton').addEventListener('click', function () { // 댓글 작성
                var comment = document.getElementById('comment').value;
                if (comment !== '') {
                    saveComment(comment, 0);
                }
            });

            document.getElementById('commentToggle').addEventListener('click', function () {
                let commentList = document.getElementById('commentContainer');
                if (commentList.style.display === 'block') {
                    commentList.style.display = 'none';
                } else {
                    commentList.style.display = 'block';
                }
            });

        </script>
    </body>
</html>
