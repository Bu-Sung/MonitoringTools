/* 원하는 MarkDown을 확인하기 위한 함수 */
function checkMD(eventDiv) {
    const fullText = eventDiv.textContent;
    const firstSpaceIndex = fullText.search(/\s/);
    const markDownKey = fullText.substr(0, firstSpaceIndex + 1).trim();
    const newText = fullText.substring(firstSpaceIndex + 1);

    if (markDownKey === '-') {
        console.log('Unordered list');
    } else if (markDownKey === '#') {
        replaceTag(eventDiv, 'h1', newText);
    } else if (markDownKey === '##') {
        replaceTag(eventDiv, 'h2', newText);
    } else if (markDownKey === '###') {
        replaceTag(eventDiv, 'h3', newText);
    } else if (markDownKey === '1.') {
        console.log('Ordered list');
    }
}

/* 태그 변경을 위한 함수 */
function replaceTag(eventDiv, tag, newText) {
    eventDiv.innerHTML = ''.trim();
    const content = document.createElement(tag);
    content.textContent = newText + "\u200B";
    eventDiv.appendChild(content);
}

