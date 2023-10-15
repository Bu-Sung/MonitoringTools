var memberList = [];
document.addEventListener('DOMContentLoaded', function () {

    document.getElementById("addMember").addEventListener("keyup", function () {
        searchProjectMember();
    });

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
        // 입력 필드가 비어있지 않은 경우에만 추가
        if (addMember.value !== '') {
            fetch('/monitoring/project/hasMember?uid=' + addMember.value, {
            })
                    .then(response => response.json())
                    .then(data => {
                        if (data.id != null) {
                            if (memberList[0] === '') {
                                memberList = [];
                            }
                            memberList.push(data);
                            addMember.value = ''; // 입력 필드를 비움
                            memberListDiv.innerHTML = '';
                            editMemberList();
                        } else {
                            alert("검색 결과가 없습니다");
                            addMember.value = '';
                        }
                    });
        }
    });


    var saveScheduleButton = document.getElementById("saveSchedule");
    saveScheduleButton.addEventListener("click", function () {
        if (confirm("저장하시겠습니까??") == true) {
            var item = scheduleItem();
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
    
    function scheduleItem(){
        var memberListId = [];
            memberList.forEach(item => {
                memberListId.push(item.id);
            });
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
                memberList: memberListId
            };
            return item;
    }
    
    var updateScheduleButton = document.getElementById("updateSchedule");
    updateScheduleButton.addEventListener("click", function () {
        if (confirm("수정하시겠습니까??") == true) {
            var memberListId = [];
            memberList.forEach(item => {
                memberListId.push(item.id);
            });
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
                memberList: memberListId
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

async function scheduleModalSetting(item) { // 일정 초기값 세팅
    sid.value = item.sid;
    title.value = item.title;
    startDate.type = item.startDateType;
    startDate.value = item.startDateValue;
    endDate.type = item.endDateType;
    endDate.value = item.endDateValue;
    content.value = item.content;
    colorSelect.style.backgroundColor = item.color;
    memberList = await getScheduleMemberList(item.sid);
    memberListDiv.innerHTML = '';
    memberList.forEach(element => {
        var newDiv = createProfileCard(element.name, element.id);
        memberListDiv.appendChild(newDiv);
    });
    addMember.value = '';
}

function updateScheduleSetting() {
    title.readOnly = false;
    changeTypeBtn.hidden = false;
    startDate.readOnly = false;
    endDate.readOnly = false;
    content.readOnly = false;
    colorSelectDiv.hidden = false;
    addMemberDiv.hidden = false;
    memberListDiv.innerHTML = '';
    editMemberList();
    saveSchedule.hidden = true;
    editSchedule.hidden = true;
    deleteSchedule.hidden = false;
    updateSchedule.hidden = false;
}

// 일정 관련 멤버들을 삭제할 수 있도록 프로필카드에 x 버튼 추가
function editMemberList() {
    memberList.forEach(element => {
        var card = createProfileCard(element.name, element.id);
        var cardDiv = document.createElement("div");
        cardDiv.className = "d-flex flex-column col-11";
        cardDiv.appendChild(card);

        var outerDiv = document.createElement("div");
        outerDiv.className = "d-flex";

        // 'x' 버튼 생성

        var closeBtn = document.createElement("span");
        closeBtn.className = "text-gray";
        closeBtn.textContent = 'x';

        // Hover 이벤트 리스너 추가
        outerDiv.addEventListener("mouseover", function () {
            closeBtn.classList.remove('d-none');  // Hover 시 d-none 클래스 제거
            closeBtn.classList.add('d-inline-block');  // d-inline-block 클래스 추가하여 보이게 함
        });

        outerDiv.addEventListener("mouseout", function () {
            closeBtn.classList.add('d-none');  // Mouseout 시 다시 숨김
            closeBtn.classList.remove('d-inline-block');
        });

        // 'x' 버튼에 클릭 이벤트 리스너 추가
        closeBtn.addEventListener("click", function (e) {
            memberList = memberList.filter(function (member) {
                return member.id !== card.id;
            });
            memberListDiv.innerHTML = '';
            editMemberList();
        });

        var closeDiv = document.createElement("div");
        closeDiv.className = "flex-column col-1 d-flex align-items-center justify-content-center";
        closeDiv.appendChild(closeBtn);


        outerDiv.appendChild(cardDiv);
        outerDiv.appendChild(closeDiv);
        memberListDiv.appendChild(outerDiv);
    });
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

async function getScheduleMemberList(sid) {
    var ScheduleMemberList = [];
    try {
        const response = await fetch("/monitoring/project/schedule/getScheduleMembers?sid=" + parseInt(sid));
        const data = await response.json();
        for (var item of data) {
            ScheduleMemberList.push(item);
        }
    } catch (error) {
        console.error('Error:', error);
    }
    return ScheduleMemberList;
}