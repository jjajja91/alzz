<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet"
	href="${pagecontext.request.contextPath}/resources/css/reset.css">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&family=Open+Sans:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<style>
body * {
	font-family: 'Open Sans', 'Noto Sans KR', sans-serif;
}

#classroom {
	width: 1000px;
	margin: 0 auto;
}

header {
	height: 300px;
	padding: 5px;
	background-color: #f4f4f4;
}

header span {
	border: none;
	padding: 5px 20px;
	background-color: #335492;
	color: #f4f4f4;
	margin-bottom: 10px;
}

.classroomDiv {
	float: left;
	margin-right: 30px;
}

header h1 {
	font-size: 30px;
	width: 600px;
}

header h2 {
	font-size: 20px;
	margin-top: 10px;
}

#mainInfo {
	margin-top: 50px;
	line-height: 1.7;
}

header img {
	width: 300px;
	height: 300px;
}

nav {
	/* box-shadow: 0 0 5px rgba(0,0,0,0.3); */
	border-bottom: 1px solid #f4f4f4;
	padding: 10px;
}

nav ul {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin: 10px 130px;
}

nav ul li {
	float: left;
	list-style: none;
	font-size: 20px;
}

nav ul li a {
	text-decoration: none;
	color: black;
}

nav ul li .active {
	color: #335492;
}

.divide {
	float: left;
	width: 498px;
	border-left: 1px solid #f4f4f4;
	border-right: 1px solid #f4f4f4;
}

#intro {
	height: 1000px;
}

#intro h6 {
	margin: 30px;
	font-size: 19px;
}

.introDIV {
	margin-bottom: 100px;
}

table {
	font-size: 16px;
	margin: 10px 30px;
	width: 400px;
}

tr {
	border-bottom: 1px solid #335492;
}

td {
	padding: 20px 10px;
}

.tHead {
	width: 100px;
}

i {
	font-size: 20px;
	margin-right: 5px;
}

/* not required */
*, :active {
	outline: none;
}

.clearfix {
	clear: both;
}

.animate {
	-webkit-transition: all 0.3s ease-in-out;
	-moz-transition: all 0.3s ease-in-out;
	transition: all 0.3s ease-in-out;
}

/* required */
.calendar {
	position: relative;
	border-radius: 4px;
	overflow: hidden;
	width: 455px;
	height: 450px;
	margin-left: 20px;
	background-color: #ffffff;
	color: #333333;
	box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);
}

.calendar h1, .calendar h2 {
	font-weight: 300;
	font-size: 26px;
	line-height: 28px;
	text-transform: uppercase;
	margin-bottom: 20px;
	margin-left: 20px;
}

.calendar h1 span {
	display: block;
}

.calendar .col {
	position: relative;
	float: left;
	height: 100%;
}

.calendar .col .content {
	padding: 40px 30px;
}

.calendar ul {
	margin: 0px;
}

.calendar ul li {
	list-style: none;
}

.calendar .months {
	margin-left: 20px;
}

.calendar .months li, .calendar .weekday li, .calendar .days li {
	float: left;
	text-transform: uppercase;
}

.calendar .weekday li a, .calendar .days li a {
	display: block;
	color: #747978;
}

.calendar .months li a {
	font-size: 20px;
	color: #C7BEBE;
	text-align: center;
	width: 32px;
	margin-bottom: 30px;
	display: none;
}

.calendar .months li .selected {
	font-weight: bold;
	color: #747978;
	display: block;
}

.calendar .months li .moveBtn {
	font-weight: bold;
	color: #747978;
	display: block;
}

.calendar .weekday li a {
	width: 55px;
	text-align: center;
	margin-bottom: 20px;
	font-size: 12px;
}

.calendar .days li {
	width: 55px;
}

.calendar .days li a {
	width: 36px;
	height: 24px;
	text-align: center;
	margin: auto auto;
	font-size: 12px;
	font-weight: bold;
	border-radius: 12px;
	margin-bottom: 10px;
	padding-top: 10px;
}

.calendar .days li a:hover {
	background-color: #EEEDE9;
}

.calendar .days li .selected {
	background-color: #335492 !important;
	color: #ffffff;
}

.calendar .days li .event {
	color: #335492;
}

.bigSubject {
	font-weight: bold;
}

.smallSubject td {
	padding-left: 40px;
}

#teacherInfo {
	margin-top: 220px;
}

/* placeholder color */
::-webkit-input-placeholder {
	color: #ffffff;
}

:-moz-placeholder {
	color: #ffffff;
}

::-moz-placeholder {
	color: #ffffff;
}

:-ms-input-placeholder {
	color: #ffffff;
}

#lecture {
	height: 1000px;
}

#stream {
	height: 700px;
	border: 1px solid gray;
	display: none;
}

#announce {
	display: none;
}

#qna {
	display: none;
}

#homework {
	display: none;
}

.home {
	position: fixed;
	width: 50px;
	height: 50px;
	right: 50px;
	bottom: 50px;
	margin: 0;
	border-radius: 30px;
}

.home a {
	text-decoration: none;
	color: #335492;
}

.home i {
	font-size: 40px;
}

.table-container {
	width: 60%;
	padding-left: 30px;
	margin-top: 30px;
	margin-left: 150px;
}

.content-table {
	border-collapse: collapse;
	font-size: 0.9em;
	min-width: 600px;
	width: 100%;
	border-radius: 5px 5px 0 0;
	overflow: hidden;
}

.content-table th {
	text-align: center;
	padding-bottom: 10px;
	font-size: 16px;
	font-weight: bold;
}

td.title {
	text-align: left;
	padding-left: 25px;
}

.content-table tr {
	text-align: center;
}

a.read {
	color: black;
}
</style>
</head>

<body>
	<div id="classroom">
		<header>
			<div class="classroomDiv">
				<img
					src="/resources/img/lesson/thumb/${lesson.teacherId}${lesson.openAt}/${lesson.thumbnail}"
					alt="클래스 썸네일">
			</div>
			<div class="classroomDiv" id="mainInfo">
				<span>${lesson.categoryName}</span> <span>${lesson.typeName}</span>
				<span>${lesson.levelName}</span>
				<h1>${lesson.title}</h1>
				<h2>${teacher.nickname}</h2>
			</div>
		</header>
		<nav>
			<ul>
				<li><a href="" class="active">강의소개</a></li>
				<li><a href="">강의보기</a></li>
				<li><a href="">공지사항</a></li>
				<li><a href="">질문답변</a></li>
				<li><a href="">작품공유</a></li>
			</ul>
		</nav>
		<div id="intro" class="navTab">
			<div class="divide">
				<div id="classInfo" class="introDIV">
					<h6>강의정보</h6>
					<table>
						<tr>
							<td class="tHead"><i class="xi-book-o"></i>강의과목</td>
							<td>${lesson.categoryName}</td>
						</tr>
						<tr>
							<td class="tHead"><i class="xi-calendar"></i>강의종류</td>
							<td>${lesson.typeName}</td>
						</tr>
						<tr>
							<td class="tHead"><i class="xi-emoticon-happy-o"></i>강의대상</td>
							<td>${lesson.levelName}</td>
						</tr>
						<tr>
							<td class="tHead"><i class="xi-group"></i>수강인원</td>
							<td>${lesson.currentStudent}/${lesson.maxStudent}</td>
						</tr>
					</table>
				</div>
				<div id="teacherInfo" class="introDIV">
					<h6>선생님정보</h6>
					<table>
						<tr>
							<td class="tHead"><i class="xi-school"></i>강사이름</td>
							<td>${teacher.nickname}</td>
						</tr>
						<tr>
							<td class="tHead"><i class="xi-user-address"></i>SNS</td>
							<td><c:choose>
									<c:when test="${teacher.snsType eq 'Instagram'}">
										<i class="xi-instagram"></i>
									</c:when>
									<c:when test="${teacher.snsType eq 'Youtube'}">
										<i class="xi-youtube"></i>
									</c:when>
									<c:when test="${teacher.snsType eq 'Facebook'}">
										<i class="xi-facebook-official"></i>
									</c:when>
								</c:choose> <a href="//${teacher.snsUrl}">${teacher.snsId}</a></td>
						</tr>
						<tr>
							<td class="tHead"><i class="xi-comment-o"></i>강사소개</td>
							<td>${teacher.profile}</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="divide" class="introDIV">
				<div id="timeTable">
					<h6>시간표</h6>
					<div class="calendar">
						<div class="col rightCol">
							<div class="content">
								<h2 class="year"></h2>
								<ul class="months">
									<li><a href="#" class="moveBtn"><i
											class="xi-angle-left-min"></i></a></li>
									<li><a href="#" data-value="1">1월</a></li>
									<li><a href="#" data-value="2">2월</a></li>
									<li><a href="#" data-value="3">3월</a></li>
									<li><a href="#" data-value="4">4월</a></li>
									<li><a href="#" data-value="5">5월</a></li>
									<li><a href="#" data-value="6">6월</a></li>
									<li><a href="#" data-value="7">7월</a></li>
									<li><a href="#" data-value="8">8월</a></li>
									<li><a href="#" data-value="9">9월</a></li>
									<li><a href="#" data-value="10">10월</a></li>
									<li><a href="#" data-value="11">11월</a></li>
									<li><a href="#" data-value="12">12월</a></li>
									<li><a href="#" class="moveBtn"><i
											class="xi-angle-right-min"></i></a></li>
								</ul>

								<div class="clearfix"></div>
								<ul class="weekday">
									<li><a href="#" data-value="1">일</a></li>
									<li><a href="#" data-value="2">월</a></li>
									<li><a href="#" data-value="3">화</a></li>
									<li><a href="#" data-value="4">수</a></li>
									<li><a href="#" data-value="5">목</a></li>
									<li><a href="#" data-value="6">금</a></li>
									<li><a href="#" data-value="7">토</a></li>
								</ul>
								<div class="clearfix"></div>
								<ul class="days" id="calendar-body">
								</ul>
								<div class="clearfix"></div>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
				<div id="curriculum" class="introDIV">
					<h6>커리큘럼</h6>
					<table>
						<c:set var="bigCnt" value="${0}" />
						<c:forEach items="${curriculumList}" var="curriculum">
							<tr class="bigSubject">
								<c:set var="bigCnt" value="${bigCnt + 1}" />
								<td class="tHead">${bigCnt}</td>
								<td>${curriculum.subject}</td>
							</tr>
							<c:set var="smallCnt" value="${0}" />
							<c:forEach items="${curriculum.detailList}" var="detail">
								<tr class="smallSubject">
									<c:set var="smallCnt" value="${smallCnt + 1}" />
									<td class="tHead">${smallCnt}</td>
									<td>${detail.detail}</td>
								</tr>
							</c:forEach>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
		<div id="lecture" class="navTab">
			<div id="stream"></div>
		</div>
		<div id="announce" class="navTab">
			<div class="table-container">
				<table class="content-table" id="table">
					<thead id="table-header">
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>3</td>
							<td class="title"><a class='read'
								href='<c:out value="123"/>'>발표 준비 순서</a></td>
							<td>자바왕</td>
							<td>2020-08-19</td>
						</tr>
						<tr>
							<td>2</td>
							<td class="title"><a class='read'
								href='<c:out value="123"/>'>마지막 수업 안내</a></td>
							<td>자바왕</td>
							<td>2020-08-18</td>
						</tr>
						<tr>
							<td>1</td>
							<td class="title"><a class='read'
								href='<c:out value="123"/>'>대체휴무일 휴강</a></td>
							<td>자바왕</td>
							<td>2020-08-17</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div id="qna" class="navTab">
			<div class="table-container">
				<table class="content-table" id="table">
					<thead id="table-header">
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>3</td>
							<td class="title"><a class='read'
								href='<c:out value="123"/>'>완강하면 취직할 수 있을까용?</a></td>
							<td>백수</td>
							<td>2020-08-19</td>
						</tr>
						<tr>
							<td>2</td>
							<td class="title"><a class='read'
								href='<c:out value="123"/>'>이거 어케 해염?</a></td>
							<td>희지캣</td>
							<td>2020-08-18</td>
						</tr>
						<tr>
							<td>4</td>
							<td class="title"><a class='read'
								href='<c:out value="123"/>'>re:고것도 모르냐</a></td>
							<td>힘숨찐</td>
							<td>2020-08-19</td>
						</tr>
						<tr>
							<td>1</td>
							<td class="title"><a class='read'
								href='<c:out value="123"/>'>대체휴무일 쉬나염?</a></td>
							<td>양아치</td>
							<td>2020-08-14</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<div id="homework" class="navTab">
			<div class="table-container">
				<table class="content-table" id="table">
					<thead id="table-header">
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>4</td>
							<td class="title"><a class='read'
								href='<c:out value="123"/>'>과제 제출합니다~!</a></td>
							<td>힘숨찐</td>
							<td>2020-08-17</td>
						</tr>
						<tr>
							<td>3</td>
							<td class="title"><a class='read'
								href='<c:out value="123"/>'>과제 제출이요</a></td>
							<td>양아치</td>
							<td>2020-08-15</td>
						</tr>
						<tr>
							<td>2</td>
							<td class="title"><a class='read'
								href='<c:out value="123"/>'>과제 제출</a></td>
							<td>구숨찐</td>
							<td>2020-08-14</td>
						</tr>
						<tr>
							<td>1</td>
							<td class="title"><a class='read'
								href='<c:out value="123"/>'>과제 제출해염</a></td>
							<td>희지캣</td>
							<td>2020-08-13</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<c:forEach items="${scheduleList}" var="schedule">
			<input type="hidden" class="schedule" value="${schedule.lessonDate}">
			<input type="hidden" class="start" value="${schedule.startAt}">
			<input type="hidden" class="end" value="${schedule.endAt}">
		</c:forEach>
		<div class="home">
			<a href="/"><i class="xi-home"></i>홈으로<a>
		</div>
	</div>
	<script>
		var currentTitle = document.getElementById('current-year-month');
		var calendarBody = document.getElementById('calendar-body');
		var scheduleList = $(".schedule");
		var startList = $(".start");
		var endList = $(".end");
		var MIN = ($(scheduleList[0]).val().split("-"))[1];
		if (MIN.indexOf(0) == '0') {
			MIN = MIN.replace('0', '');
		}//추후 수정
		var MAX = ($(scheduleList[scheduleList.length - 1]).val().split("-"))[1];
		if (MAX.indexOf(0) == '0') {
			MAX = MAX.replace('0', '');
		}// 추후 수정
		var today = new Date();
		var first = new Date(today.getFullYear(), today.getMonth(), 1);
		var dayList = [ 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday',
				'Friday', 'Saturday' ];
		var monthList = [ 'January', 'February', 'March', 'April', 'May',
				'June', 'July', 'August', 'September', 'October', 'November',
				'December' ];
		var leapYear = [ 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
		var notLeapYear = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
		var pageFirst = first;
		var pageYear;
		if (first.getFullYear() % 4 === 0) {
			pageYear = leapYear;
		} else {
			pageYear = notLeapYear;
		}
		var months = $(".months li");
		var yearH2 = $(".year");
		var moveBtns = $(".moveBtn");
		var prevBtn = $(moveBtns[0]);
		var nextBtn = $(moveBtns[1]);
		var navMenu = $("nav a");
		var navTab = $(".navTab");

		navMenu.on().click(function(e) {
			e.preventDefault();
			navTab.css('display', 'none');
			navMenu.removeClass('active');
			$(this).addClass('active');
			switch (this) {
			case navMenu[0]:
				$(navTab[0]).css('display', 'block');
				break;
			case navMenu[1]:
				self.location = "//192.168.1.57:8888/"
				break;
			case navMenu[2]:
				$(navTab[2]).css('display', 'block');
				break;
			case navMenu[3]:
				$(navTab[3]).css('display', 'block');
				break;
			case navMenu[4]:
				$(navTab[4]).css('display', 'block');
				break;
			}
		})

		function showCalendar() {
			let cnt = 1;
			let str = "";
			for (var j = 0; j < pageYear[first.getMonth()] + first.getDay(); j++) {
				if (j < first.getDay() || cnt > pageYear[first.getMonth()]) {
					str += '<li><a></a></li>';
				} else {
					str += '<li><a href="#" data-value="'+cnt+'">' + cnt
							+ '</a></li>';
					cnt++;
				}
			}

			calendarBody.innerHTML = str;
			$(calendarBody).find("li a").on().click(function(e) {
				e.preventDefault();
			})
			// 해당 년 선택
			yearH2.text(today.getFullYear());
			// 해당 월 선택
			months.find("a").removeClass("selected");
			var todayMonth = first.getMonth() + 1
			for (var i = 0; i < months.length; i++) {
				var month = $(months[i]).find("a");
				if (month.data("value") == todayMonth) {
					month.addClass("selected");
				}
			}

			for (var i = 0; i < scheduleList.length; i++) {
				var schedule = $(scheduleList[i]);
				var startAt = $(startList[i]);
				var endAt = $(endList[i]);
				var scheduleTmp = schedule.val().split("-");
				var scheduleYear = scheduleTmp[0];
				if (today.getFullYear() == scheduleYear) {
					var scheduleMonth = scheduleTmp[1];
					if (((first.getMonth() + 1).length == 1 ? "0"
							+ first.getMonth() + 1 : first.getMonth() + 1) == scheduleMonth) {
						var scheduleDay = scheduleTmp[2];
						if (scheduleDay.indexOf(0) == '0') {
							scheduleDay = scheduleDay.replace('0', '');
						}
						var scheduleDate = $(".days li a[data-value='"
								+ scheduleDay + "']")
						scheduleDate.addClass("selected");
						scheduleDate.attr("title", startAt.val() + "~"
								+ endAt.val());
					}
				}
			}

		}
		showCalendar();

		prevBtn.click(function(e) {
			console.log("클릭");
			e.preventDefault();
			if (first.getMonth() >= MIN) {
				first = new Date(today.getFullYear(), first.getMonth() - 1, 1);
			}
			showCalendar();
		});

		nextBtn.click(function(e) {
			console.log("클릭");
			e.preventDefault();
			if (first.getMonth() + 2 <= MAX) {
				first = new Date(today.getFullYear(), first.getMonth() + 1, 1);
			}
			showCalendar();
		});
	</script>
</body>

</html>