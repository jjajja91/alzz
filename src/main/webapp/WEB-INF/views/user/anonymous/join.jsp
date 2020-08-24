<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="resources/css/common.css" />
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
   crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&family=Open+Sans:wght@300;400;700&display=swap" rel="stylesheet">
<style>

body * {font-family: 'Open Sans', 'Noto Sans KR', sans-serif;}

*{
  margin: 0;
  padding: 0;
  text-decoration: none;
  box-sizing: border-box;
}

body{
  min-height: 100vh;
  background-color: #eee;
}

.login-form{
  width: 360px;
  background: #fff;
  height: 580px;
  padding: 30px 40px;
  border-radius: 10px;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%,-50%);
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
}

.login-form h3{
  color: #335492;
  margin-bottom: 60px;
}

.txtb{
  border-bottom: 2px solid #adadad;
  position: relative;
  margin: 45px 0;
}

.txtb input{
  font-size: 15px;
  color: #333;
  border: none;
  width: 100%;
  outline: none;
  background: none;
  padding: 0 5px;
  height: 40px;
}

.txtb span::before{
  content: attr(data-placeholder);
  position: absolute;
  top: 45%;
  left: 5px;
  color: #adadad;
  transform: translateY(-50%);
  z-index: -1;
  transition: .5s;
}

.txtb span::after{
  content: '';
  position: absolute;
  width: 0%;
  left:0px;
  top:40px;
  height: 2px;
  background-color: #335492;
  transition: .5s;
}

.focus + span::before{
  top: -5px;
}
.focus + span::after{
  width: 100%;
}

#joinSubmit{
  display: block;
  width: 100%;
  height: 50px;
  border: none;
  background: linear-gradient(120deg,#335492,#264785,#335492);
  background-size: 200%;
  color: #fff;
  outline: none;
  cursor: pointer;
  transition: .5s;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.15); 
}

.joinBtns {
	color: white;
	background-color: #335492;
	border: none;
	outline: none;
	padding: 5px;
	margin: 0px;
	position: absolute;
	right: 0%;
	top: -50%;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.15); 
	cursor: pointer;
}

#joinSubmit:hover{
  background-position: right;
}

.bottom-text{
  margin-top: 20px;
  text-align: center;
  font-size: 13px;
}

.bottom-text a{
  text-decoration: none;
  color: #335492;
}


</style>
</head>
<body>
      
      	<form action="/create" method="post" class="login-form" id="joinForm">
        <h3>가입하기</h3>

        <div class="txtb">
          <input type="text" name="email" id="email" autocomplete="off">
          <span data-placeholder="이메일"></span>
          <button id="emailChk" class="joinBtns">이메일 중복 체크</button>
        </div>
        
        <div class="txtb">
          <input type="text" name="nickname" id="nickname" autocomplete="off">
          <span data-placeholder="닉네임"></span>
		  <button id="nicknameChk" class="joinBtns">닉네임 중복 체크</button>
        </div>
        
        <div class="txtb">
          <input type="text" name="phoneNumber" id="phoneNumber" maxlength="11" autocomplete="off">
          <span data-placeholder="핸드폰 번호: -없이 번호만 입력해주세요"></span>
        </div>
        
        <div class="txtb">
          <input type="password" name="password" id="password" autocomplete="off" onkeypress="if (event.keyCode==13) login()">
          <span data-placeholder="비밀번호"></span>
        </div>
		<input type="hidden" name="role" value="ROLE_USER">
        <input type="submit" id="joinSubmit" value="가입"> 

        <div class="bottom-text">
          	계정이 있으신가요? <a href="/login">로그인하기</a><br>
			<a href="/">메인 페이지 이동</a>
        </div>

      </form>
      <input type="hidden" id="emailChkResult" value="false"/>
      <input type="hidden" id="nicknameChkResult" value="false"/>
      
      
      
      
      
      
      <script>
         var $emailChk = $("#emailChk");
         var $nicknameChk = $("#nicknameChk");
         var $email = $("#email");
         var $nickname = $("#nickname");
         var $phoneNumber = $("#phoneNumber");
         var $emailChkResult = $("#emailChkResult");
         var $nicknameChkResult = $("#nicknameChkResult");
         var $phoneNumberChkResult = $("#phoneNumberChkResult");
         var $joinSubmit = $("#joinSubmit");
         var $joinForm = $("#joinForm");
         var emailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
         var phoneNumberReg = /^\d{3}\d{3,4}\d{4}$/;
         
		$(".txtb input").on("focus",function(){
			$(this).addClass("focus");
		});

		$(".txtb input").on("blur",function(){
			if($(this).val() == "")
			$(this).removeClass("focus");
		});
				

         
         $email.change(function(){
            $emailChkResult.val("false");
         });
         
         $nickname.change(function(){
            $nicknameChkResult.val("false");
         });
         
         $phoneNumber.change(function(){
            $phoneNumberChkResult.val("false");
         });
         
         $emailChk.click(function(e){
            e.preventDefault();
            if($email.val()==null || $email.val().trim()==""){
               alert("이메일이 비어있습니다");
            } else if($email.val().length > 30) {
               alert("이메일을 30자 이내로 적어주세요");
            } else if(!(emailReg.test($email.val()))) {
               alert("이메일의 형식을 지켜주세요");
            } else {
               var data = {
                  email : $email.val()
               };
            emailChk(data)
            .then(function(response){
               console.log(response);
               if(response){
                  alert("중복된 이메일이 있습니다");
               } else {
                  alert("사용 가능한 이메일입니다");
                  $emailChkResult.val("true");
               }
            })
            .catch(function(error){
               console.log(error);
            });
            }
         });
         
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
               if(response){
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
         
        /*  $phoneNumberChk.click(function(e){
             e.preventDefault();
             if($phoneNumber.val()==null || $phoneNumber.val().trim()==""){
                alert("전화번호가 비어있습니다");
             } else if($phoneNumber.val().length > 11) {
                alert("전화번호를 11자 이내로 적어주세요");
             } else if(!(phoneNumberReg.test($phoneNumber.val()))) {
                alert("전화번호의 형식을 지켜주세요");
             } else {
                var data = {
                   phoneNumber : $phoneNumber.val()
                };
             phoneNumberChk(data)
             .then(function(response){
                console.log(response);
                if(response.phoneNumber==$phoneNumber.val()){
                   alert("중복된 전화번호가 있습니다");
                } else {
                   alert("사용 가능한 전화번호입니다");
                   $phoneNumberChkResult.val("true");
                }
             })
             .catch(function(error){
                console.log(error);
             });
             }
          }); */
         
         function emailChk(data){
            return $.ajax({
               url: 'users/emailChk',
               type: 'POST',
                data: JSON.stringify(data),
               contentType : "application/json; charset=utf-8"
            });
         };
         
         function nicknameChk(){
            return $.ajax({
               url: 'users/nicknameChk/'+$nickname.val(),
               type: 'GET',
               contentType : "application/json; charset=utf-8"
            });
         };

        /*  function phoneNumberChk(data){
            return $.ajax({
               url: 'users/phoneNumberChk',
               type: 'POST',
                data: JSON.stringify(data),
               contentType : "application/json; charset=utf-8"
            });
         }; */
         
         $joinSubmit.click(function(e){
            e.preventDefault();
            if($email.val()==null || $email.val().trim()==""){
               alert("이메일이 비어있습니다");
            } else if($email.val().length > 30) {
               alert("이메일을 30자 이내로 적어주세요");
            } else if(!(emailReg.test($email.val()))) {
               alert("이메일의 형식을 지켜주세요");
            } else if($nickname.val()==null || $nickname.val().trim()==""){
               alert("닉네임이 비어있습니다");
            } else if($nickname.val().length > 16) {
               alert("닉네임을 16자 이내로 적어주세요");
            /* } else if($password.val()==null || $password.val().trim()==""){
               alert("비밀번호가 비어있습니다"); */
            /* } else if($password.val().length > 16) {
               alert("비밀번호를 16자 이내로 적어주세요"); */
            } else if($phoneNumber.val()==null || $phoneNumber.val().trim()==""){
               alert("전화번호가 비어있습니다");
            } else if($phoneNumber.val().length > 11) {
               alert("전화번호를 11자 이내로 적어주세요");
            } else if(!(phoneNumberReg.test($phoneNumber.val()))) {
               alert("전화번호의 형식을 지켜주세요");
            } else if($emailChkResult.val()=="false"){
               alert("이메일 중복체크를 해주세요");
            } else if ($nicknameChkResult.val()=="false"){
               alert("닉네임 중복체크를 해주세요");
            } 
/*             else if($phoneNumberChkResult.val()=="false"){
               alert("전화번호 중복체크를 해주세요");
            }  */
            else {
               joinForm.submit();
            }
         })   
      </script>
</body>
</html>