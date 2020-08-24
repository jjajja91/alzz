<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>아이디 찾기</title>
<link rel="stylesheet" href="${pagecontext.request.contextPath}/resources/css/common.css" />
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&family=Open+Sans:wght@300;400;700&display=swap" rel="stylesheet">
<style>

body * {font-family: 'Open Sans', 'Noto Sans KR', sans-serif;}

#alzLogo{
	margin-left: 70px;
	width: 150px;
}

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

.id-form{
  width: 360px;
  background: #fff;
  height: 580px;
  padding: 80px 40px;
  border-radius: 10px;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%,-50%);
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
}

.id-form a{
	text-decoration: none;
	color: #335492;
}

.id-form h1{
  text-align: center;
  margin-bottom: 60px;
}

.txtb{
  border-bottom: 2px solid #adadad;
  position: relative;
  margin: 30px 0;
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

.idbtn{
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

.idbtn:hover{
  background-position: right;
}

.bottom-text{
  margin-top: 20px;
  text-align: center;
  font-size: 13px;
}

.bottom-text img{
  border-radius: 50%;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.15); 
}


</style>
</head>
<body>
	<form action="/find_id" method="post" class="id-form">
        <img src="/resources/img/로고.png" id="alzLogo">

        <div class="txtb">
          <input type="text" id="nickname" name="nickname" required>
          <span data-placeholder="닉네임"></span>
        </div>

        <div class="txtb">
          <input type="text" id="phoneNumber" name="phoneNumber" required>
          <span data-placeholder="전화번호"></span>
        </div>
        
        <input type="submit" class="idbtn" id=findBtn value="Find">
        
		<div class="bottom-text">
          	계정이 기억 나셨나요? <a href="/login">로그인하기</a>
          	<br>
			<a href="/">메인 페이지 이동</a>
        </div>
	</form>
</body>
</html>