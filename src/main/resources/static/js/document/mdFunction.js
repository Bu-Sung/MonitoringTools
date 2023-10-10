/* 원하는 MarkDown을 확인하기 위한 함수 */
function checkMD(eventDiv) {
    const fullText = eventDiv.textContent;
    const firstSpaceIndex = fullText.search(/\s/);
    const markDownKey = fullText.substr(0, firstSpaceIndex + 1).trim();
    const newText = fullText.substring(firstSpaceIndex + 1);

    if (markDownKey === '-') {
        replaceDot(eventDiv, newText);
    } else if (markDownKey === '#') {
        replaceTag(eventDiv, 'h1', newText);
    } else if (markDownKey === '##') {
        replaceTag(eventDiv, 'h2', newText);
    } else if (markDownKey === '###') {
        replaceTag(eventDiv, 'h3', newText);
    } else if (markDownKey === '/일정') {
        var myModal = document.getElementById('openModal');
        var bsModal = new bootstrap.Modal(myModal, { keyboard: false });
        bsModal.show();
    }
}

/* 태그 변경을 위한 함수 */
function replaceTag(eventDiv, tag, newText) {
    eventDiv.classList.add(tag);
    eventDiv.textContent = newText;
}

/* 앞에 • 추가하기 */
function replaceDot(eventDiv, newText) {
    var parentDiv = eventDiv.parentNode;
    if (parentDiv.children.length <= 1) {
        const dotDiv = document.createElement("div");
        dotDiv.classList.add("dot");
        dotDiv.innerHTML = "•";
        parentDiv.insertBefore(dotDiv, parentDiv.firstChild);
        eventDiv.innerHTML = ''.trim();
        eventDiv.textContent = newText;
    }
}