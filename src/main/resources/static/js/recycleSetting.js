/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


/* 메뉴 탭 재사용을 위한 script*/
const menuContent = document.getElementById("menuContent");
const offcanvasMenuContent = document.getElementById("offcanvasMenuContent");

// menuContent의 내용을 offcanvasMenuContent에 가져와서 화면에 출력
offcanvasMenuContent.innerHTML = menuContent.innerHTML;