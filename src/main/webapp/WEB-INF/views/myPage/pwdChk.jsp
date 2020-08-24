<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<%@include file="../includes/myPageNav.jsp"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.container {
	margin-top: 350px;
	min-height: 100%;
	position: relative;
	text-align: center;
}
p, label, input, button {
	font-size: 24px;
	margin: 10px 5px;
}
button {
	background-color: #335492;
	color: #ffffff;
	border-radius: 5px 5px;
	border: 1px solid #dddddd;
	font-size: 20px;
	padding: 6px 12px;
	cursor: pointer;
}
</style>
<body>
	<div class="container">
		<c:if test="${param.verify eq 'no'}">
			<input type="hidden" name="verify"
				value='<c:out value="${param.verify}"/>'>
			<p>일치하지 않는 정보입니다.</p>
		</c:if>
		<form role="form" action="/myPage/modifyAcc" method="post">
			<p>소중한 개인정보 보호를 위해 비밀 번호를 입력하여 주세요.</p>
			<br>
			<label for="password">비밀번호</label> 
			<input type="password" name="password" autocomplete="off" placeholder="password"> 
			<input type="hidden" name="id" value='<sec:authentication property="principal.id"/>'>
			<button type=submit>확인</button>

		</form>

	</div>
</body>
</html>