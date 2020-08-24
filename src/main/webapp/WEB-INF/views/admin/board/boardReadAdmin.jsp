<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../../includes/admin_header.jsp"%>

<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
    
        
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

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

		
<div class="container">
	<div class="panel-body">

		<div class="form-group">
			<input type='hidden' id='boardId' value='${board.id }'> <input
				type='hidden' id='userId' value='${principal.id}'> <input
				class="form-control" name='title'
				value='<c:out value="${board.title }"/>' readonly="readonly">
		</div>
		<div class="form-group">
			<input name='nickname' value='<c:out value="${board.nickname }"/>'
				readonly="readonly">
		</div>
		<div class="form-group">
			<input name='writtenAt'
				value='<fmt:formatDate  value="${board.writtenAt }"/>'
				readonly="readonly"> <label>조회</label> <input name='viewCnt'
				value='<c:out value="${board.viewCnt }"/>' readonly="readonly">
		</div>
		<hr>
		<c:if test="${board.typeId == 4}">
			<div>
			<h>수강 클래스 : </h>
		<strong><p><c:out value="${board.lessonTitle}"/></p></strong>	<br>
						<lable>강의 만족도</lable>
				<p id="lesson_star_rate">
					<a href="#" id="star1">★</a> <a href="#" id="star2">★</a> <a
						href="#" id="star3">★</a> <a href="#" id="star4">★</a> <a href="#"
						id="star5">★</a>
				</p>
				<input type='hidden' name='lessonReview'
					value='<c:out value="${board.lessonReview}"/>'>

				<lable>강사 만족도</lable>
				<p id="teacher_star_rate">
					<a href="#" id="star1">★</a> <a href="#" id="star2">★</a> <a
						href="#" id="star3">★</a> <a href="#" id="star4">★</a> <a href="#"
						id="star5">★</a>
				</p>
				<input type='hidden' name='teacherReview'
					value='<c:out value="${board.teacherReview}"/>'>


			</div>

		</c:if>
		<div class="form-group">
			<textarea class="form-control" id='content' rows="10" name='content'
				readonly="readonly"><c:out value="${board.content }" />
			</textarea>
		</div>

		<div class="form-group">
			<input type="hidden" id="isLike" value="false"> <input
				type="hidden" id="likeCnt" value="${board.likeCnt }" /> <a
				class='likeCnt' href='<c:out value="${board.likeCnt }"/>'> ♡ 좋아요
				<c:out value="${board.likeCnt }" />
			</a> <a class='commentCnt' href='<c:out value="${board.commentCnt }"/>'>댓글
				<c:out value="${board.commentCnt }" />
			</a>
		</div>

		<button data-oper='write' class="btn btn-info"
			onclick="location.href='/board/write?typeId=<c:out value="${board.typeId}"/>&id=<c:out value="${board.id}"/>&pid=<c:out value="${board.parentId}"/>&boardOrder=<c:out value="${board.boardOrder}"/>'">답글쓰기</button>

		<c:if test="${principal.id eq board.writerId}">
			<button data-oper='update' class="btn btn-default"
				onclick="location.href='/board/update?id=<c:out value="${board.id}"/>'">수정</button>
		</c:if>
		<button data-oper='list' class="btn btn-info"
			onclick="location.href='/board/list?typeId='${board.typeId}">목록</button>

		<form id='operForm' action="/board/modify" method="get">
			<input type='hidden' id='id' name='id'
				value='<c:out value="${board.id }"/>'> <input type='hidden'
				name='pageNum' value='<c:out value="${cri.pageNum }"/>'> <input
				type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
			<input type='hidden' name='keyword'
				value='<c:out value="${cri.keyword }"/>'> <input
				type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
			<input type='hidden' name='typeId'
				value='<c:out value="${board.typeId }"/>'>
		</form>
	</div>

	<!-- 댓글  -->
	<input type='hidden' name='replyNickname' id='replyNickname'
		value='${principal.nickname}'>
	<div class="container">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> 댓글
			</div>

			<div class="panel-body">
				<ul class="chat">
					<li><strong class="primary-font">user00</strong> <small
						class="pull-right text-muted">2020-07-03</small> <pre>Good job!</pre>
					</li>
				</ul>

				<!-- 댓글입력 -->
				<div>
					<textarea id="commentContent" name='comment'
						placeholder='댓글을 남겨보세요'></textarea>
					<button id="registerCommentBtn">등록</button>
				</div>
			</div>
			<input type="hidden" id="targetUser" name="targetUser"
				value="<sec:authentication property="principal.nickname"/>" />
		</div>
	</div>

</div>

	<!-- Footer -->
	<footer class="sticky-footer bg-white">
		<div class="container my-auto">
			<div class="copyright text-center my-auto">
				<span>Copyright &copy; Your Website 2020</span>
			</div>
		</div>
	</footer>
	<!-- End of Footer -->

</div>
<!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top"> <i
	class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">Select "Logout" below if you are ready
				to end your current session.</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
				<a class="btn btn-primary" href="login.html">Logout</a>
			</div>
		</div>
	</div>
</div>

<!-- Bootstrap core JavaScript-->
 <script src="/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/resources/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<!-- 	<script src="/resources/vendor/datatables/js/jquery.dataTables.min.js"></script>
	<script
		src="/resources/vendor/datatables/js/dataTables.bootstrap4.min.js"></script>
 -->
<!-- Page level custom scripts -->
<!-- 
<script src="/resources/js/demo/datatables-demo.js"></script> -->

<script type="text/javascript">
	$(document).ready(function() {

		var $boardId = $("#boardId");
		var $userId = $("#userId");
		var $isLike = $("#isLike");
		var likeData = {
				userId : $userId.val(),
				boardId : $boardId.val()
			};
		var $lessonReview = $("input[name=lessonReview]");
		var $teacherReview = $("input[name=teacherReview]");
	   
		lessonReview = $lessonReview.val();
		teacherReview = $teacherReview.val(); 
		
		
		//기존 별점 출력
		for(var i=1; i<=lessonReview;i++){
			 $('#lesson_star_rate').children('#star'+i).addClass("lessonOn");
			}
	    for(var i=1; i<=teacherReview;i++){
	      $('#teacher_star_rate').children('#star'+i).addClass("teacherOn");
	       }
		  
	
		isLike(likeData)
		.then(function(response){
			// 좋아요 상태 반영
			$isLike.val(response);
		})
		.then(function(response){
			// 좋아요 수 반영
			return countLike($boardId.val());
		})
		.then(function(response){
			// 좋아요 그리기(채워진/빈 하트)
			drawLikeCnt(response);
		})
		.catch(function(error){
			console.log(error);
		});
		
		// 파일 리스트 가져와서 보여주기
		var boardId = '<c:out value="${board.id}"/>';
		(function() {

			$.getJSON("/boards/getFileList", {
				boardId : boardId
			}, function(arr) {
				console.log(arr);
				
				var str = "";
				
				$(arr).each(function(i, file){
					
					//image type
					if(file.fileType){
						var fileCallPath = encodeURIComponent(file.uploadPath+"/s_"+file.uuid+"_"+file.fileName);
						
						str += "<li data-path='"+file.uploadPath+"' data-uuid='"+file.uuid+"' data-filename='"+file.fileName+"'";
						str += "data-type='"+file.fileType+"'><div>";
						str += "<img src='/file/display?fileName="+fileCallPath+"'>";
						str += "</div></li>";
					} else {
						str += "<li data-path='"+file.uploadPath+"' data-uuid='"+file.uuid+"' data-filename='"+file.fileName+"'";
						str += "data-type='"+file.fileType+"'><div>";
						str += "<img src='/resources/img/attach.png'>";
						str += "</div></li>";
					}
				});
				$(".uploadResult ul").html(str);
			});
		})();
		

		var $content = $('#content');
		
		//서머노트 툴바 삭제
		$content.summernote('code', $content.val());
		$("div[class*=toolbar]").css("display", "none");
		$("div[class*=note-editable]").attr("contenteditable", "false");

		// 업로드 결과 보여주기
		$(".uploadResult").on("click", "li", function(e){
			console.log("view image");
			
			var liObj = $(this);
			
			var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
			
			if(liObj.data("type")){
				showImage(path.replace(new RegExp(/\\/g),"/"));
			} else {
				self.location = "/file/download?fileName="+path;
			}
		});
		
		//이미지 확대
		function showImage(fileCallPath){
			alert(fileCallPath);
			$(".bigPictureWrapper").css("display","flex").show();
			$(".bigPicture")
			.html("<img src='/file/display?fileName="+fileCallPath+"'>")
			.animate({width:'100%', height:'100%'}, 1000);	
		}
		
	
		 //삭제버튼 클릭시
		$("#delete").click(function(){
			var boardId = getChecked();
			boardDeleteApi(boardId)			
				
			});
		
		// 파일 리스트 가져와서 보여주기
		var boardId = '<c:out value="${board.id}"/>';
		(function() {

			$.getJSON("/boards/getFileList", {
				boardId : boardId
			}, function(arr) {
				console.log(arr);
				
				var str = "";
				
				$(arr).each(function(i, file){
					
					//image type
					if(file.fileType){
						var fileCallPath = encodeURIComponent(file.uploadPath+"/s_"+file.uuid+"_"+file.fileName);
						
						str += "<li data-path='"+file.uploadPath+"' data-uuid='"+file.uuid+"' data-filename='"+file.fileName+"'";
						str += "data-type='"+file.fileType+"'><div>";
						str += "<img src='/file/display?fileName="+fileCallPath+"'>";
						str += "</div></li>";
					} else {
						str += "<li data-path='"+file.uploadPath+"' data-uuid='"+file.uuid+"' data-filename='"+file.fileName+"'";
						str += "data-type='"+file.fileType+"'><div>";
						str += "<img src='/resources/img/attach.png'>";
						str += "</div></li>";
					}
				});
				$(".uploadResult ul").html(str);
			});
		})();
		

		var $content = $('#content');
		
		//서머노트 툴바 삭제
		$content.summernote('code', $content.val());
		$("div[class*=toolbar]").css("display", "none");
		$("div[class*=note-editable]").attr("contenteditable", "false");

		// 업로드 결과 보여주기
		$(".uploadResult").on("click", "li", function(e){
			console.log("view image");
			
			var liObj = $(this);
			
			var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
			
			if(liObj.data("type")){
				showImage(path.replace(new RegExp(/\\/g),"/"));
			} else {
				self.location = "/file/download?fileName="+path;
			}
		});
		
		//이미지 확대
		function showImage(fileCallPath){
			alert(fileCallPath);
			$(".bigPictureWrapper").css("display","flex").show();
			$(".bigPicture")
			.html("<img src='/file/display?fileName="+fileCallPath+"'>")
			.animate({width:'100%', height:'100%'}, 1000);	
		}
		
		var operForm = $("#operForm");

		// 버튼 클릭할때 operForm 전송
		$("button[data-oper='update']").on("click", function(e) {
			operForm.attr("action", "/board/update").submit();
		});

		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#id").remove();
			operForm.attr("action", "/board/list")
			operForm.submit();
		});
		
		//삭제
		function boardDeleteApi(data){
  		  return $.ajax({
  		    url: "/admin/board",
  		    type: "Delete",
  		    data: JSON.stringify(data),
  		    contentType: "application/json",
  		    success : 
  		    	location.href = "/admin/board/boardAdminList"
  		  	  });
  		}

	
		
		// 좋아요 수
		function countLike(id) {
			return $.ajax({
				type : "GET",
				url : '/boards/like/' + id,
				contentType : "application/json; charset=utf-8;"
			});
		}
		
		// 댓글 수 구하기
		function countComments(id) {
			return $.ajax({				
				type: 'GET',
				url: '/boards/comments/' + id,
				contentType : "application/json; charset=utf-8;"
			});
		}
		$pageBtn = $(".paging");
		$tbody = $("tbody");

		$pageBtn.on().click(function(e){
			// active 관련은 나중에 없앨 수도 있음
			$pageBtn.parent().removeClass("active")
			e.preventDefault();
			var $target = e.target
			console.log($target);
			$target.parentNode.setAttribute("class", "active");
			var pageNum = $target.text;
			getBoardList(pageNum)
			.then(function(response){
				console.log(response);
				drawMyBoardList(response);
			})
			.catch(function(error){
				console.log(error);
			});
		});
		
		function getBoardList(pageNum){
				return $.ajax({
				type : "GET",
				url : "/admin/board/pageNum/"+pageNum,
				contentType : "application/json"
			});
		};
		
		function drawMyBoardList(boardList){
			console.log(boardList);
			$tbody.html("");
			var fragment = document.createDocumentFragment();
			for(var i = 0; i<boardList.length; i++){
				var board = boardList[i];
				var str = "";
				var tr = document.createElement("tr");
				str += "<td><input type='checkbox' id='checkOne' name='checkOne'></td>"
				str += "<td>"+board.id+"</td>";
				str += "<td><a class='read' href='/board/read?id="+board.boardId+"'>"+board.title+"</a></td>";
				str += "<td>"+board.nickname+"</td>"
				var writtenAt = board.writtenAt
				var date = new Date(writtenAt);
				str += "<td>"+formatDate(date)+"</td>"
				str += "<td>"+board.viewCnt+"</td>"
			tr.innerHTML += str;
			fragment.appendChild(tr);	
			}
			$tbody.append($(fragment));
		};
		
	      function formatDate(date) { 
	          var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear(); 
	          if (month.length < 2) month = '0' + month; 
	          if (day.length < 2) day = '0' + day; 
	          return [year, month, day].join('-'); };
	
		

	});
	
</script>




</body>

</html>
