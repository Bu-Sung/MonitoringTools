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
    } else if (event.key === 'Tab'){
        event.preventDefault();
        if (!event.shiftKey) {
            insertTab(event.target);          
        }else{
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
    if (innerDiv && innerDiv.classList.contains('content-explanation')) {
        createDiv(event.currentTarget);
    }
});