<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%-- <%@include file="../includes/header.jsp"%> --%>

<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
</head>
<style>

body {
	margin: 0px;
}

.container {
	margin-top: 70px;
	margin-left: 10%;
	min-height: 100%;
	position: relative;
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
	background-color: white;
}
.lessonHeaderRight {
    position: absolute;
    right: 20;
    background-color: white;
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
    right: 15%;
    background: #335492;
    color: white;
    height: 35px;
    width: 70px;
    border-radius: 3px;
    border: none;
    font-weight: bold;
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
</style>
<body>
	<nav class="lessonHeaderDiv">
		<span class="lessonHeaderLeft">클래스 등록 > 1. 강사등록 </span>
		<span class="lessonHeaderRight"><a href="/">HOME</a></span>
	</nav>
	<div class="container">

		<div class="titleDiv">
			<span class="pageTitle">강사소개</span>(1/5)
		</div>
		<form class="lessonForm" role="form" action="/lesson/registerTeacher" method="post">
			<input type="hidden" name="originalId" value='<c:out value="${param.originalId }"/>' readonly> 
			<input type="hidden" name="userId" value='<sec:authentication property="principal.id"/>' readonly>
			<input type="hidden" name="id" value='<c:out value="${teacher.id }"/>' readonly>
				
			<div class="lessonText">본인을 소개하고<br>활동중인 SNS 채널을 알려주세요</div>
			

			<div class="lessonTeacherDiv">
				<label>닉네임</label> 
				<input class="form-control" id='nickname' name='nickname' value='<c:out value="${teacher.nickname }"/>'> 
				<br>
				<small>(최대 15자)</small> 
				<br> <br>
				<label>활동적인 SNS 채널</label>
				<br> 
				<select class="form-control" name="snsType" id="snsType">
					<option value="Instagram" <c:if test="${teacher.snsType eq 'Instagram'}"> selected="selected" </c:if>>Instagram</option>
					<option value="Youtube" <c:if test="${teacher.snsType eq 'Youtube'}"> selected="selected" </c:if>>Youtube</option>
					<option value="Facebook" <c:if test="${teacher.snsType eq 'Facebook'}"> selected="selected" </c:if>>Facebook</option>
				</select> 
				<br> 
				<input type="text" class="form-control" placeholder="채널 아이디를 입력해주세요 (@제외)" name="snsId" value='<c:out value="${teacher.snsId }"/>'> 
				<br> 
				<input type="text" class="form-control" placeholder="URL주소를 입력해주세요." name="snsUrl" value='<c:out value="${teacher.snsUrl }"/>'>

				<br>
				<br> 
				<label>강사 소개</label>
				<br> 
				<textarea class="form-control teacherTextarea" placeholder="강사님이 어떤 분인지 소개해주세요" name="profile"><c:out value="${teacher.profile }" /></textarea>
			</div>


			<br>
			<br>
			<br>
			<button type="submit">다음</button>
			<br>
			<br>
		</form>

	</div>

</body>
</html>