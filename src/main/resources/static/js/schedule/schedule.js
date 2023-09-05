var memberList = [];

document.addEventListener('DOMContentLoaded', function () {
    var myModal = new bootstrap.Modal(document.getElementById('openModal'), {});
    
    document.getElementById("addMember").addEventListener("keyup", function(){
        searchProjectMember();
    });
    
//    //닫기버튼
//    var closeModalSpan = document.getElementById("closeModal");
//    closeModalSpan.addEventListener('click', function () {
//        myModal.hide();
//    });
    
    var changeTypeBtn = document.getElementById("changeTypeBtn");
    changeTypeBtn.addEventListener("click", function () {
        if (startDate.type === "date") {
            var baseStart = startDate.value;
            var baseEnd = endDate.value;
            startDate.type = "datetime-local";
            endDate.type = "datetime-local";
            startDate.value = changeDateToDateTime(baseStart);
            endDate.value = changeDateToDateTime(baseEnd);
        } else if (startDate.type === "datetime-local") {
            var baseStart = startDate.value;
            var baseEnd = endDate.value;
            startDate.type = "date";
            endDate.type = "date";
            startDate.value = changeDateTimeToDate(baseStart);
            endDate.value = changeDateTimeToDate(baseEnd);
        }
    });

    var colorSelect = document.getElementById("colorSelect");
    colorSelect.addEventListener('change', function () {
        colorSelect.style.backgroundColor = colorSelect.value;
    });
    
    //추가버튼
    var addMemberBtn = document.getElementById("addMemberBtn");
    addMemberBtn.addEventListener('click', function () {
        if (addMember.value !== '') { // 입력 필드가 비어있지 않은 경우에만 추가
            if (memberList[0] === '') {
                memberList = [];
            }
            memberList.push(addMember.value);
            addMember.value = ''; // 입력 필드를 비움
            memberListDiv.innerHTML = '';
            memberList.forEach(element => {
                var newDiv = document.createElement("div");
                newDiv.classList.add("p-1", "rounded");
                newDiv.style.border = "1px solid #c4c4c4";
                newDiv.innerText = element;
                memberListDiv.appendChild(newDiv);
            });
        }
    });


    var saveScheduleButton = document.getElementById("saveSchedule");
    saveScheduleButton.addEventListener("click", function () {
        if (confirm("저장하시겠습니까??") == true) {
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
                sid: sid.value,
                allTime: allTime,
                title: title.value,
                content: content.value,
                color: colorSelect.value,
                start: startDate.value,
                end: endDateValue,
                memberList: memberList
            };
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
        } else {
            return false;
        }

    });

    var updateScheduleButton = document.getElementById("updateSchedule");
    updateScheduleButton.addEventListener("click", function () {
        if (confirm("수정하시겠습니까??") == true) {
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
                sid: sid.value,
                allTime: allTime,
                title: title.value,
                content: content.value,
                color: colorSelect.value,
                start: startDate.value,
                end: endDateValue,
                memberList: memberList
            };
            fetch("schedule/updateSchedule", {
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
                            alert("수정에 실패하였습니다.");
                        }
                    })
                    .catch((error) => console.error('Error:', error));
        } else {
            return false;
        }
    });

    var editScheduleButton = document.getElementById("editSchedule");
    editScheduleButton.addEventListener("click", function () {
        updateScheduleSetting();
    });


    var deleteScheduleButton = document.getElementById("deleteSchedule");
    deleteScheduleButton.addEventListener("click", function () {
        if (confirm("정말 삭제하시겠습니까??") == true) {    //확인
            var item = {
                sid: sid.value
            }
            fetch("schedule/deleteSchedule", {
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
                            alert("삭제에 실패하였습니다.");
                        }
                    })
                    .catch((error) => console.error('Error:', error));
        } else {
            return false;
        }

    });
});


function scheduleModal() {
    var myModal = new bootstrap.Modal(document.getElementById('openModal'), {});

    myModal.show();
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
    if (memberList[0] === '') {
        memberList = [];
    }
    memberListDiv.innerHTML = '';
    memberList.forEach(element => {
        var newDiv = document.createElement("div");
        newDiv.classList.add("p-1", "rounded");
        newDiv.style.border = "1px solid #c4c4c4";
        newDiv.innerText = element;
        memberListDiv.appendChild(newDiv);
    });
    addMember.value='';
}

function updateScheduleSetting() {
    title.readOnly = false;
    changeTypeBtn.hidden = false;
    startDate.readOnly = false;
    endDate.readOnly = false;
    content.readOnly = false;
    colorSelectDiv.hidden = false;
    addMemberDiv.hidden = false;
    saveSchedule.hidden = true;
    editSchedule.hidden = true;
    deleteSchedule.hidden = false;
    updateSchedule.hidden = false;
}

function editScheduleSetting() {
    title.readOnly = false;
    changeTypeBtn.hidden = false;
    startDate.readOnly = false;
    endDate.readOnly = false;
    content.readOnly = false;
    colorSelectDiv.hidden = false;
    addMemberDiv.hidden = false;
    saveSchedule.hidden = false;
    editSchedule.hidden = true;
    deleteSchedule.hidden = true;
    updateSchedule.hidden = true;
}

function readOnlyScheduleSetting() {
    title.readOnly = true;
    changeTypeBtn.hidden = true;
    startDate.readOnly = true;
    endDate.readOnly = true;
    content.readOnly = true;
    colorSelectDiv.hidden = true;
    addMemberDiv.hidden = true;
    saveSchedule.hidden = true;
    editSchedule.hidden = false;
    deleteSchedule.hidden = true;
    updateSchedule.hidden = true;
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
                // Fetch가 완료되면 콜백에 데이터를 전달합니다.
                callback(eventList);
            })
            .catch((error) => console.error('Error:', error));
}
