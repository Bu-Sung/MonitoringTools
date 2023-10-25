


let checkId = false;
let checkPw = false;
const birth = document.getElementById("birth");
const phone = document.getElementById("phone");
const phone2 = document.getElementById("phone2");
const phone3 = document.getElementById("phone3");
const yearSelect = document.getElementById("year");
const monthSelect = document.getElementById("month");
const daySelect = document.getElementById("day");
document.addEventListener('DOMContentLoaded', function () {
    //비밀번호 확인
    document.getElementById("pw").addEventListener("blur", pwCheck);
    document.getElementById("pw2").addEventListener("blur", pwCheck);
    //전화번호 숫자키 이외 입력 금지
    phone2.addEventListener("input", restrictNonNumeric);
    phone3.addEventListener("input", restrictNonNumeric);
    //최대 4자리까지 입력 가능
    phone2.addEventListener("input", restrictMaxLength);
    phone3.addEventListener("input", restrictMaxLength);
    settingDate();
    if (window.location.href.includes("update")) {
        document.getElementById("deleteUser").addEventListener("click", function () {
            if (confirm("정말로 계정을 삭제하시겠습니까?")) {
                fetch('deleteUser', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                }).then(response => response.json())
                        .then(data => {
                            if (data) {
                                alert("회원정보가 삭제되었습니다.");
                                window.location.href = "/monitoring";
                            } else {
                                alert("회원정보 삭제에 실패했습니다.")
                            }
                        })
            }
        });
        document.getElementById('pwChangeForm').addEventListener('submit', function (event) {
            //전화번호 유효성 검사
            const phone2Value = document.getElementById('phone2').value;
            const phone3Value = document.getElementById('phone3').value;
            if (!checkPw) {
                event.preventDefault();
                alert("비밀번호를 확인하여주세요.");
            } else if (!/^\d+$/.test(phone2Value) || phone2Value.length < 4 || !/^\d+$/.test(phone3Value) || phone3Value.length < 4) {
                event.preventDefault();
                alert('전화번호는 숫자여야 합니다.');
            }
        });
        document.getElementById("updateUserInfo").addEventListener('submit', function (event) {
            birth.value = yearSelect.value + '-' + monthSelect.value + '-' + daySelect.value;
            var phone1 = document.getElementById("phone1");
            phone.value = phone1.value + '-' + phone2.value + '-' + phone3.value;
        });
        yearSelect.value = birth.value.split('-')[0];
        monthSelect.value = birth.value.split('-')[1];
        daySelect.value = birth.value.split('-')[2];
        document.getElementById("phone1").value = phone.value.split('-')[0];
        phone2.value = phone.value.split('-')[1];
        phone3.value = phone.value.split('-')[2];
    } else {
        document.getElementById("checkIdBtn").addEventListener("click", function () {
            const id = document.getElementById('id').value;
            if (id === '') {
                alert("아이디를 입력해주세요.");
            } else if (id.length < 5) {
                alert("아이디는 5자~20자 사이로 입력해주세요.");
            } else {
                fetch("/monitoring/idcheck/" + id)
                        .then(response => response.json())
                        .then(data => {
                            if (data !== 2) {
                                alert("사용 불가능한 아이디입니다.");
                                checkId = false;
                            } else {
                                alert("사용 가능한 아이디입니다.");
                                checkId = true;
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert("아이디 중복 확인에 실패했습니다.");
                            checkId = false;
                        });
            }
        });
    }
});

function pwCheck() {
    const pw = document.getElementById("pw").value;
    const repeatPw = document.getElementById("pw2").value;
    const checkResult = document.getElementById("pw-result");
    if (pw === repeatPw) {
        checkPw = true;
        checkResult.style.color = "green";
        checkResult.innerHTML = "비밀번호가 일치합니다.";
        checkResult.style.display = "block";
    } else {
        checkPw = false;
        checkResult.style.color = "red";
        checkResult.innerHTML = "비밀번호가 일치하지 않습니다.";
        checkResult.style.display = "block";
    }
}

// 숫자 외의 키 입력 방지
function restrictNonNumeric(event) {
    const input = event.target;
    const newValue = input.value.replace(/[^\d]/g, ""); // 숫자 이외의 문자 제거
    input.value = newValue;
}

// 최대 4자리까지 입력 가능하도록 설정
function restrictMaxLength(event) {
    const input = event.target;
    if (input.value.length > 4) {
        input.value = input.value.slice(0, 4);
    }
}

//윤년 계산
function isLeapYear(year) {
    if (year % 4 !== 0) {
        return false;
    } else if (year % 100 !== 0) {
        return true;
    } else if (year % 400 !== 0) {
        return false;
    } else {
        return true;
    }
}


//년,월,일을 드롭박스로 설정
function settingDate() {
    let yearNow = new Date().getFullYear();
    let monthNow = new Date().getMonth() + 1;
    let dayNow = new Date().getDate();
    // 현재 년도부터 1930년까지의 옵션 생성
    const currentYear = new Date().getFullYear();
    for (let year = yearNow; year >= 1930; year--) {
        const option = document.createElement("option");
        option.value = year;
        option.textContent = year + "년";
        yearSelect.appendChild(option);
    }
    yearSelect.value = yearNow;
    // 1월부터 12월까지의 옵션 생성
    for (let month = 1; month <= 12; month++) {
        const option = document.createElement("option");
        option.value = month;
        option.textContent = month + "월";
        monthSelect.appendChild(option);
    }
    monthSelect.value = monthNow;
    settingDays();
    daySelect.value = dayNow;
    monthSelect.addEventListener("change", function () {
        settingDays();
    });
}
// 해당 달에 따른 날짜 계산
function settingDays() {
    let days = 30;
    if (monthSelect.value == '2') {
        // 선택된 년도가 윤년인지 확인합니다.
        const isLeap = isLeapYear(Number(yearSelect.value));
        // 윤년이면 2월은 29일까지, 아니면 28일
        days = isLeap ? 29 : 28;
    } else if ([1, 3, 5, 7, 8, 10, 12].includes(Number(monthSelect.value))) {
        days = 31;
    }
    for (let day = 1; day <= days; day++) {
        const option = document.createElement("option");
        option.value = day;
        option.textContent = day + "일";
        daySelect.appendChild(option);
    }
    daySelect.value = 1;
}

//회원가입 확인
function checkSignUp() {
    if (!checkId) {
        alert("아이디 확인을 진행하여주세요.");
        return false;
    } else if (!checkPw) {
        alert("비밀번호를 확인하여주세요.");
        return false;
    } else {
        birth.value = yearSelect.value + '-' + monthSelect.value + '-' + daySelect.value;
        var phone1 = document.getElementById("phone1");
        phone.value = phone1.value + '-' + phone2.value + '-' + phone3.value;
        return true;
    }
}