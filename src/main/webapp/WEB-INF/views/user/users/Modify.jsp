<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@include file="../../includes/header.jsp"%>
<%@include file="../../includes/myPageNav.jsp"%>
<style>
.container {
	margin-top: 200px;
	margin-left: 25%;
	min-height: 100%;
	position: relative;
}

.table-container {
	position: absolute;
	top: 35px;
	left: 15%;
}
.page-header {
	font-weight: bold;
	font-size: 24px;
	margin-bottom: 50px;
}

td.tdKey {
	font-weight: bold;
	font-size: 18px;
	padding: 10px 0;
	vertical-align: middle;
}

td.tdVal {
	vertical-align: middle;
	padding-left: 50px;
}

tr.trLine {
	border-bottom: 1px solid #dddddd;
}

input {
	border: 1px solid #335492;
	width: 250px;
	height: 30px;
	margin: 10px 0;
}

button {
	border-radius: 5px 5px;
	border: 1px solid #dddddd;
	font-size: 18px;
	padding: 0 5px;
	width: 50px;
}

button.btn-danger {
	background-color: Tomato;
	color: #ffffff;
}

button.btn-default, nicknameChk {
	background-color: #335492;
	color: #ffffff;
}

button#nicknameChk {
	width: 150px;
    margin-left: 15px;
    vertical-align: middle;
}
</style>




<div class="container">
	<sec:authentication var="principal" property="principal" />

	<div class="table-container">
		<h1 class="page-header">개인 정보 수정</h1>
		<form role='form' action="/users/Modify" method="post">
			<table>
				<tr class="trLine">
					<td class="tdKey">이메일</td>
					<td class="tdVal"><input type="text" id="email" name="email"
						value="${principal.username}" readonly="readonly"></td>
				</tr>
				<tr class="trLine">
					<td class="tdKey">닉네임</td>
					<td class="tdVal"><input type="text" id="nickname" name="nickname"
						value="${principal.nickname}"> <input type="hidden"
						id="originNickname" value="${principal.nickname}"> <input
						type="hidden" id="originPhone" value="${principal.phoneNumber}">
						<input type="hidden" id="description" name="description" value="">
						<button id="nicknameChk">닉네임 중복확인</button></td>

				</tr>
				<tr class="trLine">
					<td class="tdKey">비밀번호</td>
					<td class="tdVal"><input type="password" id="password" name="password"
						value=""></td>
				</tr>
				<tr class="trLine">
					<td class="tdKey">핸드폰번호</td>
					<td class="tdVal"><input type="text" id="phoneNumber" name="phoneNumber"
						value="${principal.phoneNumber}"> <!-- <button>실명인증</button> -->
					</td>
				</tr>
				<%-- <tr>
					<td>PW확인</td>
					<td>
						<input type="text" name="memberPwChk" value="${sessionMember.memberPwChk}">
					</td>
				</tr> --%>
				<tr>
					<td colspan="2" align="center" style="padding-top: 25px;">
						<button type="submit" data-oper='update' class="btn btn-default">수정</button>
						<button type="submit" data-oper='cancle' class="btn btn-danger">취소</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>




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
		  		    url: "/users",
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
						
					   self.location = "/logout";
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
</html>

