var point = null;
var listCount = 0;
var scheduleList = [];
var myModal = document.getElementById('openModal');

document.addEventListener('DOMContentLoaded', function () {
    if (window.location.href.includes("meeting")) {
        document.getElementById("addSchedule").addEventListener("click", function () {
            if (validateFields(document.getElementById("scheduleTitle"))) {
                replaceSchdule();
                var bsModal = bootstrap.Modal.getInstance(myModal);
                bsModal.hide();
            }
        });

        document.getElementById("editSchedule").addEventListener("click", function () {
            if (validateFields(document.getElementById("scheduleTitle"))) {
                var name = point.getAttribute('name');
                var scheduleItem = scheduleList.find(function (item) {
                    return item.msid === Number(name);
                });
                if (scheduleItem) {
                    var allTime = 1;
                    var endDateValue = endDate.value;
                    if (startDate.type === "date" && endDate.type === "date") {
                        allTime = 0;
                        var date = new Date(endDateValue);
                        date.setDate(date.getDate() + 1);
                        var year = date.getFullYear();
                        var month = ("0" + (date.getMonth() + 1)).slice(-2); // 월은 0부터 시작하기 때문에 1을 더해줍니다.
                        var day = ("0" + date.getDate()).slice(-2);
                        endDateValue = year + '-' + month + '-' + day;
                    }
                    scheduleItem.msid = name;
                    scheduleItem.allTime = allTime;
                    scheduleItem.title = document.getElementById("scheduleTitle").value;
                    scheduleItem.content = document.getElementById("content").value;
                    scheduleItem.color = document.getElementById("colorSelect").value;
                    scheduleItem.datetype = document.getElementById("startDate").type;
                    scheduleItem.start = document.getElementById("startDate").value;
                    scheduleItem.end = endDateValue;
                    scheduleItem.memberList = memberList;
                }
                point.innerText = '';
                var small = document.createElement('small');
                small.className = 'scheduleText';
                if (document.getElementById("endDate").value === document.getElementById("startDate").value) {
                    small.textContent = document.getElementById("startDate").value;
                } else {
                    small.textContent = document.getElementById("startDate").value + ' ~ ' + document.getElementById("endDate").value;
                }
                point.appendChild(small);
                memberList = [];
                var bsModal = bootstrap.Modal.getInstance(myModal);
                bsModal.hide();
            }
        });

        var form = document.getElementById('documentForm');
        form.addEventListener('submit', function () {
            event.preventDefault(); // 기본 제출 동작 방지

            scheduleList.forEach(function (item) {
                let memberIdList = [];
                item.memberList.forEach(function (member) {
                    memberIdList.push(member.id);
                });
                item.memberList = memberIdList;
            });

            // JSON 형식으로 변환
            var scheduleListJson = JSON.stringify(scheduleList);

            // hidden input 요소를 생성하여 scheduleList 값을 추가
            var scheduleInput = document.createElement('input');
            scheduleInput.type = 'hidden';
            scheduleInput.name = 'scheduleList';
            scheduleInput.value = scheduleListJson;

            form.appendChild(scheduleInput);

            // 추가적인 작업 수행

            form.submit();  // 폼 제출
        });
    }
});

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
        if (eventDiv.previousElementSibling === null) {
            scheduleModal();
            let today = new Date();
            let todayText = today.getFullYear() + '-' + String(today.getMonth() + 1).padStart(2, '0') + '-' + String(today.getDate()).padStart(2, '0');
            document.getElementById("scheduleTitle").value = '';
            document.getElementById("startDate").type = "date";
            document.getElementById("startDate").value = todayText;
            document.getElementById("endDate").type = "date";
            document.getElementById("endDate").value = todayText;
            document.getElementById("content").value = '';
            document.getElementById("colorSelect").value = '#43aef2';
            addMember.value = '';
            document.getElementById("memberListDiv").innerHTML = '';
            memberList = [];
            document.getElementById("addSchedule").hidden = false;
            document.getElementById("editSchedule").hidden = true;
            point = eventDiv;
        }
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

function replaceSchdule() {
    const fullText = point.textContent;
    const firstSpaceIndex = fullText.search(/\s/);
    const newText = fullText.substring(firstSpaceIndex + 1);
    point.innerHTML = ''.trim();
    point.textContent = newText;
    var div = document.createElement('div');
    div.setAttribute('name', listCount);
    var small = document.createElement('small');
    small.className = 'scheduleText';
    if (document.getElementById("endDate").value === document.getElementById("startDate").value) {
        small.textContent = document.getElementById("startDate").value;
    } else {
        small.textContent = document.getElementById("startDate").value + ' ~ ' + document.getElementById("endDate").value;
    }

    div.appendChild(small);
    setScheduleClickEvent(div);
    point.insertAdjacentElement('beforebegin', div);
    var allTime = 1;
    var endDateValue = endDate.value;
    if (startDate.type === "date" && endDate.type === "date") {
        allTime = 0;
        var date = new Date(endDateValue);
        date.setDate(date.getDate() + 1);
        var year = date.getFullYear();
        var month = ("0" + (date.getMonth() + 1)).slice(-2); // 월은 0부터 시작하기 때문에 1을 더해줍니다.
        var day = ("0" + date.getDate()).slice(-2);
        endDateValue = year + '-' + month + '-' + day;
    }

    var item = {
        msid: listCount,
        sid: 0,
        allTime: allTime,
        title: document.getElementById("scheduleTitle").value,
        content: document.getElementById("content").value,
        color: document.getElementById("colorSelect").value,
        datetype: document.getElementById("startDate").type,
        start: document.getElementById("startDate").value,
        end: endDateValue,
        memberList: memberList
    };
    scheduleList.push(item);
    memberList = [];
    listCount++;
    console.log(item);
}

function setScheduleClickEvent(div) {
    div.addEventListener("click", function (event) {
        var eventDiv = null;
        if (!event.target.getAttribute('name')) {
            eventDiv = event.target.parentNode;
        } else {
            eventDiv = event.target;
        }
        scheduleModal();
        var schecduleItem = scheduleList.find(function (item) {
            return item.msid === Number(eventDiv.getAttribute('name'));
        });
        setModal(schecduleItem);
        memberList = schecduleItem.memberList;
        let memberListDiv = document.getElementById("memberListDiv");
        if (memberList.length > 0) {
            memberListDiv.innerHTML = '';
            memberList.forEach(element => {
                if (element !== '') {
                    var newDiv = createProfileCard(element.name, element.id);
                    memberListDiv.appendChild(newDiv);
                }
            });
        }
        document.getElementById("addSchedule").hidden = true;
        document.getElementById("editSchedule").hidden = false;
        point = eventDiv;
    });
}

async function setModal(item) {

    var start = toLocalISOString(item.start);
    var end = toLocalISOString(item.end);
    var dateType = "datetime-local";
    var startDateValue = start;
    var endDateValue = end;
    if (item.allTime === 0) {
        dateType = "date";
        startDateValue = changeDateTimeToDate(start);
        var tmp = new Date(end);
        endDateValue = changeDateTimeToDate(toLocalISOString(tmp.setDate(tmp.getDate() - 1)));
    }

    document.getElementById("scheduleTitle").value = item.title;
    document.getElementById("startDate").type = dateType;
    document.getElementById("startDate").value = startDateValue;
    document.getElementById("endDate").type = dateType;
    document.getElementById("endDate").value = endDateValue;
    document.getElementById("content").value = item.content;
    document.getElementById("colorSelect").value = item.color;
    addMember.value = '';
}