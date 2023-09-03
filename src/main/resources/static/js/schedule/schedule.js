var memberList = [];
function scheduleModal() {
    document.getElementById("myModal").innerHTML = '';

    var modalContent = document.createElement('div');
    modalContent.className = 'modal-content';

    var closeModalSpan = document.createElement('span');
    closeModalSpan.id = 'closeModal';
    closeModalSpan.className = 'close';
    closeModalSpan.textContent = '\u00D7';
    closeModalSpan.addEventListener('click', function () {
        document.getElementById('myModal').style.display = 'none';
    });

    modalContent.appendChild(closeModalSpan);

    var sidInput = document.createElement('input');
    sidInput.type = 'text';
    sidInput.id = 'sid';
    sidInput.hidden = true;
    modalContent.appendChild(sidInput);
    /*
     var allTimeCheckbox = document.createElement('input');
     allTimeCheckbox.type = 'checkbox';
     allTimeCheckbox.id = 'allTime';
     allTimeCheckbox.hidden = true;
     modalContent.appendChild(allTimeCheckbox);
     */
    var eventDetailsParagraph = document.createElement('p');
    eventDetailsParagraph.textContent = 'Event Details:';
    modalContent.appendChild(eventDetailsParagraph);

    // 제목
    var titleLabel = document.createElement('label');
    titleLabel.setAttribute('for', 'title');
    titleLabel.textContent = 'Title:';
    modalContent.appendChild(titleLabel);
    modalContent.appendChild(document.createElement('br'));

    var titleInput = document.createElement('input');
    titleInput.type = 'text';
    titleInput.id = 'title';
    titleInput.name = 'title'
    titleInput.readOnly = true;
    modalContent.appendChild(titleInput);
    modalContent.appendChild(document.createElement('br'));
    modalContent.appendChild(document.createElement('br'));



    // 시작 날짜 설정
    var startDateLabel = document.createElement('label');
    startDateLabel.htmlFor = 'startDate';
    startDateLabel.textContent = 'Start Date:';
    modalContent.appendChild(startDateLabel);

    var startDateInput = document.createElement('input');
    startDateInput.type = 'date';
    startDateInput.id = 'startDate';
    startDateInput.name = 'startDate';
    startDateInput.readOnly = true;
    modalContent.appendChild(startDateInput);
    modalContent.appendChild(document.createElement('br'));


    // 종료 날짜 설정
    var endDateLabel = document.createElement('label');
    endDateLabel.htmlFor = 'endDate';
    endDateLabel.textContent = 'End Date:';
    modalContent.appendChild(endDateLabel);

    var endDateInput = document.createElement('input');
    endDateInput.type = 'date';
    endDateInput.id = 'endDate';
    endDateInput.name = 'endDatchangeTypeBtne';
    endDateInput.readOnly = true;
    modalContent.appendChild(endDateInput);
    modalContent.appendChild(document.createElement('br'));
    modalContent.appendChild(document.createElement('br'));

    // 시간 설정 버튼
    var changeTypeBtn = document.createElement('button');
    changeTypeBtn.id = 'changeTypeBtn';
    changeTypeBtn.hidden = true;
    changeTypeBtn.textContent = '시간 사용';
    changeTypeBtn.addEventListener("click", function () {
        if (startDateInput.type === "date") {
            var baseStart = startDate.value;
            var baseEnd = endDate.value;
            startDate.type = "datetime-local";
            endDate.type = "datetime-local";
            startDate.value = changeDateToDateTime(baseStart);
            endDate.value = changeDateToDateTime(baseEnd);
        } else if (startDateInput.type === "datetime-local") {
            var baseStart = startDate.value;
            var baseEnd = endDate.value;
            startDate.type = "date";
            endDate.type = "date";
            startDate.value = changeDateTimeToDate(baseStart);
            endDate.value = changeDateTimeToDate(baseEnd);
        }
    });

    modalContent.appendChild(changeTypeBtn);
    modalContent.appendChild(document.createElement('br'));
    modalContent.appendChild(document.createElement('br'));

    // 내용
    var contentLabel = document.createElement('label');
    contentLabel.setAttribute('for', 'content');
    contentLabel.textContent = 'Content:';
    modalContent.appendChild(contentLabel);
    modalContent.appendChild(document.createElement('br'));

    var contentTextarea = document.createElement('textarea');
    contentTextarea.id = 'content';
    contentTextarea.name = 'content';
    contentTextarea.readOnly = true;
    modalContent.appendChild(contentTextarea);
    modalContent.appendChild(document.createElement('br'));
    modalContent.appendChild(document.createElement('br'));

    // 색설정
    var colorSelect = document.createElement('select');
    colorSelect.id = 'colorSelect';
    colorSelect.hidden = true;
    colorSelect.style.backgroundColor = '#43aef2';
    colorSelect.style.WebkitAppearance = 'none';
    colorSelect.style.MozAppearance = 'none';
    colorSelect.style.appearance = 'none';

    const colorArea = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
    var option1 = document.createElement('option');
    option1.value = '#43aef2';
    option1.style.backgroundColor = '#43aef2';
    option1.innerHTML = colorArea;
    option1.style.margin = '1px';
    colorSelect.appendChild(option1);

    var option2 = document.createElement('option');
    option2.value = '#84e45c';
    option2.style.backgroundColor = '#84e45c';
    option2.innerHTML = colorArea;
    colorSelect.appendChild(option2);

    var option3 = document.createElement('option');
    option3.value = '#f24d43';
    option3.style.backgroundColor = '#f24d43';
    option3.innerHTML = colorArea;
    colorSelect.appendChild(option3);

    colorSelect.addEventListener('change', function () {
        colorSelect.style.backgroundColor = colorSelect.value;
    });

    modalContent.appendChild(colorSelect);

    // 팀원 추가
    var addMemberDiv = document.createElement('div');
    addMemberDiv.id = 'addMemberDiv';
    var contentLabel = document.createElement('label');
    contentLabel.setAttribute('for', 'addMember');
    contentLabel.textContent = 'addMember';
    addMemberDiv.appendChild(contentLabel);
    addMemberDiv.appendChild(document.createElement('br'));

    var addMemberInput = document.createElement('input');
    addMemberInput.type = 'text';
    addMemberInput.id = 'addMember';
    addMemberDiv.appendChild(addMemberInput);

    // 멤버 추가 버튼
    var addMemberBtn = document.createElement('button');
    addMemberBtn.id = 'addMemberBtn';
    addMemberBtn.textContent = '추가하기';
    addMemberDiv.appendChild(addMemberBtn);

    addMemberBtn.addEventListener('click', function () {
        if (addMemberInput.value !== '') { // 입력 필드가 비어있지 않은 경우에만 추가
            memberList.push(addMemberInput.value);
            addMemberInput.value = ''; // 입력 필드를 비움
            memberListDiv.innerHTML = '';
            memberList.forEach(element => {
                var newP = document.createElement('p');
                newP.textContent = element;
                memberListDiv.appendChild(newP);
            });
        }

        console.log(memberList); // 콘솔에 현재 배열 상태 출력
    });
    addMemberDiv.hidden = true;
    modalContent.appendChild(addMemberDiv);
    // 멤버 리스트
    var memberListDiv = document.createElement('div');
    memberListDiv.id = 'memberListDiv';
    modalContent.appendChild(memberListDiv);

    // 일정 추가 버튼
    var saveScheduleButton = document.createElement('button');
    saveScheduleButton.type = 'submit';
    saveScheduleButton.id = 'saveSchedule';
    saveScheduleButton.hidden = true;
    saveScheduleButton.textContent = 'save';
    saveScheduleButton.addEventListener("click", function () {
        var allTime = 1;
        var endDateValue = endDate.value;
        if (startDate.type == "date" && endDate.type == "date") {
            if (startDate.value === endDate.value) {
                allTime = 0;
            }
            var date = new Date(endDateValue);
            date.setDate(date.getDate() + 1);
            var year = date.getFullYear();
            var month = ("0" + (date.getMonth() + 1)).slice(-2); // 월은 0부터 시작하기 때문에 1을 더해줍니다.
            var day = ("0" + date.getDate()).slice(-2);
            endDateValue = year + '-' + month + '-' + day;
        }
        var request = {
            sid: sid.value,
            allTime: allTime,
            title: title.value,
            content: content.value,
            color: colorSelect.value,
            start: startDate.value,
            end: endDateValue,
            memberList: memberList
        };
        saveScheduleItem(request);
    });
    modalContent.appendChild(saveScheduleButton);

    // 일정 수정 취소
    var cancelScheduleButton = document.createElement('button');
    cancelScheduleButton.type = 'button';
    cancelScheduleButton.id = 'cancelEditSchedule';
    cancelScheduleButton.hidden = true;
    cancelScheduleButton.textContent = 'cancel';
    cancelScheduleButton.addEventListener("click", function () {
        if (sid.value === '') {
            document.getElementById('myModal').style.display = 'none';
        } else {
            readOnlyScheduleSetting();
        }
    });
    modalContent.appendChild(cancelScheduleButton);

    var editButton = document.createElement('a');
    editButton.id = 'editSchedule';
    editButton.textContent = '수정하기';
    editButton.addEventListener('click', function () {
        editScheduleSetting();
    });
    modalContent.appendChild(editButton);

    var deleteButton = document.createElement('a');
    deleteButton.id = 'deleteSchedule';
    deleteButton.textContent = '삭제하기';
    deleteButton.addEventListener('click', function () {
        console.log("삭제하기");
    });
    modalContent.appendChild(deleteButton);

    document.getElementById("myModal").appendChild(modalContent);
    document.getElementById('myModal').style.display = 'block';
}

function scheduleModalSetting(item) { // 일정 초기값 세팅
    sid.value = item.sid;
    title.value = item.title;
    startDate.type = item.startDateType;
    startDate.value = item.startDateValue;
    endDate.type = item.endDateType;
    endDate.value = item.endDateValue;
    content.value = item.content;
    colorSelect.style.backgroundColor = item.color;
    memberList = item.memberList;
    memberListDiv.innerHTML = '';
    memberList.forEach(element => {
        var newP = document.createElement('p');
        newP.textContent = element;
        memberListDiv.appendChild(newP);
    });
    document.getElementById('addMember');
}

function editScheduleSetting() {
    title.readOnly = false;
    changeTypeBtn.hidden = false;
    startDate.readOnly = false;
    endDate.readOnly = false;
    content.readOnly = false;
    colorSelect.hidden = false;
    addMemberDiv.hidden = false;
    saveSchedule.hidden = false;
    cancelEditSchedule.hidden = false;
    editSchedule.hidden = true;
    deleteSchedule.hidden = true;
}

function readOnlyScheduleSetting() {
    title.readOnly = true;
    changeTypeBtn.hidden = true;
    startDate.readOnly = true;
    endDate.readOnly = true;
    content.readOnly = true;
    colorSelect.hidden = true;
    addMemberDiv.hidden = true;
    saveSchedule.hidden = true;
    cancelEditSchedule.hidden = true;
    editSchedule.hidden = false;
    deleteSchedule.hidden = false;
}

function changeDateToDateTime(date) {
    return date + "T00:00";
}

function changeDateTimeToDate(datetime) {
    return datetime.split('T')[0];
}

function toLocalISOString(date) {
    date = new Date(date);
    var year = date.getFullYear();
    var month = ('0' + (date.getMonth() + 1)).slice(-2);
    var day = ('0' + date.getDate()).slice(-2);
    var hours = ('0' + date.getHours()).slice(-2);
    var minutes = ('0' + date.getMinutes()).slice(-2);

    return year + '-' + month + '-' + day +
            'T' + hours + ':' + minutes;
}

function getScheduleList(callback) {
    fetch("schedule/getScheduleList")
            .then(response => response.json())
            .then(data => {
                var eventList = [];
                for (var item of data) {
                    eventList.push(item);
                }
                console.log(eventList);

                // Fetch가 완료되면 콜백에 데이터를 전달합니다.
                callback(eventList);
            })
            .catch((error) => console.error('Error:', error));
}

function saveScheduleItem(item) {

    fetch("schedule/addSchedule", {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(item)
    })
            .then(response => response.json())
            .then(data => {
                if (data) {
                    location.reload();
                } else {
                    alert("저장에 실패하였습니다.");
                }
            })
            .catch((error) => console.error('Error:', error));
}


function deleteScheduleItem(item) {
    console.log(item);
}