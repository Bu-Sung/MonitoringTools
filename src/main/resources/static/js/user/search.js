/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

/* 프로젝트 내 포함된 팀원 중 원하는 멤버 리스트를 제외한 검색을 위한 설정*/
function searchProjectMember() {
    var addMemberInput = document.getElementById("addMember");
    var searchMemberDropdown = document.getElementById("searchMember");

    addMemberInput.addEventListener('keyup', function () {
        var searchText = addMemberInput.value;
        var memberListId = [];
        memberList.forEach(item => {
            memberListId.push(item.id);
        });
        var request = {
            uid: searchText,
            memberList: memberListId
        };
        fetch('/monitoring/project/searchMembers', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(request)
        })
                .then(response => response.json())
                .then(data => {
                    searchMemberDropdown.innerHTML = '';
                    data.forEach(item => {
                        var newDiv = createProfileCard(item.name, item.id);
                        newDiv.classList.add("dropdown-item");
                        newDiv.addEventListener('click', function () {
                            addMemberInput.value = item.id;
                            searchMemberDropdown.classList.remove('show');
                        });
                        searchMemberDropdown.appendChild(newDiv);
                    });
                    if (!searchMemberDropdown.classList.contains('show')) {
                        searchMemberDropdown.classList.add('show');
                    }
                });
    });

    document.addEventListener('click', function (event) {
        if (event.target !== addMemberInput && event.target !== searchMemberDropdown) {
            searchMemberDropdown.classList.remove('show');
        }
    });
}

/* 프로젝트 내 모든 팀원 정보를 가져오는 함수 */
function getAllMemberInfo() {
    var addMemberInput = document.getElementById("uid");
    var searchMemberDropdown = document.getElementById("searchMember");

    addMemberInput.addEventListener('keyup', function () {
        fetch('/monitoring/project/getAllMemberInfo', {})
                .then(response => response.json())
                .then(data => {
                    searchMemberDropdown.innerHTML = '';
                    data.forEach(item => {
                        var newDiv = createProfileCard(item.name, item.id);
                        newDiv.classList.add("dropdown-item");
                        newDiv.addEventListener('click', function () {
                            addMemberInput.value = item.id;
                            searchMemberDropdown.classList.remove('show');
                        });
                        searchMemberDropdown.appendChild(newDiv);
                    });
                    if (!searchMemberDropdown.classList.contains('show')) {
                        searchMemberDropdown.classList.add('show');
                    }
                });
    });
    document.addEventListener('click', function (event) {
        if (event.target !== addMemberInput && event.target !== searchMemberDropdown) {
            searchMemberDropdown.classList.remove('show');
        }
    });
}

/* 사용자 검색을 위한 js파일*/

/* 검색 창에 나오는 div 형식 */
function createProfileCard(name, id) {
    // Create main div
    var newDiv = document.createElement("div");
    newDiv.classList.add("d-flex", "p-1");
    newDiv.id = id;
    // Create image div
    var imgDiv = document.createElement("div");
    imgDiv.classList.add("d-flex", "flex-column", "align-items-center", "justify-content-center");

    var img = document.createElement("img");
    img.src = "/monitoring/asset/profile.png";
    img.alt = "프로필 이미지";
    img.classList.add("rounded-circle");
    img.style.width = '2.0rem';
    img.style.height = '2.0rem';


    // Append image to the image div
    imgDiv.appendChild(img);

    // Create text div
    var textDiv = document.createElement("div");
    textDiv.classList.add('ps-1', 'd-flex', 'flex-column', 'justify-content-center');

    var labelElement = document.createElement('label');
    labelElement.classList.add('text-dark');
    labelElement.innerText = name;


    var smallElement = document.createElement('small');
    smallElement.classList.add('text-gray');
    smallElement.innerText = id;


    // Append elements to the text div 
    textDiv.appendChild(labelElement);
    textDiv.appendChild(smallElement);

    // Append all elements to the main div
    newDiv.appendChild(imgDiv);
    newDiv.appendChild(textDiv);

    return newDiv;
}