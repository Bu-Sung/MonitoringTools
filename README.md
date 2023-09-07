<img src="https://capsule-render.vercel.app/api?type=waving&color=369fff&height=300&section=header&text=MonitoringTools&fontSize=70&fontColor=f0f8ff" />

<br>
<p align="center">✨ Scrm 개발 방법론을 기반으로 하는 프로젝트 진행 관리 사이트 ✨</p>
<br><br><br>

## 🔎 목차
1. [프로젝트 소개](#-프로젝트-소개) <br>
  1.1 [개발 기간](#-개발-기간) <br>
  1.2 [개발 환경](#-개발-환경) <br>
  1.3 [팀원 구성](#-팀원-구성) <br><br>
2. [시스템 구성](#️-시스템-구성) <br><br>
3. [주요 기능](#-주요-기능) <br>
  3.1 [사용자 관리](#1-사용자-관리) <br>
  3.2 [요구사항관리](#2-요구사항관리) <br>
  3.3 [프로젝트 자료 관리](#3-프로젝트-자료-관리) <br>
  3.4 [일정 관리](#4-일정-관리) <br>
  3.5 [동적 웹 어플리케이션 시스템](#5-동적-웹-어플리케이션-시스템) <br><br>
4. [사용 방법](#-사용-방법)

<br><br><br>
## 🖥 프로젝트 소개
**Scrm 개발 방법론**을 이용한 프로젝트를 진행할 때 필요한 기능을 제공해주고 진행 상황을 관리해주는 사이트입니다. 
<br><br>
### 📅 개발 기간
- 2023.07.28 ~ (진행 중)
<br><br>
### ⚙ 개발 환경
- ##### 협업
  <img src="https://img.shields.io/badge/github-181717?style=flat&logo=github&logoColor=white"> <img src="https://img.shields.io/badge/notion-000000?style=flat&logo=notion&logoColor=white"> <img src="https://img.shields.io/badge/figma-F24E1E?style=flat&logo=figma&logoColor=white">
- ##### 모시기1
  <img src="https://img.shields.io/badge/html5-E34F26?style=flat&logo=html5&logoColor=white"> <img src="https://img.shields.io/badge/css-1572B6?style=flat&logo=css3&logoColor=white"> <img src="https://img.shields.io/badge/bootstrap5-7952B3?style=flat&logo=bootstrap&logoColor=white"> <img src="https://img.shields.io/badge/springboot-6DB33F?style=flat&logo=springboot&logoColor=white">
- ##### 모시기2 
  <img src="https://img.shields.io/badge/java-007396?style=flat&logo=java&logoColor=white"> <img src="https://img.shields.io/badge/javascript-F7DF1E?style=flat&logo=javascript&logoColor=black">
- ##### 모시기3
  <img src="https://img.shields.io/badge/mysql-4479A1?style=flate&logo=mysql&logoColor=white"> <img src="https://img.shields.io/badge/jquery-0769AD?style=flat&logo=jquery&logoColor=white"> <img src="https://img.shields.io/badge/NetBeans-1B6AC6?style=flat&logo=apache-netbeans-ide&logoColor=white)">


<br><br>
### 👨‍💻 팀원 구성
- **김부성** - 역할 뭐햇는지
- **이수진** - 역할 뭐햇는지
- **박채빈** - 역할 뭐햇는지
<br><br><br>

## ⛓️ 시스템 구성

<br><br><br>
## 📌 주요 기능
### 1. 사용자 관리

<br><br>
### 2. 요구사항관리
#### 2.1 요구사항 작성
![요구사항 생성](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/6b0d4c90-656a-4786-a479-763459daca85)

#### 2.2 요구사항 목록
- 이번 주 스프린트 항목인 경우 노란색으로 표시
<br><br>
![요구사항](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/de2ae1bd-99c1-437e-ab8f-d5c0e1a98b3e)
<br><br>
#### 2.3 유사도 검사
- 요구사항을 등록할 때, [AI API·DATA ParaphraseQA](https://aiopen.etri.re.kr/)를 이용하여 등록되어 있는 요구사항과 유사한지 검사<br><br>
![유사도 검사](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/3bfec70b-115a-4281-bfbf-5e1ba7c33656)
<br><br>
#### 2.4 스프린트 목록
![스프린트 목록](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/69a947a9-b810-44e8-924c-aa34e538b9b9)
#### 2.5 칸반보드
- 스프린트를 효율적으로 관리할 수 있도록 칸반보드 구현
- [Sortable.js](https://sortablejs.github.io/Sortable/)를 이용하여 요구사항 진행 상황을 drag & drop 으로 관리<br><br>
![칸반보드](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/742f3bb1-9dc7-48e9-a187-665235901289)
![칸반보드(모달)](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/5c24c46b-ebc2-4d80-a267-a974acd9ea25)

<br><br>
### 3. 프로젝트 자료 관리
#### 3.1 회의록 작성
- 사이트 내에서 제목, 시간, 장소, 내용을 입력하여 회의록 작성 가능
- 회의록 내 파일 첨부 가능<br><br>
![회의록 작성](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/6f16ccad-9d24-4643-8bfc-8f827c0be207)
<br><br>
#### 3.2 회의록 목록
![회의록 목록](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/bb950a59-cea0-44c1-959b-9c75692de7b5)
<br><br>
#### 3.3 회의록 확인
![회의록 확인](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/ccbf3354-4b4d-453e-a976-2290f2bbe156)

![게시판 목록](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/21f0b0a7-4d21-41b8-bc9b-50df1fd172ed)
![게시판 글 작성](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/4abd26b1-e931-49bb-a645-ebe4515c5596)
![게시판 글 확인](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/0bba4bc5-cc15-4240-a0b5-6d7489a6d5c9)

<br><br>
### 4. 일정 관리
#### 4.1 일정 등록
- 일정을 등록하여 팀원들과 공유
- 해당 일정에 참여하는 팀원 관리
- 색상 지정 가능<br><br>
![일정등록](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/69da79f7-0b70-4489-b6cd-47bd8497e2f7)
<br><br>
#### 4.2 일정 확인
- [FullCalendar](https://fullcalendar.io/)를 이용하여 일정 확인
![일정](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/9cd420f3-701b-401e-83ed-b8ee4831f281)



<br><br>
### 5. 동적 웹 어플리케이션 시스템
- [Bootstrap5](https://getbootstrap.com/)를 이용하여 모든 페이지를 화면 크기에 따라 동적으로 화면 배치가 바뀌도록 설계
<br><br>
#### 5.1 큰 화면
![대시보드](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/3dc433b5-89e9-436b-99fa-b822a075b3d1)
<br><br>
#### 5.2 중간 화면
![대시보드(md)](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/9ebce9e1-4f85-4f4a-ab01-8897e7526977)
<br><br>
#### 5.3 작은 화면
![대시보드(sm)](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/13054c46-0e17-442d-b5d0-d438f14d6f57)

<br><br><br>
## 💡 사용 방법

<br><br><br>
<img src="https://capsule-render.vercel.app/api?type=waving&color=369fff&height=80&section=footer" />
