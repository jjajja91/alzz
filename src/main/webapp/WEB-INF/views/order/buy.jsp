<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<style>
.container {
	margin-top: 200px;
	margin-left: 27%;
	min-height: 100%;
	position: relative;
}

.table-container {
	top: 90px;
	left: 20%;
}

.content-table {
	border-collapse: collapse;
	font-size: 0.8em;
	min-width: 400px;
	width: 700px;
	overflow: hidden;
	margin-bottom: 15px;
}

.content-table thead tr {
	background-color: #335492;
	color: #ffffff;
	text-align: left;
}

.content-table tbody tr:first-of-type {
	background-color: #335492;
	color: #ffffff;
}

.content-table th {
	padding: 10px 15px;
	font-weight: bold;
	font-size: 18px;
}

.content-table td {
	padding: 8px 15px;
	font-size: 15px;
	vertical-align: middle;
}

.content-table thead tr {
	font-weight: bold;
}

.content-table td a {
	text-decoration: none;
	color: #335492;
}

.content-table tbody tr {
	border-bottom: 1px solid #dddddd;
	font-weight: bold;
}


.content-table tbody tr:last-of-type {
	border-bottom: 2px solid #335492;
}

.content-table tbody tr.active-row {
	font-weight: bold;
	color: #335492;
}

div.title {
	margin-left: 10px;
	margin-bottom: 15px;
	font-size: 30px;
	font-weight: bold;
}

div.notice {
	border-top: 1px solid #dddddd;
	padding-top: 10px;
	width: 700px;
}

div.orderNo {
	margin-bottom: 10px;
}

p.orderNo {
	font-weight: bold;
	display: inline-block;
}

footer {
	position: absolute;
	margin-top: 30px;
	width: 100%;
	bottom: 0;
	background: #5eaeff;
	text-align: center;
	color: white;
	background: #335492;
	color: #fff;
	padding: 30px 0;
	bottom: 0;
}

th.th1 {
	text-align: left;
}

td.td2 {
	text-align: left;
	width: 300px;
}

p {
	margin: 10px 0;
}

a.main {
	font-size: 18px;
	background-color: #335492;
	color: #ffffff;
	border: 1px solid #dddddd;
	background-color: #335492;
	padding: 6px 12px;
	border-radius: 5px 5px;
}

div.toMain {
	margin: 30px 0 30px 300px;
}

img.lessonImg {
	width: 100px;
	height: 100px;
}

</style>
<body>
	<div class="container">
		<sec:authentication var="principal" property="principal" />
		<div class="title">|주문 완료</div>
		<div class="notice">
			<p style="margin-bottom: 5px;">주문이 완료되었습니다. 이용해 주셔서 감사합니다.</p>
			<p>주문 내역은 [마이페이지 > 결제 내역]에서 다시 확인할 수 있습니다.</p>
		</div>
		<br>
		<div class="orderNo">
			주문번호 :
			<p class="orderNo">${orderId}</p>
		</div>

		<!-- alz_order_detail에서 가져옴 -->
		<div class="orderConfirm">
			<div class="table-container">

				<table class="content-table">
					<tr>
						<th class="th1">|상품 정보</th>
						<th class="th1"></th>
						<th class="th1"></th>
					</tr>
					<c:set var="finalTotalPrice" value="0" />
					<c:forEach items="${orderList}" var="list">
						<tr>
							<td><c:if test="${empty list.thumbnail}">
									<img class="lessonImg"
										src="../../../resources/img/classtmpimg.jpg">
								</c:if> <c:if test="${!empty list.thumbnail}">
									<img class="lessonImg"
										src='/resources/img/lesson/thumb/${list.teacherId}
										<fmt:formatDate pattern = "yyyy-MM-dd" value="${list.openAt}" />
										/${list.thumbnail}'>
								</c:if></td>
							<td><p>${list.name }</p>
								<p>
									<fmt:formatNumber value="${list.salePrice}" pattern="#,###" />
									원
								</p></td>
							<td>결제 완료</td>
						</tr>
						<c:set var="finalTotalPrice"
							value="${finalTotalPrice + list.salePrice}" />
					</c:forEach>
				</table>
			</div>
			<br>

			<div class="orderer">
				<table class="content-table">
					<tr>
						<th class="th1">|주문자 정보</th>
						<th class="th1"></th>
					</tr>
					<tr>
						<td>이름</td>
						<td class="td2">${orderer.name}</td>
					</tr>
					<tr>
						<td>연락처</td>
						<td class="td2">${orderer.phone}</td>
					</tr>
				</table>
			</div>
			<br>

			<div class="payInfo">
				<table class="content-table">
					<tr>
						<th class="th1">|결제 정보</th>
						<th class="th1"></th>
					</tr>
					<tr>
						<td>결제 방법</td>
						<td class="td2">카카오 페이</td>
					</tr>
					<tr>
						<td>결제 금액</td>
						<td class="td2"><fmt:formatNumber value="${finalTotalPrice}"
								pattern="#,###" /> 원</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="toMain">
			<a class='main' href='/'> 홈으로 </a>
		</div>
	</div>
</body>
<script type="text/javascript">
	
</script>
</html>