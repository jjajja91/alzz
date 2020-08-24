<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" type="text/css" href="resources/css/common.css" /> -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<style>
*{
  margin: 0;
  padding: 0;
  font-family: sans-serif;
  list-style: none;
  text-decoration: none;
}

.mypageMiddle{
  position: absolute;
  top: 60%;
  left: 17%;
  transform: translate(-50%,-50%);
}
.mypageMenu{
  width: 200px;
  border-radius: 8px;
  overflow: hidden;
}
.mypageItem{
  border-top: 1px solid #2980b9;
  overflow: hidden;
}
.mypageBtn{
  display: block;
  padding: 16px 20px;
  background: #335492;
  color: white;
  position: relative;
}
.mypageBtn:before{
  content: "";
  position: absolute;
  width: 14px;
  height: 14px;
  background:#335492;
  left: 20px;
  bottom: -7px;
  transform: rotate(45deg);
}
.mypageBtn i{
  margin-right: 10px;
}
.smenu{
  background: #eee;
  overflow: hidden;
  transition: max-height 0.3s;
  max-height: 0;
}
.smenu a{
  display: block;
  padding: 16px 26px;
  color: gray;
  font-size: 14px;
  margin: 4px 0;
  position: relative;
}
.smenu a:before{
  content: "";
  position: absolute;
  width: 6px;
  height: 100%;
  background: #335492;
  left: 0;
  top: 0;
  transition: 0.3s;
  opacity: 0;
}
.smenu a:hover:before{
  opacity: 1;
}
.mypageItem:target .smenu{
  max-height: 20em;
}

</style>
</head>
<body>

    <div class="mypageMiddle">
      <div class="mypageMenu">
        <li class="mypageItem" id='student'>
          <a href="#student" class="mypageBtn">학생메뉴</a>
          <div class="smenu">
  			<a href="/myPage/activeLesson">수강 중 클래스</a>
  			<a href="/myPage/finishedLesson">수강완료 클래스</a>
  			<a href="#">개설대기 클래스</a>
          </div>
        </li>
		<sec:authorize access="hasRole('ROLE_TEACHER') or hasRole('ROLE_ADMIN')">
        <li class="mypageItem" id="teacher">
          <a href="#teacher" class="mypageBtn">선생님메뉴</a>
          <div class="smenu">
  			<a href="/merchandise/myList">강의 등록</a>
  			<a href="/myPage/teachingLesson">강의 중 클래스</a>
  			<a href="#">모집 중 클래스</a>
  			<a href="/myPage/teachedLesson">강의종료 클래스</a>
          </div>
        </li>
    	</sec:authorize>
    	<li class="mypageItem" id="paymentList">
          <a href="#paymentList" class="mypageBtn">결제정보</a>
          <div class="smenu">
  			<a href="/myPage/refundedList">취소/환불</a>
  			<a href="/myPage/paidOrderList">결제 내역</a>
          </div>
        </li>
        <li class="mypageItem" id="myList">
          <a href="#myList" class="mypageBtn">내 관심 목록</a>
          <div class="smenu">
 			<a href="/myPage/reservLessonList">찜 클래스</a>
  			<a href="/myPage/likeLessonList">좋아요 클래스</a>
  			<a href="/myPage/boardList">내 게시글</a>
  			<a href="/myPage/commentList">내 댓글</a>
  			<a href="/myPage/likeList">내 좋아요</a>
          </div>
        </li>
  		<sec:authorize access="hasRole('ROLE_USER') or hasRole('ROLE_ADMIN') or hasRole('ROLE_TEACHER')">        
        <li class="mypageItem" id="userInfo">
          <a href="#userInfo" class="mypageBtn">내 정보</a>
          <div class="smenu">
  			<a href="/myPage/modifyAcc">개인 정보 수정</a>
  			<a href="/myPage/deleteAcc">회원 탈퇴</a>
          </div>
        </li>
  		</sec:authorize>
        <li class="mypageItem">
          <a class="mypageBtn" href="#"><i class="xi-caret-up-circle-o"></i></a>
        </li>
      </div>
    </div>