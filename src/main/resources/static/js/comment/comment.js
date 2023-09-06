/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


let sort = 'none'; // 댓글 위치 구분을 위한 변수
let sid = 0; // 게시물 번호 구분을 위한 변수

function loadTableData() {
    const url = `/monitoring/comment/comments?sort=` + sort + `&sid=` + sid;
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
    if (item.delete === 1) {
        let para = document.createElement('p');
        para.textContent = "삭제된 댓글입니다.";
        divElement.appendChild(para);
    } else {
        let writerPara = document.createElement('p');
        writerPara.textContent = "작성자: " + item.writer;
        divElement.appendChild(writerPara);

        let contentPara = document.createElement('p');
        contentPara.textContent = "내용: " + item.content;
        divElement.appendChild(contentPara);

        let datePara = document.createElement('p');
        datePara.textContent = "날짜: " + item.date;
        divElement.appendChild(datePara);

        let deletePara = document.createElement('p');
        deletePara.textContent = "삭제";
        deletePara.addEventListener('click', function () {
            deleteCommit(item.cid);
        });

        divElement.appendChild(deletePara);

        let replyButton = document.createElement('button');
        replyButton.textContent = '답글';
        replyButton.addEventListener('click', function (event) {
            let spiltId = event.currentTarget.parentNode.id.split("-");
            settingComentInput(spiltId[spiltId.length - 1]);
        });

        divElement.appendChild(replyButton);
    }
    return divElement;
}

function deleteCommit(id) {
    if (confirm("정말 삭제하시겠습니까??") === true) {
        let requestData = {
            cid: id
        };
        fetch('/monitoring/comment/deleteComment', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(requestData)
        })
                .then(response => response.json())
                .then(data => {
                    if (data) {
                        alert("댓글을 삭제하였습니다.");
                        loadTableData();
                    } else {
                        alert("댓글 삭제에 실패했습니다.");
                    }
                })
                .catch(error => console.error('Error:', error));
    }
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
    fetch('/monitoring/comment/addComment', {
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

document.addEventListener('DOMContentLoaded', function () { // 페이지 로드 시
    const splitUrl = window.location.href.split('/'); // url을 가져온다
    sort = splitUrl[splitUrl.length - 2]; // 댓글 분류
    sid = splitUrl[splitUrl.length - 1]; // 게시물 번호
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