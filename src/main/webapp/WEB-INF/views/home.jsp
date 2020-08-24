<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="./includes/header.jsp"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&family=Open+Sans:wght@300;400;700&display=swap" rel="stylesheet">
	<style>
		body * {font-family: 'Open Sans', 'Noto Sans KR', sans-serif;}
		
		h2 {
			font-size: 30px;
			font-weight: 300px;
		}
		
		.slide_wrap {
			margin-top: 150px;
		}
		
		.slide_wrap .swiper-container {
			overflow: hidden;
			position: relative;
		}

		.slide_wrap .swiper-slide {
			height: 500px;
			background: #888;
		}

		.slide_wrap .pager_wrap {
			position: absolute;
			left: 0;
			bottom: 50px;
			width: 100%;
			z-index: 9;
		}

		.slide_wrap .pager_wrap .pager_line {
			display: flex;
			align-items: center;
			background-color: black;
			color: white;
			width: 105px;
			padding: 10px 5px;
		}

		.slide_wrap .pager_wrap .pager_line * {
			line-height: 1;
			cursor: pointer;
		}

		.slide_wrap .pager_wrap .swiper_fraction {
			width: auto;
			margin: 0 20px;
		}

		.main_wrap section {
            padding: 40px 0 0;
        }

        .main_wrap section:last-child {
            padding-bottom: 80px;
        }

        .main_wrap section ul {
            display: flex;
            flex-flow: row wrap;
            margin-top: 30px;
            margin-left: 30px;
        }

        .main_wrap section ul li {
            width: 200px;
            margin-left: 15px;
            margin-right: 15px;
            margin-bottom: 20px;
            position: relative;
        }

        .main_wrap section ul li .img {
            height: 160px;
            max-height: 160px;
            width: 200px;
            max-width: 200px;
            margin-bottom: 10px;
            position: relative;
        }
        
        .main_wrap section ul li .img img {
            height: 160px;
            width: 200px;
        }

        .main_wrap section ul li h3 {
            font-size: 18px;
            text-align: left;
            margin-top: 10px;
        }

        .main_wrap section ul li span {
            border: none;
            padding: 2px 10px;
            background-color: #335492;
            color: #f4f4f4;
            margin-right: 5px;
            font-size: 12px;
        }
        
        .main_wrap section ul li a {
            text-decoration: none;
            color: black;
        }

        li h6 {
            display: inline;
        }
        
        .main_wrap section ul li .selected {
        	display: flex;
        }
        
        .main_wrap section ul li .selected a {
        	color: white;
        }
        
        .likeInfo {

            position:absolute;
            right: 0%;
            top: 0%;
                  width: 100%;
                  height: 100%;
                  justify-content:center;
                  align-items:center;
            display: none;
            z-index: 1;
                  background: rgba(0,0,0,0.7);

        }
        
        .likeInfo a {color: #fff; display: flex; align-items:center; font-size: 20px; padding: 0 10px;}
        
        .likeInfo i {
        	margin-right: 5px;
        }

        li h3 {
            margin: 10px 0px;
            height: 70px;
        }

        li h4 {
            text-decoration: line-through;
            display: inline;
        }

        li h5 {
            display: inline;
            color: red;
        }

        li h1 {
            margin-top: 10px;
            font-size: 25px;
            font-weight: 200px;
        }
        
        .price {
            text-align: right;
            margin-bottom: 50px;
        }
		footer {background: #335492; color: #fff; padding: 30px 0;}
	
	.bot {
	position: fixed;
	width: 50px;
	height: 50px;
	right: 50px;
	bottom: 50px;
	margin: 0;
	border-radius: 30px;
	}
	
	.bot button {
	border: none;
	outline: none;
	cursor: pointer;
	width: 100%;
	height: 100%;
	background: transparent url("/resources/img/챗봇.png") no-repeat center;
	background-size: contain;
	}
	</style>
</head>

<sec:authentication var="principal" property="principal" />

<body>
	<div class="container">
		<div class="slide_wrap">
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide"><a href="/lesson/register"><img src="/resources/img/배너1.png"></a>
					</div>
					<div class="swiper-slide"><a href="/lesson/read?id=37"><img src="/resources/img/배너2.png"></a></div>
					<div class="swiper-slide"><a href="/lesson/list?main=2&sub=3"><img src="/resources/img/배너3.png"></a></div>
					<div class="swiper-slide"><a href="/lesson/list?main=1&sub=2"><img src="/resources/img/배너4.png"></a></div>
				</div>
				<div class="pager_wrap">
					<div class="inner">
						<div class="pager_line">
							<div class="swiper_prev swiper_button"><i class="xi-arrow-left"></i></div>
							<div class="swiper_fraction"></div>
							<div class="swiper_next swiper_button"><i class="xi-arrow-right"></i></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="main_wrap">
			<section class="sec01">
				<div class="inner">
					<h2>베스트클래스</h2>
					<ul>
						<li>
                            <div class="img">                           	
                        		<div class="likeInfo">
                                	<a class="like" href=""><i class="xi-heart-o">196</i></a>
                                	<a class="reserv" href=""><i class="xi-star-o">231</i></a>
                            	</div>
                            	<a href="/lesson/read?id=37">
                            	<!-- /resources/img/lesson/thumb/132020-08-24/05d7f1a0-69bc-4cc0-a0e4-40dfd7706314_주석 2020-08-20 094231.png -->
								<img class="lessonImg" src="/resources/img/lesson/thumb/132020-08-24/05d7f1a0-69bc-4cc0-a0e4-40dfd7706314_주석 2020-08-20 094231.png">
                                </div>
                                <span>정규</span><span>개발/디자인</span>
                                <h3>자바의 정석</h3>
                                <div class="price">
                                	<h4>1,000,000원</h4>
                                    <h5>5%</h5>
                                    <h1>950,000원</h1>
                                </div>
                                </a>
                        	</li>
						<li>
                            <div class="img">                           	
                        		<div class="likeInfo">
                                	<a class="like" href=""><i class="xi-heart-o">24</i></a>
                                	<a class="reserv" href=""><i class="xi-star-o">69</i></a>
                            	</div>
                            	<a href="/lesson/read?id=5">
                            	<!-- /resources/img/lesson/thumb/42020-08-27/440b75e1-8804-43b6-97fa-8bce486af346_주석 2020-08-18 093855.png -->
								<img class="lessonImg" src="/resources/img/lesson/thumb/42020-08-27/440b75e1-8804-43b6-97fa-8bce486af346_주석 2020-08-18 093855.png">
                                </div>
                                <span>원데이</span><span>공예</span>
                                <h3>자연을 엮는 올라라탄의 라탄공예 입문</h3>
                                <div class="price">
                                	<h4>25,000원</h4>
                                    <h5>5%</h5>
                                    <h1>23,800원</h1>
                                </div>
                                </a>
                        	</li>
                        	<li>
                            <div class="img">                           	
                        		<div class="likeInfo">
                                	<a class="like" href=""><i class="xi-heart-o">45</i></a>
                                	<a class="reserv" href=""><i class="xi-star-o">63</i></a>
                            	</div>
                            	<a href="/lesson/read?id=17">
                            	<!-- /resources/img/lesson/thumb/82020-10-05/0c77f485-62fa-4b46-a222-64aeed8134d8_주석 2020-08-18 181418.png -->
								<img class="lessonImg" src="/resources/img/lesson/thumb/82020-10-05/0c77f485-62fa-4b46-a222-64aeed8134d8_주석 2020-08-18 181418.png">
                                </div>
                                <span>정규</span><span>개발/디자인</span>
                                <h3>디자인은 '실무자'에게 배우세요, 기본기부터 탄탄한 디자이너가 되기까지</h3>
                                <div class="price">
                                	<h4>120,000원</h4>
                                    <h5>10%</h5>
                                    <h1>108,000원</h1>
                                </div>
                                </a>
                        	</li>
                        	<li>
                            <div class="img">                           	
                        		<div class="likeInfo">
                                	<a class="like" href=""><i class="xi-heart-o">34</i></a>
                                	<a class="reserv" href=""><i class="xi-star-o">37</i></a>
                            	</div>
                            	<a href="/lesson/read?id=4">
                            	<!-- /resources/img/lesson/thumb/32020-09-01/c2636ccf-f333-43b3-830f-94f01047aa29_주석 2020-08-17 204747.png -->
								<img class="lessonImg" src="/resources/img/lesson/thumb/32020-09-01/c2636ccf-f333-43b3-830f-94f01047aa29_주석 2020-08-17 204747.png">
                                </div>
                                <span>정규</span><span>디지털드로잉</span>
                                <h3>또 다른 나를 그리다, 동글의 아이패드 캐릭터 드로잉</h3>
                                <div class="price">
                                	<h4>43,000원</h4>
                                    <h5>5%</h5>
                                    <h1>40,900원</h1>
                                </div>
                                </a>
                        	</li>
                        	<li>
                            <div class="img">                           	
                        		<div class="likeInfo">
                                	<a class="like" href=""><i class="xi-heart-o">24</i></a>
                                	<a class="reserv" href=""><i class="xi-star-o">47</i></a>
                            	</div>
                            	<a href="/lesson/read?id=36">
                            	<!-- /resources/img/lesson/thumb/122020-09-04/b70b14a0-7f14-49af-b8cb-dccb0082b4f0_주석 2020-08-20 035041.png -->
								<img class="lessonImg" src="/resources/img/lesson/thumb/122020-09-04/b70b14a0-7f14-49af-b8cb-dccb0082b4f0_주석 2020-08-20 035041.png">
                                </div>
                                <span>정규</span><span>운동</span>
                                <h3>하루 10분, 요가로 찾은 내 몸의 선</h3>
                                <div class="price">
                                	<h4>600,000원</h4>
                                    <h5>10%</h5>
                                    <h1>540,000원</h1>
                                </div>
                                </a>
                        	</li>
					</ul>
				</div>
			</section>
			<section class="sec02">
				<div class="inner">
					<h2>마감임박클래스</h2>
                    <ul>
                    	<c:set var="soonCnt" value="${-1}" />
                		<c:forEach items="${soonList}" var="soonLesson">
                		<c:set var= "soonCnt" value="${soonCnt + 1}"/>
                        	<li>
                        		<input type="hidden" class="lessonId" data-order="${soonCnt}" value="${soonLesson.id}">
                                <div class="img">                           	
                        		<div class="likeInfo">
                                	<a class="like" data-order="${soonCnt}" href=""><i class="xi-heart-o"></i></a>
                                	<a class="reserv" data-order="${soonCnt}" href=""><i class="xi-star-o"></i></a>
                                	<input type="hidden" class="isLike" value="false">
                            	</div>
                            	<a href="/lesson/read?id=${soonLesson.id }">
                                <c:if test= "${empty soonLesson.thumbnail}">
								<img class="lessonImg" src="../../../resources/img/classtmpimg.jpg">
								</c:if>
								<c:if test= "${!empty soonLesson.thumbnail}">
								<img class="lessonImg" src="/resources/img/lesson/thumb/${soonLesson.teacherId}${soonLesson.openAt}/${soonLesson.thumbnail}">
								</c:if>
                                </div>
                                <span>${soonLesson.typeName}</span><span>${soonLesson.categoryName}</span>
                                <h3>${soonLesson.title}</h3>
                                <div class="price">
                                	<fmt:formatNumber type="number" var="sOriginPrice" maxFractionDigits="3" value="${soonLesson.originPrice}" />
                                    <h4>${sOriginPrice}원</h4>
                                    <fmt:parseNumber var= "sDiscountRate" integerOnly= "true" value= "${soonLesson.discountRate }" />
                                    <h5>${sDiscountRate}%</h5>
                                    <fmt:formatNumber type="number" var="sSalePrice" maxFractionDigits="3" value="${soonLesson.salePrice}" />
                                    <h1>${sSalePrice}원</h1>
                                </div>
                                </a>
                        	</li>
                        </c:forEach>
                    </ul>
				</div>
			</section>
			<section class="sec03">
				<div class="inner">
					<h2>신규출시클래스</h2>
					    <ul>
                    	<c:set var="newCnt" value="${-1}" />
                		<c:forEach items="${newList}" var="newLesson">
                		<c:set var= "newCnt" value="${newCnt + 1}"/>
                        	<li>
                        		<input type="hidden" class="lessonId" data-order="${newCnt}" value="${newLesson.id}">
                                <div class="img">                           	
                        		<div class="likeInfo">
                                	<a class="like" data-order="${newCnt}" href=""><i class="xi-heart-o"></i></a>
                                	<a class="reserv" data-order="${newCnt}" href=""><i class="xi-star-o"></i></a>
                                	<input type="hidden" class="isLike" value="false">
                            	</div>
                            	<a href="/lesson/read?id=${newLesson.id }">
                                <c:if test= "${empty newLesson.thumbnail}">
								<img class="lessonImg" src="../../../resources/img/classtmpimg.jpg">
								</c:if>
								<c:if test= "${!empty newLesson.thumbnail}">
								<img class="lessonImg" src="/resources/img/lesson/thumb/${newLesson.teacherId}${newLesson.openAt}/${newLesson.thumbnail}">
								</c:if>
                                </div>
                                <span>${newLesson.typeName}</span><span>${newLesson.categoryName}</span>
                                <h3>${newLesson.title}</h3>
                                <div class="price">
                                	<fmt:formatNumber type="number" var="nOriginPrice" maxFractionDigits="3" value="${newLesson.originPrice}" />
                                    <h4>${nOriginPrice}원</h4>
                                    <fmt:parseNumber var= "nDiscountRate" integerOnly= "true" value= "${newLesson.discountRate }" />
                                    <h5>${nDiscountRate}%</h5>
                                    <fmt:formatNumber type="number" var="nSalePrice" maxFractionDigits="3" value="${newLesson.salePrice}" />
                                    <h1>${nSalePrice}원</h1>
                                </div>
                                </a>
                        	</li>
                        </c:forEach>
                    </ul>
				</div>
			</section>
		</div>
		<footer>
			<div class="inner">
				<p class="copy"> Copyright, ⓒ ALZ. All rights reserved.</p>
			</div>
		</footer>
		<div class="bot">
			<button></button>
		</div>
	</div>

	<script>
	
/*      window.onload = function () {
        var ref = this.open('http://a2-alz.web.app/');
        this.addEventListener('message', function (e) {
            if (e.data.permission === "granted") { ref.close(); }
            console.log(e.data.token);
        });
    } */
	 
		$(document).ready(function() {

			var swiper = new Swiper('.swiper-container', {
				pagination: {
					el: '.swiper_fraction',
					type: 'fraction',
				},
				loop: true,
				autoplay: {
					delay: 5000,
					disableOnInteraction: false,
				},
				navigation: {
					nextEl: '.swiper_next',
					prevEl: '.swiper_prev',
				},
			});	
			
			
			var $hoverImg = $(".main_wrap section ul li .img");
			
			$hoverImg.hover(function(e) {
				$(this).parent().find(".likeInfo").toggleClass("selected");
			});
			
		});
	</script>
</body>

</html>