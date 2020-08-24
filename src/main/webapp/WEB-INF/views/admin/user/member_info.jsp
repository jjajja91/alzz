<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.thoughtworks.qdox.parser.ParseException"%>
<%@include file="../../includes/admin_header.jsp"%>
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
	
		<div class="container-fluid">
			<br> <br>
			<div
				class="d-sm-flex align-items-center justify-content-between mb-4">
				<h1 class="h3 mb-2 text-gray-800">회원 정보 검색</h1>
			</div>
			<div class="card shadow mb-4">
				<div class="card shadow mb-4">
					<div class="card-body">
						<div class="table-responsive">
							<div>
								<center>
									<br> <br>
									<table class="table table-bordered" id="dataTable" width="100%"
										cellspacing="0">
										<center>
											<!-- 회원의 아이디를 입력하면 해당 회원에 정보가 하단에 출력되게 함 -->
											<form action="find_member" method="post">
												<span style="color: black; font-weight: bold;"><h3>회원
														정보</h3></span> <br> <br>
												<div class="col-lg-3">
													<input type="text" name="email" placeholder="이메일을 입력하세요."
														class="form-control"><br>
												</div>
												<button type="submit" name="submit"
													class="btn btn-primary btn-sm">확인</button>
												&nbsp;&nbsp;
												<button type="button" id=adminHomeBtn
													class="btn btn-primary btn-sm">관리자 홈으로</button>
												<br> <br>
											</form>
										</center>
									</table>
								</center>


								<c:if test="${map.list != null}">
									<center>
										<span style="color: black; font-weight: bold;">해당하는 회원
											정보</span> <br> <br>
										<table border="1" width="500px" class="table-hover">
											<div class="card align-middle"
												style="width: 50rem; border-radius: 20px;">
												<div class="card-body">
													<div style="text-align: center;">
														<center>
															<c:forEach var="member" items="${map.list}">
																<!-- 컨트롤러에서 넘어온 map의 값 -->
																<span style="color: black; font-weight: bold;">이메일
																	:</span>
																<span style="color: blue; font-weight: bold;">${member.email}</span>
																<br>
																<br>

																<span style="color: black; font-weight: bold;">닉네임
																	:</span>
																<span style="color: blue; font-weight: bold;">${member.nickname}</span>
																<br>
																<br>

																<span style="color: black; font-weight: bold;">전화번호
																	:</span>
																<span style="color: blue; font-weight: bold;">${member.phoneNumber}</span>
																<br>
																<br>
															</c:forEach>
														</center>
													</div>
												</div>
											</div>
										</table>
									</center>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 회원정보에 없는 아이디를 입력할 시에 출력되는 경고창 -->
	<script>
		$(function() {
			var responseMessage = "<c:out value="${message}" />";
			if (responseMessage != "") {
				alert(responseMessage)
			}
		})

		$(function() {
			$("#adminHomeBtn").click(function() {
				location.href = '/admin/index';
			})
		})
	</script>
	<%@include file="../../includes/admin_footer.jsp"%>