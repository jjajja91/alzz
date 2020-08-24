<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원등록 페이지</title>
<!-- jstl 코어 태그 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- jstl 시간 출력 태그 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- context 경로 -->
<c:set var="path" value="${pageContext.request.contextPath}"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	$("#btnManager").click(function(){
		// 확인 대화상자	
		if(confirm("관리자 계정을 등록하시겠습니까?")){
			document.form.action = "${path}/admin/insertManager";
			document.form.submit();
		}
	});
});
$(document).ready(function(){
	$("#btnUser").click(function(){
		// 확인 대화상자	
		if(confirm("일반회원 계정을 등록하시겠습니까?")){
			document.form.action = "${path}/admin/insertUser";
			document.form.submit();
		}
	});
});
$(function() {
	$("#adminHomeBtn").click(function() {
		location.href = '/admin/index';
	})
})
</script>
</head>
<body>
	<h2>회원등록폼</h2>
	<form name="form" method="post">
		<h3>계정 등록</h3>
		<table border="1" width="400px">
			<tr>
				<td>이메일</td>
				<td><input name="email"></td>
			</tr>
			<tr>
				<td>닉네임</td>
				<td>
					<input type="text"  id="nickname" name="nickname" value="${principal.nickname}">
					<input type="hidden" id="originNickname" value="${principal.nickname}">
					<input type="hidden" id="originPhone" value="${principal.phoneNumber}">
					<input type="hidden" id="description" name="description" value="">
					<button id="nicknameChk">닉네임 중복확인</button>
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="password"></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input name="phoneNumber"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="관리자" id="btnManager">
					<input type="button" value="일반" id="btnUser">
					<input type="reset" value="취소"><br><br>
					<br><button type="button" id=adminHomeBtn class="btn btn-primary btn-sm">관리자 홈으로</button><br><br>
				</td>
			</tr>
		</table>
	</form>
	<script type="text/javascript">
		$(document).ready(function() {
			var $id = $("#id");
			var $email = $("#email");
	  		var $password = $("#password");
	  		var $nickname = $("#nickname");
	  		var $phoneNumber = $("#phoneNumber");
	  		var $nicknameChk = $("#nicknameChk");
	  		var $description = $("#description");
	  		var $originNickname = $("#originNickname");
	  		var $originPhone = $("#originPhone");
	  	  var $nicknameChkResult = $("#nicknameChkResult");
	  	 $nickname.change(function(){
	            $nicknameChkResult.val("false");
	         });
	
		//정보 수정 함수
			function UserUpdateApi(data) {
				console.log(data);
					  return $.ajax({
		  		    url: "/users/",
		  		    type: "PUT",
		  		    data: JSON.stringify(data),
		  		    contentType: "application/json",
		  		  });
		  		}
			var formObj = $("form[role='form']");
		
			$('button[type=submit]').on("click", function(e) {
				e.preventDefault();
				var operation = $(this).data("oper");
				console.log(operation);
		  		var data = {
		  				email: $email.val(),
						nickname: $nickname.val(),
						password : $password.val(),
						phoneNumber :$phoneNumber.val(),
						description : $originNickname.val()+"/"+$nickname.val()+"/"+$originPhone.val()+"/"+$phoneNumber.val(),
						};
				 if(operation === 'update') {			
					UserUpdateApi(data) 
					.then(function(response){
						console.log(data);
						
					   self.location = "/callMypage";
					   alert("수정 완료!");
					})			
				} 
				 else if(operation === 'cancle'){
					 alert()
				 } 
			 
		});
			   
	         function nicknameChk(){
	            return $.ajax({
	               url: 'users/nicknameChk/'+$nickname.val(),
	               type: 'GET',
	               contentType : "application/json; charset=utf-8"
	            });
	         };
			
	         
	         $nicknameChk.click(function(e){
	            e.preventDefault();
	           if($nickname.val()==null || $nickname.val().trim()==""){
	               alert("닉네임이 비어있습니다");
	            } else if($nickname.val().length > 16) {
	               alert("닉네임을 16자 이내로 적어주세요");
	            } else {
	            nicknameChk()
	            .then(function(response){
	               console.log(response);
	               if($nickname.val()==$originNickname.val()){
	            	   alert("사용 가능한 닉네임입니다");
	            	   $nicknameChkResult.val("true");
	               } else if(response==true){
	                  alert("중복된 닉네임이 있습니다");
	               } else {
	                  alert("사용 가능한 닉네임입니다");
	                  $nicknameChkResult.val("true");
	               }
	            })
	            .catch(function(error){
	               console.log(error);
	            });
	            } 
	            });
		});
		</script>
</body>
</html> --%>