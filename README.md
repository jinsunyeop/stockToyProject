# 🔍 국내 주식 시각화 토이 프로젝트 

## 📌 Description

**공공 데이터 API** 를 활용한 **주식 시각화 프로젝트**로 자신이 보유한 국내 주식을 설정하여 변동을 파악하고 자산을 파악할 수 있으며 주식에 대해 모르는 사람들도 한눈에 알아보기 쉽게 개발하도록 하였습니다.

#### * 주요 기술
 - Spring Security를 이용한 보안성
 -  okHttp3를 이용한 API 요청
 -  JQuery Datatables를 이용한 테이블 시각화
 - Apache Echart를 이용한 차트 시각화
- WebSocket을 통한 양방향 통신
- Jsoup을 이용한 웹 스크래핑
-  페이징 및 CRUD, 파일 업로드  

#### * 기간
2023/01/01 ~ 

##  🔨  Technology Stack(s)

 1. Development Tool : Intelli J
 2. FrameWork & ORM : SpringBoot & MyBatis
 3. DB : MYSQL
 4.  API TEST : Postman
 5. Security : Spring Security
 6.  Scraping : Jsoup
 7. Template Engine & Front : JSP, JQuery, JS, HTML, CSS, BootStrap
 8.  Bulid : Maven 

## 🔍  Meaning

웹 개발로 현업을 뛰게 된지 이제 1년 정도 되어가는데 그동안 회사, 개인 공부를 통해서 얻은 역량과 지식을 프로젝트에 담아서 기록하는게 좋겠다고 생각하여 개발하게 된 프로젝트입니다.
공공 데이터 무료 API를 통한 화면들이 주가 되다 보니 프로젝트 자체가 의존성이 심하지만 여러 기술들을 사용해보고 조금 더 효율적인 로직을 고민하는 데에 있어서 나름의 성과가 있다고 생각이 든 프로젝트입니다.
 

## 🖨 Contents

**1. DashBoard (메인 화면)**

![DashBoard](https://user-images.githubusercontent.com/85484391/214487770-c2141877-54fc-4785-a99c-97464da1624c.JPG)
* 주요 기능
	1. 설정한 보유 주식, 관심 주식 테이블 조회
	2.  보유 주식 중 가장 낮은 등락률 주식 차트 조회
	3.  공공 데이터 기준 최신 일자 나의 총 자산 계산

**2. MyStockList (사용자 별 주식 화면)**	

![MystockList](https://user-images.githubusercontent.com/85484391/214487787-7247ea19-a67f-43f6-9311-f20c0e8658bd.JPG)
![StockAdd](https://user-images.githubusercontent.com/85484391/214487788-68ef7af8-2780-4396-a6dd-df8fe0f2e881.JPG)

* 주요 기능
	1.  총 자산 주식 비율을 보여주는 파이 차트
	2.  보유 주식 종목 별 최신 뉴스 1개씩 조회하는 리스트 (Naver News Scraping)
	3.  보유 주식 추가 및 수정, 삭제

**3. StockAllList (국내 주식 리스트 화면)** 

![Allstock](https://user-images.githubusercontent.com/85484391/214487773-fca760c5-2758-419d-9d62-966631aec79f.JPG)

* 주요 기능
	1.  국내 주식 리스트 조회 (페이지 당 10 종목), 검색 조회
	2.  즐겨찾기 설정, 삭제
	3.  onClick시 StockDetail 페이지 이동

**4. StockDetail (국내 주식 종목 당 상세 화면)**

![StockDetail](https://user-images.githubusercontent.com/85484391/214487782-0e191800-ed2b-4754-b3c2-89b581097908.JPG)

* 주요 기능
	1.  (공공 데이터 최신 날짜 기준) 주식 상세 차트,  상세 정보 테이블 조회
	2.  종목 별 웹 사이트 사용자 주식 보유 비율 조회
	3.  종목 별 대화 창 (websocket) 구현 

**5. MyInfo(사용자 정보 화면)**

![Info](https://user-images.githubusercontent.com/85484391/214487776-85738fa9-69df-4246-924a-38287ac00852.JPG)

* 주요 기능
	1. 비밀번호 , 프로필 사진 ,닉네임  설정 수정
	2.  파일 업로드

## 🛠 현 시점 추가 및 수정사항

 - 아이디/비밀번호 찾기 구현 예정
 - 탈퇴하기 구현 예정
 -  비밀번호 5회 틀릴 경우 정지 구현 예정
 -  api 명세서 작성 
