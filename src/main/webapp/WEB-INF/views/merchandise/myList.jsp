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
	margin-left: 25%;
	min-height: 100%;
	position: relative;
}

.table-container {
	top: 90px;
	left: 20%;
}

.page-header {
	font-weight: bold;
	font-size: 24px;
	margin-bottom: 20px;
}

.content-table {
	border-collapse: collapse;
	font-size: 0.8em;
	min-width: 400px;
	width: 750px;
	overflow: hidden;
}

.content-table thead tr {
	background-color: #335492;
	color: #ffffff;
	text-align: center;
}

.content-table th {
	padding: 13px 5px;
	font-weight: bold;
	font-size: 18px;
	text-align: center;
	vertical-align: middle;
}

.content-table td {
	padding: 8px 15px;
	font-size: 15px;
	text-align: center;
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

.content-table td .result {
	font-size: 24px;
}

.pull-right {
	margin-right: 760px;
}

li {
	display: inline;
}

div.search {
	margin: 20px 0;
}

a#regBtn {
	font-size: 18px;
	background-color: #335492;
	margin-left: 277px;
	border-radius: 5px 5px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
	color: #ffffff;
	border: 1px solid #dddddd;
	background-color: #335492;
	border-radius: 5px 5px;
}
</style>
<body>

	<div class="container">
		<sec:authentication var="principal" property="principal" />
		<h1 class="page-header">상품 리스트</h1>

		<div class="table-container">
			<table class="content-table">
				<thead>
					<tr>
						<th>상품번호</th>
						<th>상품 유형</th>
						<th>상품명</th>
						<th>상품 가격</th>
						<th>상품 편집</th>
					</tr>
				</thead>


				<c:forEach items="${list}" var="merchandise">
					<tr>
						<td><c:out value="${merchandise.id }" /></td>
						<td><c:out value="${merchandise.codeType }" /></td>
						<td><a class='modify'
							href='<c:out value="${merchandise.id }"/>'> <c:out
									value="${merchandise.name }" /></a><br></td>
						<td><fmt:formatNumber value="${merchandise.salePrice}"
								pattern="#,###" /></td>
						<td><a class='modify'
							href='<c:out value="${merchandise.id }"/>'>상품 편집</a></td>
					</tr>
				</c:forEach>
			</table>
		</div>

		<!-- 검색창 -->
		<div class="search">
			<form id='searchForm' action="/merchandise/list" method='get'>
				<select name='type'>
					<option value=""
						<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>검색</option>
					<option value="T"
						<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>타입</option>
					<option value="C"
						<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>상품명</option>
					<option value="W"
						<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>내용</option>
					<option value="TC"
						<c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>타입
						or 상품명</option>
					<option value="TW"
						<c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>타입
						or 내용</option>
					<option value="TWC"
						<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>타입
						or 상품명 or 내용</option>
				</select> <input type='text' name='keyword'
					value='<c:out value="${pageMaker.cri.keyword}"/>' /> <input
					type='hidden' name='pageNum'
					value='<c:out value="${pageMaker.cri.pageNum}"/>' /> <input
					type='hidden' name='amount'
					value='<c:out value="${pageMaker.cri.amount}"/>' />
				<button class='btn btn-default'>Search</button>
				<a id='regBtn'>상품 등록</a>
			</form>
		</div>



		<!-- 페이징 -->
		<div class='pull-right'>
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<li class="paginate_button previous"><a
						href="${pageMaker.startPage -1}">Previous</a></li>
				</c:if>

				<c:forEach var="num" begin="${pageMaker.startPage}"
					end="${pageMaker.endPage}">
					<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active" :"" }"><a
						href="${num}">${num}</a></li>
				</c:forEach>

				<c:if test="${pageMaker.next}">
					<li class="paginate_button next"><a
						href="${pageMaker.endPage +1 }">Next</a></li>
				</c:if>

			</ul>
		</div>

		<form id='actionForm' action="/merchandise/list" method='get'>
			<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
			<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
			<input type='hidden' name='type'
				value='<c:out value="${ pageMaker.cri.type }"/>'> <input
				type='hidden' name='keyword'
				value='<c:out value="${ pageMaker.cri.keyword }"/>'>
		</form>



		<form id='actionForm' action="/merchandise/list" method='get'>
			<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
			<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
			<input type='hidden' name='type'
				value='<c:out value="${ pageMaker.cri.type }"/>'> <input
				type='hidden' name='keyword'
				value='<c:out value="${ pageMaker.cri.keyword }"/>'>
		</form>

	</div>

</body>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$('#regBtn').click(function() {
							location.href = "/merchandise/register";
						});

						/* $('#cartBtn').click(function() {
							location.href = "/merchandise/cart";
						}); */

						var actionForm = $("#actionForm");

						$(".paginate_button a").on(
								"click",
								function(e) {
									e.preventDefault();
									console.log('click');
									actionForm.find("input[name='pageNum']")
											.val($(this).attr("href"));
									actionForm.submit();
								});

						$(".move")
								.on(
										"click",
										function(e) {

											e.preventDefault();
											actionForm
													.append("<input type='hidden' name='id' value='"
															+ $(this).attr(
																	"href")
															+ "'>");
											actionForm.attr("action",
													"/merchandise/get");
											actionForm.submit();

										});

						$(".modify")
								.on(
										"click",
										function(e) {

											e.preventDefault();
											actionForm
													.append("<input type='hidden' name='id' value='"
															+ $(this).attr(
																	"href")
															+ "'>");
											actionForm.attr("action",
													"/merchandise/modify");
											actionForm.submit();

										});

						var searchForm = $("#searchForm");

						$("#searchForm button").on(
								"click",
								function(e) {

									if (!searchForm.find("option:selected")
											.val()) {
										alert("검색종류를 선택하세요");
										return false;
									}

									if (!searchForm.find(
											"input[name='keyword']").val()) {
										alert("키워드를 입력하세요");
										return false;
									}

									searchForm.find("input[name='pageNum']")
											.val("1");
									e.preventDefault();

									searchForm.submit();

								});
					});
</script>
</html>