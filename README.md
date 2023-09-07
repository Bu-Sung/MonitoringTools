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
- ##### 협업 도구
  <img src="https://img.shields.io/badge/github-181717?style=flat&logo=github&logoColor=white"> <img src="https://img.shields.io/badge/notion-000000?style=flat&logo=notion&logoColor=white"> <img src="https://img.shields.io/badge/figma-F24E1E?style=flat&logo=figma&logoColor=white">
- ##### 사용언어
  <img src="https://img.shields.io/badge/html5-E34F26?style=flat&logo=html5&logoColor=white"> <img src="https://img.shields.io/badge/css-1572B6?style=flat&logo=css3&logoColor=white"> <img src="https://img.shields.io/badge/bootstrap5-7952B3?style=flat&logo=bootstrap&logoColor=white"> <img src="https://img.shields.io/badge/springboot-6DB33F?style=flat&logo=springboot&logoColor=white"> <img src="https://img.shields.io/badge/java-007396?style=flat&logo=java&logoColor=white"> <img src="https://img.shields.io/badge/javascript-F7DF1E?style=flat&logo=javascript&logoColor=black"> <img src="https://img.shields.io/badge/jquery-0769AD?style=flat&logo=jquery&logoColor=white">
- ##### IDE
  <img src="https://img.shields.io/badge/NetBeans-1B6AC6?style=flat&logo=apache-netbeans-ide&logoColor=white)">
- ##### 데이터베이스
   <img src="https://img.shields.io/badge/mysql-4479A1?style=flate&logo=mysql&logoColor=white">

<br><br>
### 👨‍💻 팀원 구성
- **김부성👑**
  - 프로젝트 진행관리
  - 사용자 관리 기능
  - 게시판, 회의록, 댓글 작성 기능
  - 클라이언트와 웹서버 연결
 
- **이수진**
  - 화면 레이아웃 디자인
  - 사용 템플릿 제작
  - 화면 크기에 맞는 레이아웃 구성
  - 동적 웹 환경 제작
    
- **박채빈**
  - 프로젝트 등록·수정·삭제 기능
  - 팀원 등록 및 권한 수정
  - 요구사항 등록·수정·삭제
  - 요구사항 유사도 검사
  - 요구사항 엑셀 파일 생성
  - 요구사항 진행도 그래프 시각화
<br><br><br>

## ⛓️ 시스템 구성
![시스템 아키텍처](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/4b281e32-7595-4610-b238-fb1d60066673)
- **[SpringBoot](https://spring.io/projects/spring-boot)** - 웹어플리케이션 프레임 워크
- **[Apache POI](https://poi.apache.org/)** - Excel 문서 사용을 위한 라이브러리
- **[Apache Tomcat](https://tomcat.apache.org/)** - 웹서버 유지를 위한 WAS
- **[Spring Data JPA](https://spring.io/projects/spring-data-jpa)** -  DB와 연동을 위한 ORM
- **[MySQL](https://www.mysql.com/)** - 데이터 유지를 위한 DBMS
- **HTML, CSS, [Bootstrap5](https://getbootstrap.com/)** - 화면 구성을 위한 마크업 언어
- **JavaScript** - 클라이언트의 요청을 처리하기 위한 스크립트 언어
- **[Sortable.js](https://sortablejs.github.io/Sortable/)** - KanBan보드를 구현하기 위한 JQuery 라이브러리
- **[Chart.js](https://www.chartjs.org/)** - 진행상황을 그래프로 알아보기 쉽게 만들기 위한 그래프 라이브러리
- **[AI API·DATA ParaphraseQA](https://aiopen.etri.re.kr/)** - 문장의 유사도 검사를 위한 오픈API
- **[FullCalendar](https://fullcalendar.io/)** - 일정 확인을 위한 캘린더 라이브러리
<br><br><br>
## 📌 주요 기능
### UseCaseDiagram
![UseCaseDiagram](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/93811002/7c156d66-cca5-425a-ab5e-ffdd898a6db4)

### 1. 사용자 관리
#### 1.1 기본적인 로그인, 회원가입 기능
#### 1.2 프로젝트 등록 후 수정
![프로젝트 등록 후 수정](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/93811002/c5d83384-9f29-4f7a-b9b1-a38fb943eaee)
#### 1.3 사용자 검색 후 멤버 추가
![사용자 검색 후 멤버 추가](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/93811002/6f225089-39c2-4075-9328-d23fa0cafce2)
#### 1.4 초대 메시지 수신 후 확인
![초대 메시지](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/93811002/4d222c67-c387-459c-9b56-efbaab131055)
![초대 메시지 확인](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/93811002/36223e51-83f6-4a14-a997-85fc21fe63b4)

<br>

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
#### 2.6 요구사항 그래프
- [Chart.js](https://www.chartjs.org/)를 이용하여 전체 진행도 그래프 및 번다운 차트 작성<br><br>
![전체 진행도 그래프](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/609b5f2b-bd93-487d-b668-d97ecbc70303)
![번다운 차트](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/d2b145a5-c415-49e6-b766-cf7aa23e03a9)
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
<br><br>
#### 3.4 게시판 목록
![게시판 목록](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/21f0b0a7-4d21-41b8-bc9b-50df1fd172ed)
<br><br>
#### 3.5 게시글 작성
![게시판 글 작성](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/4abd26b1-e931-49bb-a645-ebe4515c5596)
#### 3.6 게시글 확인
- 게시글을 확인하고 댓글 작성 가능
- 댓글에 대한 대댓글도 작성 가능
<br><br>
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
![대시보드](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/4d13785b-88e6-40d6-9aa8-f6fb0d3cd09c)
<br><br>
#### 5.2 중간 화면
![대시보드(md)](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/45acb3a5-7a64-4446-a497-b1509ccb1949)
<br><br>
#### 5.3 작은 화면
![대시보드(sm)](https://github.com/KimLeeParkTeam-2023/MonitoringTools/assets/104774302/e6c92a06-d662-4191-96f3-96e313fb10d1)
<br><br><br>

## 💡 사용 방법
### 1. 프로젝트 폴더 파일 다운로드
### 2. 원하는 위치에 압축 해제
### 3. 폴더 안 'monitoring-sql' 파일을 이용하여 MySQL에 테이블 생성
### 4. src/main/resources/application.properties 파일에서 연결 정보 확인하고 자신의 DB에 연결
- **연결 URL** - spring.datasource.url=jdbc:mysql://localhost:3306/monitoring??useSSL=false&allowPublicKeyRetrieval=true&characterEncoding=UTF-8&serverTimezone=Asia/Seoul<br>
- **연결 아이디** - spring.datasource.username=monitoring<br>
- **연결 비밀번호** - spring.datasource.password=qwer1234<br>
### 5. 해당 프로젝트 최상위 폴더로 이동하여 (pom.xml이 있는 폴더) cmd 창 실행
### 6. ./mvnw clean install 명령어를 사용해서 빌드
### 7. java -jar target/monitoring.war 명령어를 사용해 실행
### 8. localhost:8080/monitoring/ 경로로 접속
<br><br><br>
<img src="https://capsule-render.vercel.app/api?type=waving&color=369fff&height=80&section=footer" />
