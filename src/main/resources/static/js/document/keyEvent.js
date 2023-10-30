
let explanation = explanationCheck();

function explanationCheck() {
    var url = window.location.href;

    if (url.includes("meeting")) {
        return `<div class="document-content-explanation">
                                            <h2>단축키 설명</h2>
                                            <div style="text-align: left;" class="mb-5">
                                                # => h1<br>
                                                ## => h2<br>
                                                ### => h3<br>
                                                - => •<br>
                                                /일정 => 일정 등록<br>
                                            </div>
                                        </div>`;
    } else {
        return `<div class="document-content-explanation">
                                            <h2>단축키 설명</h2>
                                            <div style="text-align: left;" class="mb-5">
                                                # => h1<br>
                                                ## => h2<br>
                                                ### => h3<br>
                                                - => •<br>
                                            </div>
                                        </div>`;
    }
}

/* 본문 작성할 div 생성 */
function createDiv(eventDiv) {
    var contentWrap = document.createElement("div");
    contentWrap.classList = "document-content-wrap";

    var content = document.createElement("div");
    content.setAttribute("contenteditable", "true");
    content.classList.add("document-content-div");

    content.addEventListener("focusin", function (event) {
        focusing(event.target);
    });

    content.addEventListener("blur", function (event) {
        unfocusing(event.target);
    });

    if (eventDiv.parentNode.nodeName === 'LI') {
        var newItem = document.createElement('li');
        newItem.appendChild(content);
        contentWrap.appendChild(newItem);
    } else {
        contentWrap.appendChild(content);
    }
    return contentWrap;
}

/* 본문 div 삭제 */
function deleteDiv(eventDiv) {
    contentWrap = eventDiv.parentNode;
    if (eventDiv.innerHTML === "") {
        const preDiv = contentWrap.previousElementSibling;
        const nextDiv = contentWrap.nextElementSibling;
        var name = contentWrap.querySelector('div').getAttribute('name'); // name 속성 값을 가져옵니다.
        if (name) { // 만약 name이 존재한다면
            scheduleList.splice(scheduleList.findIndex(function (item) {
                return item.msid === Number(name);
            }), 1);
        }
        contentWrap.remove();
        if (preDiv) {
            preDiv.querySelector('.document-content-div').focus();
        } else if (nextDiv) {
            nextDiv.querySelector('.document-content-div').focus();
        } else {
            document.getElementById("content").innerHTML = explanation;
        }
    } else {
        var firstDiv = contentWrap.querySelector('div:first-child');
        if (firstDiv.classList.contains('dot')) {
            var selection = window.getSelection();
            var range = selection.getRangeAt(0);
            var preCaretRange = range.cloneRange();
            preCaretRange.selectNodeContents(eventDiv);
            preCaretRange.setEnd(range.endContainer, range.endOffset);
            var position = preCaretRange.toString().length;
            if (position === 0) {
                firstDiv.remove();
            }
        }
    }
}

/* 윗쪽 화살표 : 위로 커서 이동 */
function cursorFocusUp(eventDiv) {
    const newFocusDiv = eventDiv.parentNode.previousElementSibling;
    if (newFocusDiv) {
        newFocusDiv.querySelector('.document-content-div').focus();
    }
}

/* 아래쪽 화살표 : 아래로 커서 이동 */
function cursorFocusDown(eventDiv) {
    const newFocusDiv = eventDiv.parentNode.nextElementSibling;
    if (newFocusDiv) {
        newFocusDiv.querySelector('.document-content-div').focus();
    }
}

/* focusing 되었을 때 */
function focusing(eventDiv) {
    eventDiv.setAttribute("placeholder", "여기에 텍스트를 입력하세요");
    moveCursorEnd(eventDiv);
}

/* focusing에서 벗어났을 때 */
function unfocusing(eventDiv) {
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
function insertTab(eventDiv) {
    contentWrap = eventDiv.parentNode;
    var paddingValue = parseFloat(contentWrap.style.paddingLeft);

    if (isNaN(paddingValue)) {
        paddingValue = 0;
    }

    paddingValue += 1.5;
    contentWrap.style.paddingLeft = paddingValue + 'em';
}

/* Shift + Tab 선택 시 */
function deleteTab(eventDiv) {
    contentWrap = eventDiv.parentNode;
    var paddingValue = parseFloat(contentWrap.style.paddingLeft);

    if (isNaN(paddingValue)) {
        paddingValue = 0;
    }

    paddingValue -= 1.5;
    contentWrap.style.paddingLeft = paddingValue + 'em';
}