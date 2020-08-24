<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../../includes/admin_header.jsp"%>
<!-- Content Wrapper -->
<div id="content-wrapper" class="d-flex flex-column">

	<!-- Main Content -->
	<div id="content">

		<!-- Begin Page Content -->
		<div class="container-fluid">

			<!-- Page Heading -->
			<div
				class="d-sm-flex align-items-center justify-content-between mb-4">
				<h1 class="h3 mb-2 text-gray-800">주문 통합 리스트</h1>
				<a href="#"
					class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"
					data-toggle="modal" data-target="#logoutModal"><i
					class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i> Log
					out</a>
			</div>
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">주문 검색</h6>
				</div>
				<div class="card shadow mb-4">

					<div class="card-body">
						<div class="table-responsive">
							<form id='searchForm' action="/admin/order/orderMain"
								method='get'>
								<table class="table table-bordered" id="search" width="100%"
									cellspacing="0">
									<tbody>
										<tr>
											<th>검색어</th>
											<td colspan="3">
												<div class="form-inline">
													<select name='type'>
														<option value="N"
															<c:out value="${pageMaker.cri.type eq 'N'?'selected':''}"/>>주문번호</option>
														<option value="O"
															<c:out value="${pageMaker.cri.type eq 'O'?'selected':''}"/>>주문자
															명</option>
														<option value="P"
															<c:out value="${pageMaker.cri.type eq 'P'?'selected':''}"/>>주문자
															핸드폰 번호</option>
														<!-- <option value="M"
															<c:out value="${pageMaker.cri.type eq 'M'?'selected':''}"/>>상품명</option>  -->
													</select>
													<p>&nbsp; &nbsp;</p>
													<input type='text' name='keyword'
														value='<c:out value="${pageMaker.cri.keyword}"/>' /> <input
														type='hidden' name='pageNum'
														value='<c:out value="${pageMaker.cri.pageNum}"/>' /> <input
														type='hidden' name='amount'
														value='<c:out value="${pageMaker.cri.amount}"/>' />
												</div>
											</td>
										</tr>
										<tr>
											<th>기간 검색</th>
											<td colspan="3">
												<div class="form-inline">
													<div class="input-group js-datepicker">
														<input type="date" name="treatDate[]" value="2020-07-31"
															class="form-control width-xs"> <span
															class="input-group-addon"> <span
															class="btn-icon-calendar"> </span>
														</span>
													</div>
													<p>&nbsp;~&nbsp;</p>
													<div class="input-group js-datepicker">
														<input type="date" name="treatDate[]" value="2020-08-06"
															class="form-control width-xs"> <span
															class="input-group-addon"> <span
															class="btn-icon-calendar"> </span>
														</span>
													</div>
													<div class="btn-group js-dateperiod" data-toggle="buttons"
														data-target-name="treatDate[]">
														<label class="btn btn-white btn-sm hand"><input
															type="radio" name="searchPeriod" value="0">오늘</label><label
															class="btn btn-white btn-sm hand active"><input
															type="radio" name="searchPeriod" value="6">7일</label><label
															class="btn btn-white btn-sm hand"><input
															type="radio" name="searchPeriod" value="14">15일</label><label
															class="btn btn-white btn-sm hand"><input
															type="radio" name="searchPeriod" value="29">1개월</label><label
															class="btn btn-white btn-sm hand "><input
															type="radio" name="searchPeriod" value="89">3개월</label><label
															class="btn btn-white btn-sm hand "><input
															type="radio" name="searchPeriod" value="364">1년</label>
													</div>

												</div>
											</td>
										</tr>

									</tbody>
								</table>
								<div class="text-center my-auto">
									<button type="submit" class="btn btn-outline-primary">검
										색</button>
								</div>
							</form>
						</div>
					</div>
				</div>

				<div class="card-body">
					<div class="table-responsive">
						<div>
								선택한 항목 <select id="orderState">
									<option value="결제 완료">결제 완료</option>
									<option value="취소 완료">취소 완료</option>
									<option value="취소 요청">취소 요청</option>
									<option value="기타">기타</option>
								</select>
								<button type="button" id="stateBtn"
									class="btn btn-secondary btn-sm">실행</button>

						</div>
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr>
									<th><input type="checkbox" id="checkAll"></th>
									<th>번호</th>
									<th>주문 일시</th>
									<th>주문 번호</th>
									<th>주문자</th>
									<th>주문 상품</th>
									<th>결제 금액</th>
									<th>결제 상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list}" var="order">
									<tr>
										<td><input type="checkbox" class="checkEach" name="checkEach" ></td>
										<td><c:out value="${order.no}" /></td>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
												value="${order.orderAt}" /></td>
										<td><a class="move" href='<c:out value="${order.id}" />'>
												<c:out value="${order.id}" />
										</a></td>
										<td><c:out value="${order.name}" /><br>(<c:out
												value="${order.email}" />)</td>
										<td>
											<!-- 단독 구매 시 "상품명" / 2개 이상일 시 수량 표시 --> <c:choose>
												<c:when test="${order.count == 1}">
													<c:out value="${order.merchandiseName}" />
												</c:when>
												<c:otherwise>
													<c:out value="${order.merchandiseName}" /> 외 <c:out
														value="${order.count-1}" />건
														</c:otherwise>
											</c:choose>
										</td>
										<td><fmt:formatNumber value="${order.totalPrice}"
												pattern="#,###" /></td>
										<td><c:out value="${order.state}" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>



						<div class='pull-right'>
							<ul class="pagination">

								<c:if test="${pageMaker.prev}">
									<li class="paginate_button previous"><a
										href="${pageMaker.startPage -1}">Previous</a></li>
								</c:if>

								<c:forEach var="num" begin="${pageMaker.startPage}"
									end="${pageMaker.endPage}">
									<li class="paginate_button  ${pageMaker.cri.pageNum == num ? "active":""} ">
										<a href="${num}">&nbsp;${num}</a>
									</li>
								</c:forEach>

								<c:if test="${pageMaker.next}">
									<li class="paginate_button next"><a
										href="${pageMaker.endPage +1 }">Next</a></li>
								</c:if>


							</ul>
						</div>
						<!--  end Pagination -->

						<form id='actionForm' action="/admin/order/orderMain" method='get'>
							<input type='hidden' name='pageNum'
								value='${pageMaker.cri.pageNum}'> <input type='hidden'
								name='amount' value='${pageMaker.cri.amount}'> <input
								type='hidden' name='type'
								value='<c:out value="${ pageMaker.cri.type }"/>'> <input
								type='hidden' name='keyword'
								value='<c:out value="${ pageMaker.cri.keyword }"/>'>
						</form>

					</div>
				</div>
			</div>


		</div>
		<!-- /.container-fluid -->

	</div>
	<!-- End of Main Content -->
	<script>
		$(document) .ready( function() {
			// 체크박스 전체 체크 하기
			$("#checkAll").click(function() {
				var check = $('#checkAll').prop("checked");
				if (check) {
					$(".checkEach").prop("checked", true);
				} else {
					$(".checkEach").prop("checked", false);
				}
			});

			// 개별 체크 해제 시 전체 체크 해제
			$(".checkEach").click(function() {
				$("#checkAll").prop("checked", false);
			});

			var actionForm = $("#actionForm");

			$(".paginate_button a").on("click",function(e) {

				e.preventDefault();

				console.log('click');

				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();
			});

			// 주문 상세로 이동
			$(".move").on("click",function(e) {

				e.preventDefault();
				actionForm.append
				("<input type='hidden' name='id' value='"+ $(this).attr("href")+ "'>");
				
				actionForm.attr("action","/admin/order/orderDetail");
				actionForm.submit();

			});

			// 검색창
			var searchForm = $("#searchForm");

			$("#searchForm button").on("click",function(e) {

				if (!searchForm.find("option:selected").val()) {
					
					alert("검색종류를 선택하세요");
					return false;
				}

				if (!searchForm.find("input[name='keyword']").val()) {
					alert("키워드를 입력하세요");
					return false;
				}

				searchForm.find("input[name='pageNum']").val("1");
					
				e.preventDefault();

				searchForm.submit();

			});
			
			
			// 상태 변경
			$("#stateBtn").click(function() {

				var confirm_val = confirm("선택된 항목을 변경하시겠습니까?");
				if (confirm_val) {
				
				var rowData = new Array();
				var orderIdArr = new Array();
				var checkbox = $("input[name=checkEach]:checked");
				
				var selected = $("#orderState option:selected").val();
				
				// 체크된 체크박스 값을 가져온다
				checkbox.each(function(i) {
					// checkbox.parent() : checkbox의 부모는 <td>이다.
					// checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
					var tr = checkbox.parent().parent().eq(i);
					var td = tr.children();
				
					// 체크된 row의 모든 값을 배열에 담는다.
					rowData.push(tr.text());
				
					// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
					// var no = td.eq(1).text();
					var orderId = td.eq(3).text().trim();
				
					// 가져온 값을 배열에 담는다.
					orderIdArr.push(orderId);

			    });
				
				// 배열로 돌려서 상태변경 처리
				for(var i=0; i<orderIdArr.length; i++) {
					
					console.log(orderIdArr[i]);
					stateChange(orderIdArr[i]);
				}
				
				// 상태변경 함수
				function stateChange(orderId) {
					  
					  var data = {
								state : selected,
								id : orderId
							}
					  
					  return $.ajax({
							url: "/admin/order/stateChange",
							type: "POST",
							data: JSON.stringify(data),
							contentType: "application/json",
						    success : function(){
						    	
						    	location.href = "/admin/order/orderMain";
						    	console.log("성공")},
							error : function(){
								console.log("실패")
								alert("주문 상태 변경에 실패하였습니다.")}
					  }); 
					  
				  }
				}
				
			});
			
			 
			
	});
	</script>

	<%@include file="../../includes/admin_footer.jsp"%>