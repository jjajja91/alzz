<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<title>ALZ</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&family=Open+Sans:wght@300;400;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>
<style>

		body * {font-family: 'Open Sans', 'Noto Sans KR', sans-serif;}
		.inner {
			max-width: 1200px;
			width: 100%;
			margin: 0 auto;
		}
		header {width: 100%; box-shadow: 0 0 5px rgba(0,0,0,0.3);background: #fff; position: fixed; z-index: 99; left: 0; top: 0;}
		
		header .logo {padding: 15px 0;}
		header .logo img {
			width: 120px;
		}

		header .bottom_line {
			display: flex;
			justify-content: space-between;
			align-items: center;
			border-top: 1px solid #ccc;
		}

		header .bottom_line nav {
			width: 50%;
		}

		header .bottom_line nav>ul {
			display: flex;
			align-items: center;
			justify-content: space-between;
		}

		header .bottom_line nav>ul>li {
			flex: 1; position: relative;
		}
		header .bottom_line .m_menu {display: block; text-align: center; padding: 20px 0; font-size: 18px; color: #212121;}
		header .bottom_line nav .s_nav {/*display: none;*/ position: absolute; left: 0; top: 61px; 
			width: 100%; background: #fff; border: 1px solid #ddd; display:none;}
		header .bottom_line nav .s_nav a {display: block; font-size: 16px; padding: 10px 0; 
			text-align: center; color: #585858;}
		header .bottom_line .right {
			display: flex;
			justify-content: flex-end;
			align-items: center;
		}
		header .bottom_line .mypage {
			width: 50%;
		}

		header .bottom_line .mypage>ul {
			display: flex;
			align-items: center;
			justify-content: space-between;
		}

		header .bottom_line .mypage>ul>li {
			flex: 1; position: relative;
		}
		header .bottom_line .mypage .s_nav {/*display: none;*/ position: absolute; left: -60px; top: 64px; 
			width: 150px; background: #fff; border: 1px solid #ddd; display:none;}
		header .bottom_line .mypage .s_nav a {display: block; font-size: 16px; padding: 10px 0; 
			text-align: center; color: #585858;}
			
			
		header .bottom_line .right > div {margin-left: 20px;}
		header .bottom_line .right > div i {font-size: 24px; color: #212121;}
		header .bottom_line .right .search_wrap {display: flex; align-items: center;}
		header .bottom_line .right .search_wrap .search_bar input{
			width: 0; margin-right: 10px; padding: 0; visibility: hidden; opacity: 0; transition: all 0.3s;
			border: 0; border-bottom: 2px solid #212121; height: 36px;
		}
		header .bottom_line .right .search_wrap .search_bar.on input {width: 200px; visibility: visible; opacity: 1;
			transition: all 0.3s; 
		}
	}

</style>

        
</head>
<body>
<sec:authentication var="principal" property="principal" />
		<header>
			<div class="inner">
				<div class="logo"><a href="/"><img src="/resources/img/로고.png" alt="알랴쥼"></a></div>
				<div class="bottom_line">
					<nav>
						<ul>
							<li><a href="" class="m_menu">알랴쥼</a>
								<ul class="s_nav">
									<li><a href="/board/list?typeId=1">공지사항</a></li>
									<li><a href="">알랴쥼이란</a></li>
									<li><a href="/board/list?typeId=2">이벤트</a></li>
								</ul>
							</li>
							<li><a href="" class="m_menu">취미</a>
								<ul class="s_nav">
									<li><a href="/lesson/list?main=1&sub=1">미술</a></li>
									<li><a href="/lesson/list?main=1&sub=2">공예</a></li>
									<li><a href="/lesson/list?main=1&sub=3">디지털드로잉</a></li>
									<li><a href="/lesson/list?main=1&sub=4">플라워</a></li>
									<li><a href="/lesson/list?main=1&sub=5">사진/영상</a></li>
									<li><a href="/lesson/list?main=1&sub=6">요리/음료</a></li>
									<li><a href="/lesson/list?main=1&sub=7">음악</a></li>
									<li><a href="/lesson/list?main=1&sub=8">운동</a></li>
									<li><a href="/lesson/list?main=1&sub=9">뷰티</a></li>
								</ul>
							</li>
							<li><a href="" class="m_menu">자기계발</a>
								<ul class="s_nav">
									<li><a href="/lesson/list?main=2&sub=1">언어</a></li>
									<li><a href="/lesson/list?main=2&sub=2">직무</a></li>
									<li><a href="/lesson/list?main=2&sub=3">개발/디자인</a></li>
									<li><a href="/lesson/list?main=2&sub=4">부업/창업</a></li>
									<li><a href="/lesson/list?main=2&sub=5">자격증</a></li>
									<li><a href="/lesson/list?main=2&sub=6">심리상담</a></li>
								</ul>
							</li>
							<li><a href="" class="m_menu">커뮤니티</a>
								<ul class="s_nav">
									<li><a href="/board/list?typeId=3">자유게시판</a></li>
									<li><a href="/board/list?typeId=4">후기</a></li>
									<li><a href="/board/list?typeId=5">문의하기</a></li>
								</ul>
							</li>
						</ul>
					</nav>
					<div class="right">
						<div class="search_wrap">
							<div class="search_bar">
								<input type="text" placeholder="검색어를 입력하세요.">
							</div>
							<a href="#null" class="search_btn"><i class="xi-search"></i></a>
						</div>
						<div class="mypage">
						<ul><li><a href="" class="m_menu" id="navUser"><i class="xi-user-o"></i></a>
							<sec:authorize access="isAuthenticated()">
							<ul class="s_nav">
								<li><a href="/myPage/boardList">마이페이지</a></li>
								<li><a href="/lesson/register">클래스등록</a></li>
								<c:if test="${principal.role eq 'ROLE_ADMIN'}">
								<li><a href="/admin/index">관리자</a></li>
								</c:if>
								<li><a href="/logout">LOGOUT</a></li>
							</ul>
							</sec:authorize>
							<sec:authorize access="isAnonymous()">
							<ul class="s_nav">
								<li><a href="/join">회원가입</a></li>
								<li><a href="/login">로그인</a></li>
							</ul>
							</sec:authorize>
						</li>
						</ul>
						</div>
						<div class="cart">
							<a href="/merchandise/cart" class="cart_btn"><i class="xi-cart-o"></i></a>
						</div>
					</div>
				</div>
			</div>
		</header>		
<script>

		$(document).ready(function() {
			var $menus = $("nav").find("li");
			var $mypage = $(".mypage").find("li");

			//호버 드롭다운
			$menus.hover(function(e) {
				$(this).find("ul").stop().slideToggle();
			});
			
			$mypage.hover(function(e) {
				$(this).find("ul").stop().slideToggle();
			});
			
			if($(window).scrollTop() < 0)(function(){
				$(header .logo).hide(); 
			});
			$(".search_btn").click(function(e){
				e.preventDefault();
				$(".search_bar").toggleClass("on");
			});

		});
	</script>
</body>
</html>