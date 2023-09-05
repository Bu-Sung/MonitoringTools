/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

/* 프로젝트 내 팀원 검색을 위한 설정*/
function searchProjectMember() {
    var addMemberInput = document.getElementById("addMember");
    var searchMemberDropdown = document.getElementById("searchMember");

    addMemberInput.addEventListener('keyup', function () {
        var searchText = addMemberInput.value;
        var request = {
            uid: searchText,
            memberList: memberList
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
                        var newDiv = document.createElement("div");
                        newDiv.classList.add("dropdown-item");
                        newDiv.textContent = item.id;
                        newDiv.addEventListener('click', function () {
                            addMemberInput.value = newDiv.innerText;
                            console.log(addMemberInput.value);
                            // After setting the value, hide the dropdown menu
                            searchMemberDropdown.classList.remove('show');
                        });
                        searchMemberDropdown.appendChild(newDiv);
                    });
                    if (!searchMemberDropdown.classList.contains('show')) {
                        searchMemberDropdown.classList.add('show');
                    }
                });
    });

    // Hide dropdown when clicking outside of the input field
    document.addEventListener('click', function (event) {
        if (event.target !== addMemberInput && event.target !== searchMemberDropdown) {
            searchMemberDropdown.classList.remove('show');
        }
    });
}



/* 사용자 검색을 위한 js파일*/