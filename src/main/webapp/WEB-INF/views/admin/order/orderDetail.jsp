<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../includes/admin_header.jsp"%>
<style>
img.lessonImg {
	width: 100px;
	height: 100px;
}

</style>
<!-- Content Wrapper -->
<div id="content-wrapper" class="d-flex flex-column">

	<!-- Main Content -->
	<div id="content">

		<!-- Begin Page Content -->
		<div class="container-fluid">

			<!-- Page Heading -->
			<div
				class="d-sm-flex align-items-center justify-content-between mb-4">
				<h1 class="h3 mb-2 text-gray-800">주문 상세정보</h1>
				<a href="#"
					class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"
					data-toggle="modal" data-target="#logoutModal"><i
					class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i> Log
					out</a>
			</div>
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h4 class="m-0 font-weight-bold text-primary">주문번호 :
						${orderId}</h4>
				</div>

				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr>
									<td colspan="3"
										style="color: #4e73df; font-weight: 700;">상품정보</td>
								</tr>
							</thead>
							<tbody>
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
										<td>${list.name }<br> <fmt:formatNumber
												value="${list.salePrice}" pattern="#,###" /> 원
										</td>
										<td>결제 완료</td>
									</tr>
									<c:set var="finalTotalPrice"
										value="${finalTotalPrice + list.salePrice}" />
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>

			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">주문 정보</h6>
				</div>

				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="50%"
							cellspacing="0">
							<thead>
								<tr>
									<td>이름</td>
									<td>${orderer.name}</td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>연락처</td>
									<td>${orderer.phone}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">결제 정보</h6>
					</div>

					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-bordered" id="dataTable" width="100%"
								cellspacing="0">
								<thead>
									<tr>
										<td>결제 방법</td>
										<td>카카오 페이</td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>결제 금액</td>
										<td><fmt:formatNumber value="${finalTotalPrice}"
												pattern="#,###" /> 원</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>



		</div>
		<!-- /.container-fluid -->

	</div>
	<!-- End of Main Content -->

	<%@include file="../../includes/admin_footer.jsp"%>