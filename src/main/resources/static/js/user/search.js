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
        fetch('/monitoring/project/searchMembers?uid=' + searchText)
                .then(response => response.json())
                .then(data => {
                    searchMemberDropdown.innerHTML = '';
                    data.forEach(item => {
                        var newDiv = document.createElement("div");
                        newDiv.classList.add("dropdown-item");
                        newDiv.textContent = item.id;
                        newDiv.addEventListener('click', function(){
                            addMemberInput.value = newDiv.innerText;
                            console.log(addMemberInput.value);
                        });
                        searchMemberDropdown.appendChild(newDiv);
                    });
                    if (!searchMemberDropdown.classList.contains('show')) {
                        searchMemberDropdown.classList.add('show');
                    }
                });
    });
    
    addMemberInput.addEventListener('blur', function(){
        searchMemberDropdown.classList.remove('show');
    });
}



/* 사용자 검색을 위한 js파일*/