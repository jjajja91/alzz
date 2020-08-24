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
  background-color: #1e222b;
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
}

.login-form h1{
  text-align: center;
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
  background-color: #1e222b;
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
  background: linear-gradient(120deg,#1e222b,#8e44ad,#1e222b);
  background-size: 200%;
  color: #fff;
  outline: none;
  cursor: pointer;
  transition: .5s;
}

.joinBtns {
	color: #1e222b;
	background-color: white;
	border: none;
	outline: none;
	padding: 5px;
	margin: 0px;
	position: absolute;
	right: 0%;
	top: -50%;
	box-shadow: 0 0 5px rgba(30, 34, 43, 1);
	cursor: pointer
}

#joinSubmit:hover{
  background-position: right;
}

.bottom-text{
  margin-top: 20px;
  text-align: center;
  font-size: 13px;
}
</style>
</head>
<body>
      
      <form action="/create" method="post" class="login-form" id="joinForm">
        <h3>소셜 가입하기</h3>

        <div class="txtb">
          <input type="text" name="email" id="email" autocomplete="off" value="${email}" readonly>
          <span data-placeholder="이메일"></span>
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

      	<input name="password" type="hidden" value="${id}" readonly>
        <input name="role" type="hidden" value="${role}" readonly>
        <input type="submit" id="joinSubmit" value="가입"> 

        <div class="bottom-text">
          	계정이 있으신가요? <a href="/login">로그인하기</a><br>
			<a href="/">메인 페이지 이동</a>
        </div>

      </form>
      <input type="hidden" id="nicknameChkResult" value="false"/>
      
      <script>
         var $nicknameChk = $("#nicknameChk");
         var $nickname = $("#nickname");
         var $nicknameChkResult = $("#nicknameChkResult");
         var $joinSubmit = $("#joinSubmit");
         var $joinForm = $("#joinForm");
         
         
 		$(".txtb input").on("focus",function(){
 			$(this).addClass("focus");
 		});

 		$(".txtb input").on("blur",function(){
 			if($(this).val() == "")
 			$(this).removeClass("focus");
 		});
         
         $nickname.change(function(){
            $nicknameChkResult.val("false");
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
               if(response==true){
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
         
         
         function nicknameChk(){
            return $.ajax({
               url: 'users/nicknameChk/'+$nickname.val(),
               type: 'GET',
               contentType : "application/json; charset=utf-8"
            });
         };
         
         $joinSubmit.click(function(e){
            e.preventDefault();
            if($nickname.val()==null || $nickname.val().trim()==""){
               alert("닉네임이 비어있습니다");
            } else if($nickname.val().length > 16) {
               alert("닉네임을 16자 이내로 적어주세요");
            } else if ($nicknameChkResult.val()=="false"){
               alert("닉네임 중복체크를 해주세요");
            } else {
               joinForm.submit();
            }
         })
         
      </script>
</body>
</html>