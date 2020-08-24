<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정/삭제</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<style>
body {
	margin-bottom: 50px;
}

tr.trLine {
	border-bottom: 1px solid #dddddd;
}
textarea {
	margin: 5px 0;
}
.container {
	margin-top: 200px;
	margin-left: 30%;
	min-height: 100%;
	position: relative;
}

.page-header {
	font-weight: bold;
	font-size: 24px;
	margin-bottom: 20px;
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

input, textarea {
	border: 1px solid #335492;
	width: 450px;
}

input.radio {
	width: 30px;
}
button {
	border-radius: 5px 5px;
	border: 1px solid #dddddd;
	font-size: 18px;
}
button.btn-danger {
	background-color: Tomato;
	color: #ffffff;
}
button.btn-default {
	background-color: #335492;
	color: #ffffff;
}
</style>

<body>
	<div class="container">
		<h1 class="page-header">상품 편집</h1>
		<form id="merchandiseEdit" name="merchandiseEdit"
			action="/merchandise/modify" method="post">
			<table>
				<tr class="trLine">
					<td class="tdKey">상품 번호</td>
					<td class="tdVal"><input type="text" id="id" name="id"
						value="${merchandise.id}" readonly="readonly"></td>
				<tr class="trLine">
				<!-- 							<tr>
								<td>상품이미지</td>
								<td>이미지 <br> <input type="file" id="merchandiseImage"
									name="merchandiseImage">
								</td>
							</tr> -->
				<tr class="trLine">
					<td class="tdKey">상품명</td>
					<td class="tdVal"><input type="text" id="name" name="name"
						value="${merchandise.name }" readonly></td>
				</tr>
				<tr class="trLine">
					<td class="tdKey">상품 유형</td>
					<td class="tdVal" id="codeType"><input type="text"
						name="codeType" value="${merchandise.codeType}" readonly></td>
				</tr>
				<tr class="trLine">
					<td class="tdKey">상품 내용</td>
					<td class="tdVal"><textarea id="description"
							name="description" rows="5" cols="60">${merchandise.description}</textarea></td>
				</tr>

				<tr class="trLine">
					<td class="tdKey">상품 마감일</td>
					<td class="tdVal"><input type="text" id="closedAt"
						name="closedAt"
						value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${merchandise.closedAt}" />'></td>
				</tr>

				<tr class="trLine">
					<td class="tdKey">상품 금액</td>
					<td class="tdVal"><input type="text" id="originPrice"
						name="originPrice" value="${merchandise.originPrice}" /></td>
				</tr>

				<tr class="trLine">
					<td class="tdKey">할인 후 금액</td>
					<td class="tdVal"><input type="text" id="salePrice"
						name="salePrice" value="${merchandise.salePrice}" readonly></td>
				</tr>

				<tr class="trLine">
					<td class="tdKey">할인율</td>
					<td class="tdVal"><input type="number" id="discountRate"
						name="discountRate" value="${merchandise.discountRate }"></td>
				</tr>

				<tr class="trLine">
					<td class="tdKey">할인 마감일</td>
					<td class="tdVal"><input type="text" id="discountDeadline"
						name="discountDeadline"
						value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${merchandise.discountDeadline }" />'></td>
				</tr>

				<tr class="trLine">
					<td class="tdKey">진열 상태</td>
					<td class="tdVal" id="displayState"><input type="radio" class="radio"
						name="displayState" value="1"
						<c:if test="${merchandise.displayState eq '1'}">checked</c:if>>
						진열 <input type="radio" name="displayState" value="0" class="radio"
						<c:if test="${merchandise.displayState eq '0'}">checked</c:if>>
						미진열</td>

				</tr>

				<tr class="trLine">
					<td class="tdKey">상품 대상 식별자</td>
					<td class="tdVal"><input type="text" id="refId" name="refId"
						value="${merchandise.refId }"></td>
				</tr>

				<tr class="trLine">
					<td class="tdKey">상품 식별자</td>
					<td class="tdVal"><input type="text" id="merchandiseId"
						name="merchandiseId" value="${merchandise.userId }"></td>
				</tr>

				<tr>
					<td colspan="2" align="center" style="padding-top: 25px;">
						<button type="submit" data-oper='modify' class="btn btn-default">수정</button>
						<button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>
						<button type="submit" data-oper='list' class="btn btn-info">목록</button>
					</td>
				</tr>
			</table>

			<input type='hidden' name='pageNum'
				value='<c:out value="${cri.pageNum }"/>'> <input
				type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
			<input type='hidden' name='keyword'
				value='<c:out value="${cri.keyword}"/>'> <input
				type='hidden' name='type' value='<c:out value="${cri.type}"/>'>


		</form>
	</div>


</body>

<script type="text/javascript">
	$(document).ready(function(){
			
			$originPrice = $("#originPrice");
			$discountRate = $("#discountRate");
			$salePrice = $("#salePrice");
			
			$discountRate.change(function(e){
				var originPrice = $originPrice.val();
				var discountRate = $discountRate.val();
				var salePrice = Math.round((originPrice-originPrice*discountRate/100)/100)*100;
				$salePrice.val(salePrice);
				
			});
			
				var formObj = $("form");

				$('button').on(
						"click",
						function(e) {

							e.preventDefault();

							var operation = $(this).data("oper");

							console.log(operation);

							if (operation === 'remove') {
								var delConfirm = confirm('정말로 삭제하시겠습니까?');
								   if (delConfirm) {
								      alert('삭제되었습니다.');
								   }
								   else {
								      return;
								   }
								console.log("리무브");
								formObj.attr("action", "/merchandise/remove");
							} else if (operation === 'list') {
								formObj.attr("action", "/merchandise/myList")
										.attr("method", "get");

								var pageNumTag = $("input[name='pageNum']")
										.clone();
								var amountTag = $("input[name='amount']")
										.clone();

								var typeTag = $("input[name='type']").clone();
								var keywordTag = $("input[name='keyword']")
										.clone();

								formObj.empty();

								formObj.append(pageNumTag);
								formObj.append(amountTag);
								formObj.append(typeTag);
								formObj.append(keywordTag);

							} else {
								alert('수정 완료');
							}
							
							
							formObj.submit();

						});

			});
</script>
</html>