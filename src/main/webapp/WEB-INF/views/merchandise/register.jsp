<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Merchandise Register</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	crossorigin="anonymous"></script>
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

input, textarea, select {
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
		<h1 class="page-header">상품 등록</h1>
		<form role="form" action="/merchandise/register" method="post">
			<table>
				<tr class="trLine">
					<td class="tdKey">나의 클래스</td>
					<td class="tdVal"><select name="lessonList" class="lessonList">
							<option>클래스를 선택해주세요</option>
							<c:forEach var="lesson" items="${lessonList}">
								<option value="${lesson.id}"
									data-open='<fmt:formatDate pattern = "yyyy-MM-dd" value="${lesson.openAt}" />'
									data-end='<fmt:formatDate pattern = "yyyy-MM-dd" value="${lesson.closeAt}" />'>${lesson.title}</option>
							</c:forEach>
					</select></td>
				</tr>


				<tr class="trLine">
					<td class="tdKey">상품 유형
					<td class="tdVal"><input type="radio" name="codeType"
						class="radio" value="클래스" checked="checked"> 클래스 <input
						type="radio" class="radio" name="codeType" value="준비물">
						준비물</td>
				</tr>
				<tr class="trLine">
					<td class="tdKey">상품명</td>
					<td class="tdVal"><input class="form-control" name='name'
						readonly></td>
				</tr>
				<tr class="trLine">
					<td class="tdKey">상품 설명</td>
					<td class="tdVal"><textarea class="form-control" rows="5"
							cols="60" name='description'></textarea></td>
				</tr>
				<tr class="trLine">
					<td class="tdKey">시작일</td>
					<td class="tdVal"><input class="form-control" name='registerAt' /></td>
				</tr>

				<tr class="trLine">
					<td class="tdKey">마감일</td>
					<td class="tdVal"><input class="form-control" name='closedAt' /></td>
				</tr>

				<tr class="trLine">
					<td class="tdKey">상품 금액</td>
					<td class="tdVal"><input class="form-control"
						name='originPrice'></td>
				</tr>

				<tr class="trLine">
					<td class="tdKey">할인 후 금액</td>
					<td class="tdVal"><input class="form-control" name='salePrice'></td>
				</tr>

				<tr class="trLine">
					<td class="tdKey">할인률</td>
					<td class="tdVal"><input class="form-control"
						name='discountRate'></td>
				</tr>

				<tr class="trLine">
					<td class="tdKey">할인 마감일</td>
					<td class="tdVal"><input type="datetime-local"
						name='discountDeadline' /></td>
				</tr>

				<tr class="trLine">
					<td class="tdKey">진열 상태</td>
					<td class="tdVal"><input type="radio" name="displayState"
						class="radio" value="1" checked="checked"> 진열 <input
						type="radio" class="radio" name="displayState" value="0">
						미진열</td>
				</tr>
				<tr>
					<td colspan="2" align="center" style="padding-top: 25px;">
						<button type="submit" class="btn btn-default">등록</button>
						<button type="reset" class="btn btn-danger">취소</button>
						<button type="button" class="btn list">목록</button>
					</td>
				</tr>

			</table>

			<input class="form-control" type='hidden' name='refId' readonly>
			<input class="form-control" type='hidden' name='userId'
				value="<sec:authentication property="principal.id"/>" readonly>
		</form>
	</div>

	<script>


$(document).ready(function(e){
		var $name = $("input[name=name]");
		var $codeType = $("input[name=codeType]");
		var $description = $("textarea[name=description]");
		var $closedAt = $("input[name=closedAt]");
		var $registerAt = $("input[name=registerAt]");
		var $originPrice = $("input[name=originPrice]");
		var $displayState = $("input[name=displayState]");
		var $discountRate = $("input[name=discountRate]");
		var $discountDeadline = $("input[name=discountDeadline]");
		var $salePrice = $("input[name=salePrice]");
		var inputData = {
			name: $name,
			codeType: $codeType,
			description: $description,
			closedAt: $closedAt,
			originPrice: $originPrice,
			displayState: $displayState,
			discountRate: $discountRate,
			salePrice: $salePrice,
			discountDeadline: $discountDeadline
		};
		var $refId = $("input[name=refId]");
		var $userId = $("input[name=userId]");

		var formObj = $("form[role='form']");
		
		$discountRate.change(function(e){
			var originPrice = $originPrice.val();
			var discountRate = $discountRate.val();
			var salePrice = Math.round((originPrice-originPrice*discountRate/100)/100)*100;
			$salePrice.val(salePrice);
			
		});
	
	$("button[type='submit']").on("click", function(e){
		e.preventDefault();
		console.log("submit clicked");
		
		var data = {
				name: $name.val(),
				codeType: $codeType.val(),
				description: $description.val(),
				registerAt: $registerAt.val(),
				closedAt: $closedAt.val(),
				originPrice: $originPrice.val(),
				salePrice: $salePrice.val(),
				displayState: $displayState.val(),
				refId: $refId.val(),
				userId: $userId.val(),	
				discountRate: $discountRate.val(),
				discountDeadline: $discountDeadline.val()
		};
		console.log(data);
		merchandiseRegister(data)
		.then(function(response){
			console.log(response);
			self.location = "/merchandise/myList";
		})
		.catch (function(error){
			var errorMessage = error.responseJSON.defaultMessage;
			console.log(error.responseJSON);
			alert(errorMessage);
			var errorFocus = error.responseJSON.field;
			inputData[errorFocus].focus();
		});

	});

	function merchandiseRegister(data) {
		
		  return $.ajax({
		    url: "/merchandises",
		    type: "POST",
		    data: JSON.stringify(data),
		    contentType: "application/json; charset=utf-8"
		  });
	}
	
	$('.lessonList').change(function(e) {
		console.log("변경");
		var value = $(this).val();
		var nameText = $(":selected").text();
		var startDate = $(":selected").data("open");
		var endDate = $(":selected").data("end");
		$refId.val(value);
		$name.val(nameText);
		$registerAt.val(startDate);
		$closedAt.val(endDate);
	});
	
	$(".list").click(function() {
		location.href = "/merchandise/list";
	});

});

	</script>

</body>
</html>