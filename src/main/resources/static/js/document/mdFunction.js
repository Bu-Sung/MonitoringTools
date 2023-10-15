var point = null;
var listCount = 0;
var scheduleList = [];
var delScheduleList = [];
var myModal = document.getElementById('openModal');

document.addEventListener('DOMContentLoaded', function () {
    var divs = document.querySelectorAll('div.scheduleDiv[name]'); // class가 'scheduleDiv'이며 name 속성을 가진 모든 div 요소를 가져옵니다.

    for (var i = 0; i < divs.length; i++) { // 각각의 div에 대하여
        var nameValue = Number(divs[i].getAttribute('name')); // name 속성 값을 숫자로 변환합니다.
        if (!isNaN(nameValue)) { // 만약 nameValue가 유효한 숫자라면
            listCount = Math.max(max, nameValue); // 현재 최대값과 비교하여 더 큰 값으로 업데이트합니다.
        }
    }
    document.getElementById("addSchedule").addEventListener("click", function () {
        replaceSchdule();
        var bsModal = bootstrap.Modal.getInstance(myModal);
        bsModal.hide();
    });
    document.getElementById("editSchedule").addEventListener("click", function () {
        var name = point.getAttribute('name');
        var scheduleItem = scheduleList.find(function (item) {
            return item.listId === Number(name);
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
            scheduleItem.listId = name;
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
        if (document.getElementById("endDate").value === '') {
            small.textContent = document.getElementById("startDate").value;
        } else {
            small.textContent = document.getElementById("startDate").value + ' ~ ' + document.getElementById("endDate").value;
        }
        point.appendChild(small);
        memberList = [];
        var bsModal = bootstrap.Modal.getInstance(myModal);
        bsModal.hide();
        console.log(scheduleList);
    });
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
            var item = {
                title: '',
                content: '',
                color: '#43aef2',
                datetype: "date",
                start: '',
                end: ''
            };
            setModal(item);
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
    if (document.getElementById("endDate").value === '') {
        small.textContent = document.getElementById("startDate").value;
    } else {
        small.textContent = document.getElementById("startDate").value + ' ~ ' + document.getElementById("endDate").value;
    }

    div.appendChild(small);
    div.addEventListener("click", function (event) {
        var eventDiv = null;
        if (!event.target.getAttribute('name')) {
            eventDiv = event.target.parentNode;
        } else {
            eventDiv = event.target;
        }
        scheduleModal();
        var schecduleItem = scheduleList.find(function (item) {
            return item.listId === Number(eventDiv.getAttribute('name'));
        });
        setModal(schecduleItem);
        memberList = schecduleItem.memberList;
        if (memberList.length > 0) {
            memberListDiv.innerHTML = '';
            memberList.forEach(element => {
                var newDiv = createProfileCard(element.name, element.id);
                memberListDiv.appendChild(newDiv);
            });
        }
        document.getElementById("addSchedule").hidden = true;
        document.getElementById("editSchedule").hidden = false;
        point = eventDiv;
    });
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
        listId: listCount,
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
}

async function setModal(item) {
    document.getElementById("scheduleTitle").value = item.title;
    document.getElementById("startDate").type = item.datetype;
    document.getElementById("startDate").value = item.start;
    document.getElementById("endDate").type = item.datetype;
    document.getElementById("endDate").value = item.end;
    document.getElementById("content").value = item.content;
    document.getElementById("colorSelect").value = item.color;
    addMember.value = '';
}