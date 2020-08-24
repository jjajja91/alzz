<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">

</head>
<style>

.container {

	margin-top: 70px;
	margin-left: 10%;
	min-height: 100%;
	position: relative;
}

body {
	margin: 0px;
}

.lessonHeaderDiv {
	width:100%;
	height:30px;
	margin: 0px;
	padding-top: 10px;
	border-bottom: solid 1px;
    position: fixed;
    top: 0px;
    background-color: white;
    z-index: 1;
}

.lessonHeaderLeft {
	padding-left: 2%;
}
.lessonHeaderRight {
    position: absolute;
    right: 20;
}
.pageTitle {
    font-size: 30px;
    font-weight: 600;
    padding-right:10px;
    color: #335492;
    
}

.lessonText {
	color: black;
	font-weight: bold;
	font-size: 20px;
    margin-bottom: 20px;
}

.lessonForm {
	font-size: 16px;
	color: black;
    line-height: 30px;
    margin-top: 20px;
    font-weight: 600;
}

.lessonForm button {
    position: absolute;
    right: 55%;
    background: #335492;
    color: white;
    height: 35px;
    width: 70px;
    border-radius: 3px;
    border: none;
    font-weight: bold;
}

.lessonForm button[name="prev"] {
    right: 21%;
}
.lessonForm button[name="next"] {
    right: 15%;
}

.form-control {
	width:80%;
	height: 30px;
	padding: 5px;
    margin: 5px;
}

#nickname {
	width: 30%;
}

.teacherTextarea {
	height: 200px;
}

.titleDiv {
	border-bottom: solid;
    border-color: #335492;
    padding-bottom: 15px;
    width: 85%;
}

.lessonList {
	width: 70%;
}

.mainCategoryList, .subCategoryList{
	width:220px;
}
.lessonMainImgDiv {
	display: flex;
    margin-bottom: 30px;
}
.lessonMainImgLeftDiv {
    display: table-cell;
    border: solid #335492;
    border-style: dashed;
    border-radius: 5px;
    text-align: center;
    height: 200px;
    vertical-align: middle;
}
.lessonMainImgRightDiv {
    width: 50%;
    padding: 15px;
}

.lessonTitleInput {
	width:100%;
}
.studentAmount {
	width:10%;
}

.dateInput, .lessonDate {
	width: 140px;
}

.startAt, .endAt {
	width: 120px;
}

input[type="button"] {
    position: absolute;
    background: #335492;
    color: white;
    height: 30px;
    width: 80px;
    border-radius: 3px;
    border: none;
    margin-top: 5px;
}

input[name="deleteLesson"] {
	background: tomato;
	width: 30px;
}
</style>
<body>
	<div class="lessonHeaderDiv">
		<span class="lessonHeaderLeft">클래스 등록 > 3. 스케줄 등록</span>
		<span class="lessonHeaderRight"><a href="/">HOME</a></span>
	</div>
	<div class="container">
		<div class="titleDiv">
			<span class="pageTitle">스케줄</span>(3/5)
		</div>
		<form class="lessonForm" role="form" action="/lesson/registerDetail" method="get">
			<input type="hidden" name="lessonId" value='<c:out value="${param.lessonId }"/>' readonly> 
			<input type="hidden" name="originalId" value='<c:out value="${param.originalId }"/>' readonly>


			<%--<div class="lessonText">수업 날짜와 수업 시간을 입력해주세요.</div>
			
			<label>스케줄 선택</label> 
			<br>
			 <small>클래스 시작일과 종료일을 입력해주세요.</small>
			<br>
			<input type="date" class="form-control dateInput" id="openAt" name="openAt" value='<c:out value="${schedule.openAt }"/>'> ~ 
			<input type="date" class="form-control dateInput" id="closeAt" name="closeAt" value='<c:out value="${schedule.closeAt }"/>'>
			<br> <br> --%>
			<div class="lessonText">추가 버튼을 눌러<br> 세부 날짜와 시간을 입력해주세요.</div>
			<div>
				<c:if test="${empty schedule.timeTable}">
					<div id="timesetDiv">
						<label for="lessonDate">날짜 </label> 
						<input type="date" class="form-control lessonDate" name="lessonDate"> 
						
						<label for="startAt">시작시간 </label> 
						<input type="time" class="form-control startAt" name="startAt"> ~
						<label for="endAt">종료시간 </label> 
						<input type="time" class="form-control endAt" name="endAt">
					</div>
				</c:if>

				<c:forEach items='${schedule.timeTable}' var='timeList' varStatus="loop">
					<div id="timesetDiv">
						<label for="lessonDate">날짜 </label> 
						<input type="date" class="form-control lessonDate" name="lessonDate" value='<c:out value="${timeList.lessonDate }"/>'> 
						
						<label for="startAt">시작시간 </label> 
						<input type="time" class="form-control startAt" name="startAt" value='<c:out value="${timeList.startAt }"/>'> ~
						<label for="endAt">종료시간 </label> 
						<input type="time" class="form-control endAt" name="endAt" value='<c:out value="${timeList.endAt }"/>'>

                  <c:if test="${loop.index != 0}">
                     <input type="button" class="deleteLesson" name="deleteLesson" value="-">
                  </c:if>
               </div>
            </c:forEach>
         </div>
         <br>
         <input type="button" id="addLesson" name="addLesson" value="시간 추가" />
         <br> <br> <br>
         <button type="submit" name="prev">＜ 이전</button>
         <button type="submit" name="next">다음 ＞</button>
         <br> <br> <br>
      </form>
   </div>

	<script>
		var formObj;
		var timesetDiv;
		var $addBtn;
		var $openAt;
		var $closeAt;
		var $startAt;
		var $endAt;
		var $lessonDate;
		var $lessonId;
		var $originalId;

		$(document).ready(function() {
			formObj = $("form[role='form']");
			$addBtn = $("input[name=addLesson]");
			$lessonId = $("input[name=lessonId]");
			$originalId = $("input[name=originalId]");

		});

		// 다음 클릭시 지우고 저장
		$("button[type=submit]") .click( function(e) {

			var name = $(this).attr("name");

			$openAt = $("#openAt");
			$closeAt = $("#closeAt");
			$lessonDate = $(".lessonDate");
			$startAt = $(".startAt");
			$endAt = $(".endAt");

			if (name === 'prev') {

				e.preventDefault();

				if ($originalId.val() != "") {
					self.location = "/lesson/registerBasic?lessonId="
							+ $lessonId.val()
							+ "&originalId="
							+ $originalId.val();
				} else {
					self.location = "/lesson/registerBasic?lessonId="
							+ $lessonId.val();
				}

			} else {

				let timeTable = [];
				for (let i = 0; i < $startAt.length; i++) {
					let timeTablevalues = {
						timeTableId : $lessonId.val(),
						lessonDate : $lessonDate[i].value,
						startAt : $startAt[i].value,
						endAt : $endAt[i].value
					};
					timeTable.push(timeTablevalues);
				}

				let timeList = {};
				timeList["lessonId"] = $lessonId.val();
				timeList["openAt"] = $openAt.val();
				timeList["closeAt"] = $closeAt.val();
				timeList["timeTable"] = timeTable;

				$.ajax({
					type : 'POST',
					url : '/lessons/schedule',
					data : JSON.stringify(timeList),
					contentType : "application/json; charset=utf-8",
					success : function(data) {
						console.log("SUCESS: ", data);
						if ($originalId.val() != null) {
							self.location = "/lesson/registerDetail?lessonId="
									+ $lessonId.val()
									+ "&originalId="
									+ $originalId.val();
						} else {
							self.location = "/lesson/registerDetail?lessonId="
									+ $lessonId.val();
						}
					}
				});
			}

		});

		// 추가 버튼 클릭시 한칸씩 생기는 이벤트
		$(document).on("click", "input[name='addLesson']", function(e) {

			e.preventDefault();

			timesetDiv = document.getElementById("timesetDiv");

			var i = 0;
			var clone = timesetDiv.cloneNode(true); // "deep" clone
			clone.id = "duplicater" + ++i;

			clone.getElementsByTagName("input").lessonDate.value = "";
			clone.getElementsByTagName("input").startAt.value = "";
			clone.getElementsByTagName("input").endAt.value = "";

			var deleteBtn = document.createElement("input");
			deleteBtn.setAttribute("type", "button");
			deleteBtn.setAttribute("name", "deleteLesson");
			deleteBtn.setAttribute("value", "-");

         clone.appendChild(deleteBtn);
         timesetDiv.parentNode.appendChild(clone);
      });

      $(document).on("click", "input[name='deleteLesson']", function(e) {
         e.target.parentNode.remove();
      });
   </script>
</body>
</html>