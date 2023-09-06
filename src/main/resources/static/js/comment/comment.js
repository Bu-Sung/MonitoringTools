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
    divElement.classList.add('d-flex', 'justify-content-between', 'm-3');
    
    divElement.id = "childCommentInput";
    let inputElement = document.createElement('INPUT');
    inputElement.type = 'text';
    inputElement.id = 'childComment';
    inputElement.placeholder = '댓글을 입력해주세요';
    inputElement.style.backgroundColor="#fff";
    inputElement.classList.add('border', 'form-control', 'me-2');
    
    let buttonElement = document.createElement('BUTTON');
    buttonElement.innerHTML = '작성';
    buttonElement.style.width = '4rem'; // width 설정
    buttonElement.classList.add('btn', 'btn-outline-secondary', 'btn-sm');
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

//    divElement.style.paddingLeft = '1rem';
//    divElement.style.paddingRight = '1rem';
//    divElement.style.paddingTop = '1rem';

    if (item.delete === 1) {
        let para = document.createElement('p');
        para.textContent = "삭제된 댓글입니다.";
        para.classList.add('px-3', 'pt-3');
        divElement.appendChild(para);
        }else {
        divElement.innerHTML = `
            <div class="d-flex justify-content-between px-3 pt-3">
                <span class="fw-600">${item.writer}</span>
                <small class="text-danger" onclick="deleteCommit(${item.cid})">삭제</small>
            </div>
            <div class="my-2 px-3">
                <p class="m-0">${item.content}</p>
                <small class="text-gray">${item.date}</small>
            </div>
            <div class="px-3">
            <button type="button" class="btn btn-sm btn-outline-secondary mt-1" style="font-size: 0.7rem;" onclick="settingComentInput(${item.cid})">답글</button>
            <hr class="mt-3 mb-0">
        </div>
        `;
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
    containerDiv.classList.add('d-flex');
    
    let arrowDiv = document.createElement('div'); // Small div (10%)
    arrowDiv.className = "arrowDiv";
    arrowDiv.classList.add( 'mt-3', 'ps-3'); // mt-1 클래스 추가
    arrowDiv.textContent = "└";
    containerDiv.appendChild(arrowDiv);
    
    commentDiv.className = "childCommentDiv";
    commentDiv.id = "child-" + id;
    commentDiv.classList.add('flex-fill');
    
    let buttons = commentDiv.querySelectorAll('button');
        buttons.forEach(button => {
            button.remove();
        });
    containerDiv.appendChild(commentDiv);
    containerDiv.style.backgroundColor = "#FAFAFA";
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
    var commentInput = document.getElementById('comment');
    var comment = commentInput.value;
    if (comment !== '') {
        saveComment(comment, 0);
        commentInput.value = '';
    }
});