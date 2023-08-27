/*본문 관련 JQery 및 함수*/
const contentDiv = document.querySelector("#content");
// 본문 Div안 키를 위한 if 문
contentDiv.addEventListener("keydown", function (event) {
    if (event.key === "Enter") { // 생성하기
        if (!event.shiftKey) {
            event.preventDefault();
            createDiv(event.target);
        }
    } else if (event.key === "ArrowUp") { //  focusing 위로
        cursorFocusUp(event.target);
    } else if (event.key === "ArrowDown") { // focusing 아래로
        cursorFocusDown(event.target);
    } else if (event.key === "Backspace") { // 지우기
        deleteDiv(event.target, contentDiv);
    } else if (event.key === 'Tab') {
        event.preventDefault();
        if (!event.shiftKey) {
            insertTab(event.target);
        } else {
            deleteTab(event.target);
        }
    }
});

contentDiv.addEventListener("keyup", function (event) {
    if (event.key === ' ') {
        checkMD(event.target);
    }
});

//본문 시작
contentDiv.addEventListener("click", function (event) {
    const innerDiv = contentDiv.querySelector('div');
    if (innerDiv && innerDiv.classList.contains('document-content-explanation')) {
        createDiv(event.currentTarget);
    }
});


/* 정보 전송을 위한 스크립트 */
function saveDocument() {
    const formDiv = document.getElementById("documentForm");
    const text = document.getElementById("content");
    const content = document.createElement('input');

    content.setAttribute("type", "hidden");
    content.setAttribute("name", "content");
    content.setAttribute("value", text.innerHTML);

    formDiv.appendChild(content);
}

function updateDocument() {
    saveDocument();
    checkupdatefile();
}

let delfile = [];

function removefile(event) {
    const listItem = event.target.parentElement;
    delfile.push(listItem.getAttribute(`data-filename`));
    listItem.remove();
}

function checkupdatefile() {
    const newfile = document.getElementById('file');
    const container = document.getElementById('file-container');
    //삭제할 파일
    const delinput = document.createElement('input');
    delinput.type = 'hidden';
    delinput.name = 'dellist';
    delinput.value = delfile;
    container.appendChild(delinput);
    //남아있는 파일
    const remaininput = document.createElement('input');
    remaininput.type = 'hidden';
    remaininput.name = 'fileExist';
    remaininput.value = 0;
    if (document.getElementById("ulfile").getElementsByTagName("li") > 0 || newfile.files.length !== 0) {
        remaininput.value = 1;
    }
    container.appendChild(remaininput);
}