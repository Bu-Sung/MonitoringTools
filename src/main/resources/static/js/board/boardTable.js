/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener('DOMContentLoaded', function () {
    let paramCategory = new URLSearchParams(window.location.search).get('category');
    let paramPage = new URLSearchParams(window.location.search).get('page');
    if (paramCategory === null) {
        paramCategory = '공지사항';
    }
    var liItems = document.querySelectorAll("#pageList .page-item a");
    liItems.forEach(function (item) {
        newHref = item.getAttribute("href") + "&category=" + paramCategory;
        item.setAttribute("href", newHref);
        if (item.textContent.trim() === String(paramPage)) {
            item.style.backgroundColor = "#369FFF";
            item.style.color = "white";
        }
        
    });

    let category = document.getElementById("category");
    category.value = paramCategory;
    category.addEventListener("change", function () {
        window.location.href = "list?page=1&category=" + category.value;
    });
});

function loadTableData(nowPage) {
    const category = document.getElementById("category").value;
    const requestData = {
        category: category,
        page: nowPage
    };
    fetch('boards', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(requestData)
    })
            .then(response => response.json())
            .then(data => {
                console.log(data.content);
                if (data && data.length > 0) {
                    let listElement = document.getElementById('list');
                    listElement.innerHTML = '';
                    for (let item of data) {
                        let row = document.createElement('tr');
                        let categoryCell = document.createElement('td');
                        categoryCell.textContent = item.category;
                        row.appendChild(categoryCell);

                        let titleCell = document.createElement('td');
                        let titleLink = document.createElement('a');
                        titleLink.href = item.bid;
                        titleLink.textContent = item.title;

                        titleCell.appendChild(titleLink);
                        row.appendChild(titleCell);

                        let writerCell = document.createElement('td');
                        writerCell.textContent = item.writer;
                        row.appendChild(writerCell);

                        let dateCell = document.createElement('td');
                        dateCell.textContent = item.date;

                        row.appendChild(dateCell);

                        listElement.appendChild(row);
                    }
                }
            })
            .catch(error => console.error('Error:', error));
}

//document.addEventListener('DOMContentLoaded', function () {
//    loadTableData(1);
//    //카테고리 변경 시 공지사항 목록 변경
//    document.getElementById("category").addEventListener("change", () => loadTableData(1));
//});

const dashboardMenu = document.getElementById("dashboardMenu");
const offcanvasDashboardMenu = document.getElementById("offcanvasDashboardMenu");

// menuContent의 내용을 offcanvasMenuContent에 가져와서 화면에 출력
offcanvasDashboardMenu.innerHTML = dashboardMenu.innerHTML;