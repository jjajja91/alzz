<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%-- <%@include file="../includes/header.jsp"%> --%>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
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
	font-size: 14px;
	color: #585858;
    line-height: 30px;
    margin-top: 20px;
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
    right: 57%;
}
.lessonForm button[name="next"] {
    right: 51%;
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
	width: 130px;
}

.startAt, .endAt {
	width: 100px;
}

ul {
	list-style: none;
	padding-left: 20px;
}

.subject, .detail {
	width: 600px;
}

input[name="addDetail"] {
    background: #335492;
    color: white;
    height: 30px;
    width: 30px;
    border-radius: 3px;
    border: none;
    margin-top: 5px;
}

.deleteDetail {
    background: coral;
    color: white;
    height: 30px;
    width: 30px;
    border-radius: 3px;
    border: none;
    margin-top: 5px;
}

.deleteSubject {
    background: orangered;
    color: white;
    height: 30px;
    width: 30px;
    border-radius: 3px;
    border: none;
    margin-top: 5px;
}

input[name="addSubject"] {
    background: #335492;
    color: white;
    height: 30px;
    width: 80px;
    border-radius: 3px;
    border: none;
    margin-top: 5px;
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
    right: 27%;
    background: lightgrey;
}
.lessonForm button[name="save"] {
    right: 21%;
}
.lessonForm button[name="submit"] {
    right: 15%;
    background: midnightblue;
}
</style>
<body>

	<div class="lessonHeaderDiv">
		<span class="lessonHeaderLeft">클래스 등록 > 5. 커리큘럼 등록</span>
		<span class="lessonHeaderRight"><a href="/">HOME</a></span>
	</div>
	<div class="container">
		<div class="titleDiv">
			<span class="pageTitle">커리큘럼</span>(5/5)

		</div>
	
		<input type="hidden" name="originalId" value='<c:out value="${param.originalId }"/>' readonly>
		<br>
		<div class="lessonText">클래스를 신청하신 분들이 배우고 있는 커리큘럼입니다.<br> 주제와 그에 따른 소주제를 작성해 주세요.</div>
		
		<div class="parentDiv">
			<c:if test="${empty newCurriculum}" >
				<c:forEach items='${originCurriculum}' var='list' varStatus="subjectLoop">
					<ul>
						<li class="subjectLi">
						<br>
							<label for="subject">주제</label>
							<input type="text" class="form-control subject" name="subject" value='<c:out value="${list.subject }"/>'> 
							 
							<c:if test="${subjectLoop.index != 0}" >
								<input type="button" class="deleteSubject" name="delete" value="-">
							</c:if>
							
							<input type="button" class="addDetail" name="addDetail" value="+" />
							
							<c:forEach items='${list.detailList}' var='detail' varStatus="detailLoop">
								<ul>
									<li class="detailLi">
										<label for="detail">소주제</label>
										<input type="text" class="form-control detail" name="detail" value='<c:out value="${detail.detail }"/>'>
										
										<c:if test="${subjectLoop.index>0 || detailLoop.index>0}" >	
											<input type="button" class="deleteDetail" name="delete" value="-">
										</c:if>
									</li>
								</ul>
							</c:forEach>
						</li>
					</ul>
				</c:forEach>
			</c:if>
			
			<c:if test="${!empty newCurriculum}" >
				<c:forEach items='${newCurriculum}' var='list' varStatus="subjectLoop">
					<ul>
						<li class="subjectLi">
							<label for="subject">주제</label>
							<input type="text" class="form-control subject" name="subject" value='<c:out value="${list.subject }"/>'> 
							
							<c:if test="${subjectLoop.index != 0}" >
								<input type="button" class="deleteSubject" name="delete" value="-">
							</c:if>
							
							<input type="button" class="addDetail" name="addDetail" value="+" />
							
							<c:forEach items='${list.detailList}' var='detail' varStatus="detailLoop">
								<ul>
									<li class="detailLi">
										<label for="detail">소주제</label>
										<input type="text" class="form-control detail" name="detail" value='<c:out value="${detail.detail }"/>'>
										
										<c:if test="${subjectLoop.index>0 || detailLoop.index>0}" >	
											<input type="button" class="deleteDetail" name="delete" value="-">
										</c:if>
									</li>
								</ul>
							</c:forEach>
						</li>
					</ul>
				</c:forEach>
			</c:if>
			
			<c:if test="${empty newCurriculum}" >
				<c:if test="${empty originCurriculum}" >
					<ul>
						<li class="subjectLi">
							<label for="subject">주제</label>
							<input type="text" class="form-control subject" name="subject" > 
							
							<input type="button" class="addDetail" name="addDetail" value="+" />
						
							<ul>
								<li class="detailLi">
									<label for="detail">소주제</label>
									<input type="text" class="form-control detail" name="detail">
								</li>
							</ul>
						</li>
					</ul>
				</c:if>
			</c:if>
		</div>
		<input type="button" name="addSubject" value="주제 추가"/>
		<br><br><br>
		<form class="lessonForm" role="form" id="submitForm" action="/lesson/registerSubmit" method="post">
			<input type="hidden" name="lessonId" value='<c:out value="${param.lessonId }"/>' readonly>
			<button type="button" name="prev">이전</button>
			<button type="button" name="save">저장</button>
			<button type="submit" name="submit">제출</button>
		</form>
		<br> <br>
	</div>
<script>

	var formObj;
	var $subjectLi;
	var $detailLi;
	var $addSubjectBtn;
	var $addDetailBtn;
	var $subject;
	var $detail;
	var $lessonId;
	
	$(document).ready(function(){
		$addSubjectBtn = $("input[name=addSubject]");
		$addDetailBtn = $("input[name=addDetail]");
		$lessonId = $("input[name=lessonId]");
		
	});
	
	// 버튼이벤트
	$("button[type=button]").click(function(e) {

		e.preventDefault();
		formObj = $("form[role='form']");

		var location = $(this).attr("name");
		var curriculumList = [];

		
		// 커리큘럼 목록 배열
		$('.subjectLi').each(function() { 
			var curriculumObj = {
					lessonId : $lessonId.val(),
					subject : $(this).find('input[name=subject]').val(),
			    	detailList : []
			}
			
			$(this).find('.detailLi input[name=detail]').each(function(){
				//$(this).val()
			    var detailObj = {
						lessonId : $lessonId.val(),
			    		detail: $(this).val()
			    }
			    curriculumObj.detailList.push(detailObj)
			})
			curriculumList.push(curriculumObj);
		});
		
		if(curriculumList[0].subject!=null) {
			insertCurriculum(curriculumList, location)
				.then(function(response) {
					if (response==='prev') {
			    		self.location = "/lesson/registerDetail?lessonId="+$lessonId.val();
			    	} else if(response==='save') {
			    		alert("저장되었습니다!");
			    	}
				})
		} 
		
		if (location=='prev') {
			self.location = "/lesson/registerDetail?lessonId="+$lessonId.val();
		}
		
	});
	
	function insertCurriculum(curriculumList, location) {
		
		return $.ajax({
					type : 'POST',
					url : '/lessons/curriculum/'+location,
					contentType : "application/json; charset=utf-8",
			        data: JSON.stringify(curriculumList)
			});
	}
		
	// 주제 추가 버튼 눌렀을때 이벤트
	$(document).on("click","input[name='addSubject']",function(e){
		
		e.preventDefault();

		var parentDiv = $(".parentDiv");
		let parentUl = document.createElement("ul");
		
		var subjectLi = document.createElement("li");
		subjectLi.setAttribute("class", "subjectLi");
					
		var subjectLable = document.createElement("lable");
		subjectLable.setAttribute("for", "subject");
		subjectLable.innerText = "주제";
		
		var subjectInput = document.createElement("input");
		subjectInput.setAttribute("type", "text");
		subjectInput.setAttribute("class", "form-control subject");
		subjectInput.setAttribute("name", "subject");

		var deleteBtn = document.createElement("input");
		deleteBtn.setAttribute("type", "button");
		deleteBtn.setAttribute("class", "deleteSubject");
		deleteBtn.setAttribute("name", "delete");
		deleteBtn.setAttribute("value", "-");
		
		var addDetailBtn = document.createElement("input");
		addDetailBtn.setAttribute("type", "button");
		addDetailBtn.setAttribute("name", "addDetail");
		addDetailBtn.setAttribute("value", "+");

		subjectLi.appendChild(subjectLable);
		subjectLi.appendChild(subjectInput);
		subjectLi.appendChild(deleteBtn);
		subjectLi.appendChild(addDetailBtn);
		parentUl.appendChild(subjectLi);
		parentDiv[0].appendChild(parentUl);
	});
	
	// 소주제 추가 버튼 눌렀을때 이벤트
	$(document).on("click","input[name='addDetail']",function(e){
		
		e.preventDefault();

		var parent = e.target.parentNode;
		
		let parentUl = document.createElement("ul");
		
		var detailLi = document.createElement("li");
		detailLi.setAttribute("class", "detailLi");
					
		var detailLable = document.createElement("lable");
		detailLable.setAttribute("for", "detail");
		detailLable.innerText = "소주제";
		
		var detailInput = document.createElement("input");
		detailInput.setAttribute("type", "text");
		detailInput.setAttribute("class", "form-control detail");
		detailInput.setAttribute("name", "detail");

		var deleteBtn = document.createElement("input");
		deleteBtn.setAttribute("type", "button");
		deleteBtn.setAttribute("class", "deleteDetail");
		deleteBtn.setAttribute("name", "delete");
		deleteBtn.setAttribute("value", "-");

		detailLi.appendChild(detailLable);
		detailLi.appendChild(detailInput);
		detailLi.appendChild(deleteBtn);
		parentUl.appendChild(detailLi);
		parent.appendChild(parentUl);
	});
	
	// 삭제버튼 이벤트
	$(document).on("click","input[name='delete']",function(e){
		
		if(e.target.className=="deleteSubject") {
			e.target.parentNode.parentNode.remove();
		} else {
			e.target.parentNode.remove();
		}
	});
	
	function goBack() {
		window.history.back();
	}

    
</script>
</body>
</html>