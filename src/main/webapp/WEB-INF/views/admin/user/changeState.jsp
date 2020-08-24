<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id"
	content="576736845363-o0474pib5q69qlcv6lm7o42hs6lu5u59.apps.googleusercontent.com">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<%@include file="../../includes/admin_header.jsp"%>

<!-- Content Wrapper -->
<div id="content-wrapper" class="d-flex flex-column">

	<!-- Main Content -->
	<div id="content">
	
		<!-- Topbar -->
		<nav
			class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

			<!-- Sidebar Toggle (Topbar) -->
			<form class="form-inline">
				<button id="sidebarToggleTop"
					class="btn btn-link d-md-none rounded-circle mr-3">
					<i class="fa fa-bars"></i>
				</button>
			</form>

			<!-- Topbar Search -->
			<form
				class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
				<div class="input-group">
					<input type="text" class="form-control bg-light border-0 small"
						placeholder="Search for..." aria-label="Search"
						aria-describedby="basic-addon2">
					<div class="input-group-append">
						<button class="btn btn-primary" type="button">
							<i class="fas fa-search fa-sm"></i>
						</button>
					</div>
				</div>
			</form>

			<!-- Topbar Navbar -->
			<ul class="navbar-nav ml-auto">

				<!-- Nav Item - Search Dropdown (Visible Only XS) -->
				<li class="nav-item dropdown no-arrow d-sm-none"><a
					class="nav-link dropdown-toggle" href="#" id="searchDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
				</a> <!-- Dropdown - Messages -->
					<div
						class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
						aria-labelledby="searchDropdown">
						<form class="form-inline mr-auto w-100 navbar-search">
							<div class="input-group">
								<input type="text" class="form-control bg-light border-0 small"
									placeholder="Search for..." aria-label="Search"
									aria-describedby="basic-addon2">
								<div class="input-group-append">
									<button class="btn btn-primary" type="button">
										<i class="fas fa-search fa-sm"></i>
									</button>
								</div>
							</div>
						</form>
					</div></li>

				<!-- Nav Item - Alerts -->
				<li class="nav-item dropdown no-arrow mx-1"><a
					class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <i class="fas fa-bell fa-fw"></i> <!-- Counter - Alerts -->
						<span class="badge badge-danger badge-counter">3+</span>
				</a> <!-- Dropdown - Alerts -->
					<div
						class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
						aria-labelledby="alertsDropdown">
						<h6 class="dropdown-header">Alerts Center</h6>
						<a class="dropdown-item d-flex align-items-center" href="#">
							<div class="mr-3">
								<div class="icon-circle bg-primary">
									<i class="fas fa-file-alt text-white"></i>
								</div>
							</div>
							<div>
								<div class="small text-gray-500">December 12, 2019</div>
								<span class="font-weight-bold">A new monthly report is
									ready to download!</span>
							</div>
						</a> <a class="dropdown-item d-flex align-items-center" href="#">
							<div class="mr-3">
								<div class="icon-circle bg-success">
									<i class="fas fa-donate text-white"></i>
								</div>
							</div>
							<div>
								<div class="small text-gray-500">December 7, 2019</div>
								$290.29 has been deposited into your account!
							</div>
						</a> <a class="dropdown-item d-flex align-items-center" href="#">
							<div class="mr-3">
								<div class="icon-circle bg-warning">
									<i class="fas fa-exclamation-triangle text-white"></i>
								</div>
							</div>
							<div>
								<div class="small text-gray-500">December 2, 2019</div>
								Spending Alert: We've noticed unusually high spending for your
								account.
							</div>
						</a> <a class="dropdown-item text-center small text-gray-500" href="#">Show
							All Alerts</a>
					</div></li>

				<!-- Nav Item - Messages -->
				<li class="nav-item dropdown no-arrow mx-1"><a
					class="nav-link dropdown-toggle" href="#" id="messagesDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <i class="fas fa-envelope fa-fw"></i> <!-- Counter - Messages -->
						<span class="badge badge-danger badge-counter">7</span>
				</a> <!-- Dropdown - Messages -->
					<div
						class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
						aria-labelledby="messagesDropdown">
						<h6 class="dropdown-header">Message Center</h6>
						<a class="dropdown-item d-flex align-items-center" href="#">
							<div class="dropdown-list-image mr-3">
								<img class="rounded-circle"
									src="https://source.unsplash.com/fn_BT9fwg_E/60x60" alt="">
								<div class="status-indicator bg-success"></div>
							</div>
							<div class="font-weight-bold">
								<div class="text-truncate">Hi there! I am wondering if you
									can help me with a problem I've been having.</div>
								<div class="small text-gray-500">Emily Fowler · 58m</div>
							</div>
						</a> <a class="dropdown-item d-flex align-items-center" href="#">
							<div class="dropdown-list-image mr-3">
								<img class="rounded-circle"
									src="https://source.unsplash.com/AU4VPcFN4LE/60x60" alt="">
								<div class="status-indicator"></div>
							</div>
							<div>
								<div class="text-truncate">I have the photos that you
									ordered last month, how would you like them sent to you?</div>
								<div class="small text-gray-500">Jae Chun · 1d</div>
							</div>
						</a> <a class="dropdown-item d-flex align-items-center" href="#">
							<div class="dropdown-list-image mr-3">
								<img class="rounded-circle"
									src="https://source.unsplash.com/CS2uCrpNzJY/60x60" alt="">
								<div class="status-indicator bg-warning"></div>
							</div>
							<div>
								<div class="text-truncate">Last month's report looks
									great, I am very happy with the progress so far, keep up the
									good work!</div>
								<div class="small text-gray-500">Morgan Alvarez · 2d</div>
							</div>
						</a> <a class="dropdown-item d-flex align-items-center" href="#">
							<div class="dropdown-list-image mr-3">
								<img class="rounded-circle"
									src="https://source.unsplash.com/Mv9hjnEUHR4/60x60" alt="">
								<div class="status-indicator bg-success"></div>
							</div>
							<div>
								<div class="text-truncate">Am I a good boy? The reason I
									ask is because someone told me that people say this to all
									dogs, even if they aren't good...</div>
								<div class="small text-gray-500">Chicken the Dog · 2w</div>
							</div>
						</a> <a class="dropdown-item text-center small text-gray-500" href="#">Read
							More Messages</a>
					</div></li>

				<div class="topbar-divider d-none d-sm-block"></div>

				<!-- Nav Item - User Information -->
				<li class="nav-item dropdown no-arrow"><a
					class="nav-link dropdown-toggle" href="#" id="userDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <span
						class="mr-2 d-none d-lg-inline text-gray-600 small">Valerie
							Luna</span> <img class="img-profile rounded-circle"
						src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
				</a> <!-- Dropdown - User Information -->
					<div
						class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
						aria-labelledby="userDropdown">
						<a class="dropdown-item" href="#"> <i
							class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> Profile
						</a> <a class="dropdown-item" href="#"> <i
							class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i> Settings
						</a> <a class="dropdown-item" href="#"> <i
							class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i> Activity
							Log
						</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#" data-toggle="modal"
							data-target="#logoutModal"> <i
							class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
							Logout
						</a>
					</div></li>

			</ul>

		</nav>
		<!-- End of Topbar -->
	
		<!-- Begin Page Content -->
		<div class="container-fluid">
		
			<!-- Page Heading -->
			<h1 class="h3 mb-2 text-gray-800">회원 상태 변경</h1>
			
			<!-- DataTales Example -->
			<div class="card shadow mb-4">
			<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">Decision in Progress</h6>
				</div>
					<div class="card-body">
						<div class="table-responsive">
							<div>
								<form name="form" method="post">
									<table class="table table-bordered" id="dataTable">
										<div class="card-body">
											<br> <span style="color: black; font-weight: bold;">회원
												이메일</span><br> <br> <input type="text" name="email"
												style="width: 300px;"
												placeholder="상태 혹은 권한을 변환 시킬 회원의 이메일 입력 "
												class="form-control"> <br> <br> <input
												type="button" value="탈퇴" id="btnDropOut"> <input
												type="button" value="정지" id="btnSuspended"> <input
												type="button" value="휴면" id="btnInactive"> <input
												type="button" value="일반상태" id="btnBackNormal"><br>
											<br> <input type="button" value="일반계정" id="btnAsUser">
											<input type="button" value="관리자계정" id="btnAsManager"><br>
										</div>
									</table>
								</form>
							</div>
						</div>
					</div>
			</div>
		</div>
	</div>
	<!-- 로그인 실패나 성공시 메시지를 받아서 출력하는 자바스크립트 구문 -->
	<script>
		$(document).ready(function() {
			$("#btnDropOut").click(function() {
				// 확인 대화상자	
				if (document.form[0].value == "") {
					alert("이메일을 입력해주세요");
				} else if (confirm("해당 계정을 탈퇴 시키겠습니까?")) {
					document.form.action = "${path}/admin/dropOut";
					document.form.submit();

				}
			});
			$("#btnSuspended").click(function() {
				// 확인 대화상자
				if (document.form[0].value == "") {
					alert("이메일을 입력해주세요");
				} else {
					if (confirm("해당 계정을 정지 시키겠습니까?")) {
						document.form.action = "${path}/admin/suspended";
						document.form.submit();
					}
				}
			});
			$("#btnInactive").click(function() {
				// 확인 대화상자	
				if (document.form[0].value == "") {
					alert("이메일을 입력해주세요");
				} else {
					if (confirm("해당 계정을 휴면전환 시키겠습니까?")) {
						document.form.action = "${path}/admin/inactive";
						document.form.submit();
					}
				}
			});
			$("#btnBackNormal").click(function() {
				// 확인 대화상자	
				if (document.form[0].value == "") {
					alert("이메일을 입력해주세요");
				} else {
					if (confirm("해당 계정을 일반상태로 전환 시키겠습니까?")) {
						document.form.action = "${path}/admin/backNormal";
						document.form.submit();
					}
				}
			});
			$("#btnAsUser").click(function() {
				// 확인 대화상자	
				if (document.form[0].value == "") {
					alert("이메일을 입력해주세요");
				} else {
					if (confirm("해당 계정을 일반 계정으로 전환 시키겠습니까?")) {
						document.form.action = "${path}/admin/asUser";
						document.form.submit();
					}
				}
			});
			$("#btnAsManager").click(function() {
				// 확인 대화상자	
				if (document.form[0].value == "") {
					alert("이메일을 입력해주세요");
				} else {
					if (confirm("해당 계정을 관리자 계정으로 전환 시키겠습니까?")) {
						document.form.action = "${path}/admin/asManager";
						document.form.submit();
					}
				}
			});
		});
		$(function() {
			$("#adminHomeBtn").click(function() {
				location.href = '/admin/index';
			})
		})
	</script>
	<%@include file="../../includes/admin_footer.jsp"%>