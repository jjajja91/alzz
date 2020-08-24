<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@include file="../includes/myPageNav.jsp"%>
<%@include file="../includes/header.jsp"%>
<head>
<style>
.container {
	position: relative;
	margin-top: 200px;
}

.container h1 {
	text-align: center;
	font-size: 2em;
	color: #335492;
}

.table-container {
	position: absolute;
	top: 90px;
	right: 15%;
}

.content-table {
	border-collapse: collapse;
	font-size: 0.8em;
	min-width: 400px;
	margin-bottom: 30px;
	width: 700px;
	overflow: hidden;
	width: 700px;
}

.content-table thead {
	font-weight: bold;
	font-size: 18px;
}

.content-table thead tr {
	background-color: #335492;
	color: #ffffff;
	text-align: left;
}

.content-table th {
	padding: 13px 15px
}

.content-table td {
	padding: 8px 15px;
	vertical-align: middle;
}

.content-table td a {
	text-decoration: none;
	color: #335492;
}

.content-table tbody tr {
	border-bottom: 1px solid #dddddd;
}

.content-table tbody tr:nth-of-type(even) {
	background-color: #f3f3f3;
}

.content-table tbody tr:last-of-type {
	border-bottom: 2px solid #335492;
}

.content-table tbody tr.active-row {
	font-weight: bold;
	color: #335492;
}

.page-footer {
	right: 0%;
	bottom: 0%;
	margin-top: 20px;
}

.page-footer li {
	float: left;
}

.paginate_button a {
	text-decoration: none;
	background-color: #eee;
	padding: 5px 10px;
	color: #335492;
}

.active a {
	color: #eee;
	background-color: #335492;
}

h1.page-header {
	margin-left: 75px;
}

td.tdSub {
	width: 300px;
}

div.list {
	text-align: center;
}

button.btn-danger {
	background-color: #335492;
	color: #ffffff;
	border-radius: 5px 5px;
	border: 1px solid #dddddd;
	font-size: 20px;
	padding: 1px 5px;
	margin-bottom: 50px;
	padding: 6px 12px;
	cursor: pointer;
}

p {
	padding: 5px 0;
}

img.lessonImg {
	width: 100px;
	height: 100px;
}
</style>
</head>
<body>

	<div class="container">
		<h1 class="page-header">주문번호 : ${orderId}</h1>
		<div class="table-container">
			<table class="content-table" id="table">
				<thead>
					<tr>
						<td colspan="3">상품 정보</td>
					</tr>
				</thead>
				<c:set var="finalTotalPrice" value="0" />
				<c:forEach items="${orderList}" var="list">
					<tr>
						<td><a class='read' href='/lesson/read?id=${list.lessonId}'><c:if test="${empty list.thumbnail}">
								<img class="lessonImg"
									src="../../../resources/img/classtmpimg.jpg">
							</c:if> <c:if test="${!empty list.thumbnail}">
								<img class="lessonImg"
									src='/resources/img/lesson/thumb/${list.teacherId}
										<fmt:formatDate pattern = "yyyy-MM-dd" value="${list.openAt}" />
										/${list.thumbnail}'>
							</c:if></a></td>
						<td>
							<p><a class='read' href='/lesson/read?id=${list.lessonId}'>${list.name }</a></p>
							<p>
								<fmt:formatNumber value="${list.salePrice}" pattern="#,###" />
								원
							</p>
						</td>
						<td>결제 완료</td>
					</tr>
					<c:set var="finalTotalPrice"
						value="${finalTotalPrice + list.salePrice}" />
				</c:forEach>
				</tbody>
			</table>


			<table class="content-table" id="table">
				<thead>
					<tr>
						<td colspan="2">주문 정보</td>
					</tr>
				</thead>
				<tr>
					<td class="tdSub">이름</td>
					<td>${orderer.name}</td>
				</tr>
				<tr>
					<td class="tdSub">연락처</td>
					<td>${orderer.phone}</td>
				</tr>
			</table>

			<table class="content-table" id="table">
				<thead>
					<tr>
						<td colspan="2">결제 정보</td>
					</tr>
				</thead>
				<tr>
					<td class="tdSub">결제 방법</td>
					<td>카카오 페이</td>
				</tr>
				<tr>
					<td class="tdSub">결제 금액</td>
					<td><fmt:formatNumber value="${finalTotalPrice}"
							pattern="#,###" /> 원</td>
				</tr>

			</table>
			<div class="list">
				<button class="btn btn-danger">주문 목록</button>
			</div>
		</div>
	</div>


	<script type="text/javascript">
		
	</script>
</body>
</html>