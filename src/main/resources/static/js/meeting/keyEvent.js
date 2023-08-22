/*회의록 본문 관련 키 다운 이벤트 함수*/


/* 본문 작성할 div 생성 */
function createDiv(eventDiv) { 
    const content = $("<div>", {
        contenteditable: "true"
    }).addClass("meeting-content-div");

    content.on("focusin", function (event) {  // focusin시 placeholder 속성 적용
        focusing(event.target);
    });

    content.on("blur", function (event) {  // blur시 placeholder 속성 해제
       unfocusing(event.target);
    });

    if(eventDiv.classList.contains("meeting-content")){
        eventDiv.innerHTML="";
        $(eventDiv).append(content);
    }else{
        $(eventDiv).after(content);
    }
    content.focus();
}

/* 본문 div 삭제 */
function deleteDiv(eventDiv, contentDiv) {
    if(eventDiv.innerHTML===""){
        const preDiv = eventDiv.previousElementSibling;
        const nextDiv = eventDiv.nextElementSibling;
        eventDiv.remove();
        if(preDiv){
            preDiv.focus();
        }else if(contentDiv.childNodes.length === 0){
            contentDiv.innerHTML=`<div class="content-explanation">
                                                                    <h2>단축키 설명</h2>
                                                                    <div style="text-align: left;">
                                                                    # => h1<br>
                                                                    ## => h2<br>
                                                                    ### => h3<br>
                                                                    - => •<br>
                                                                    </div>
                                                                </div>`;
        }else{
            nextDiv.focus();
        }
    }
}

/* 윗쪽 화살표 : 위로 커서 이동 */
function cursorFocusUp(eventDiv) {
    const newFocusDiv = eventDiv.previousElementSibling;
    if (newFocusDiv) {
        newFocusDiv.focus();
    }
}

/* 아래쪽 화살표 : 아래로 커서 이동 */
function cursorFocusDown(eventDiv) {
    const newFocusDiv = eventDiv.nextElementSibling;
    if (newFocusDiv) {
        newFocusDiv.focus();
    }
}

/* focusing 되었을 때 */
function focusing(eventDiv){
    eventDiv.setAttribute("placeholder", "여기에 텍스트를 입력하세요");
    moveCursorEnd(eventDiv);
}

/* focusing에서 벗어났을 때 */
function unfocusing(eventDiv){
    eventDiv.removeAttribute("placeholder");
}

/* 입력 창에 입력 커서를 맨 뒤로 이동 */
function moveCursorEnd(eventDiv) {
    setTimeout(() => {
        const range = document.createRange();
        const selection = window.getSelection();
        range.selectNodeContents(eventDiv);
        range.collapse(false);
        selection.removeAllRanges();
        selection.addRange(range);
    }, 0);
}

/* Tab을 선택 시 */
function insertTab(eventDiv){
    eventDiv.classList.add("tab");
}

/* Shift + Tab 선택 시 */
function deleteTab(eventDiv){
    eventDiv.classList.remove("tab");
}