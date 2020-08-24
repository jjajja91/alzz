<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@include file="../includes/header.jsp"%>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
</head>
<style>
.container {
	width: 100%;
    max-width: 100%;
    display: flex;
    margin: 0 auto;
    justify-content: center;
    padding-top: 200px;
}
.boardNameDiv {
    background: beige;
    writing-mode: vertical-lr;
    text-align: center;
    inline-size: 400px;
    font-size: 70px;
    padding: 70px;
    letter-spacing: 10px;
    font-weight: 500;
}
.panel-body {
    padding-left: 50px;
}

.note-resizebar {
	display:none;
}
.titleDiv {
	font-size: 20px;
}
.form-group2 {
    font-size: 13px;
    margin-bottom: 5px;
    color: #585858;
}

.form-group3 {
    padding-left: 20px;
}
.form-group4 {
    margin-bottom: 20px;
}
.form-group5 {
    text-align: right;
}
.userIcon {
    width: 15px;
    opacity: 50%;
    margin-right: 5px;
}
.likeCnt, .commentCnt {
    padding: 8px;
    color: #585858;
}
.likeCnt:hover, .commentCnt:hover {
	color:#585858;
	text-decoration: none;
}
.redText {
    color: red;
}
.btn-info {
    background: #335492;
    font-size: 15px;
}
.btn-default {
	background: darkgrey;
    font-size: 15px;
}
.commentDiv {
   width: inherit;
    position: relative;
}
.commentDropBtn {
    font-weight: bold;
    border: none;
    background-color: transparent;
   position: absolute;
    left: 95%;
   top: 0;
}
#replyTextarea, #textAreaEdit {
   width : 80%;
   resize: none;
   padding: 10px;
   margin-right: 10px;
}
#textAreaEdit {
   width : 80%;
   resize: none;
}
#commentContent {
   width : 90%;
   resize: none;
   padding: 10px;
   margin-right: 10px;
}
.chat, .chat li{
   padding-left: 0px;
   list-style :none;
    text-align: -webkit-match-parent;
    
}
.chat ul {
    padding-inline-start: 40px;
}

.panel-heading {
    padding: 10px;
    background: #eee;
    border-radius: 5px;
}
.panel-body2 {
    padding-top: 20px;
}
.preContent {
    border: none;
    background: none;
    padding: 5px;
    font-size : 100%;
    font-family: 'Open Sans', 'Noto Sans KR', sans-serif;
    font-weight: 100;
}
.commentDate {
    font-size: 14px;
    padding-top: 10px;
}
.coCommentBtn {
    padding: 3px;
    border: solid 1px;
}
.coCommentBtn:hover {
    cursor: pointer;
}
.btn-info:hover {
	background: #335492;
}
.replyDiv, .commentEditDiv, .comment {
	padding-top:10px;
    display: flex;
}
.reCommentRegBtn, .reCommentEditBtn, #registerCommentBtn {
    width: 65px;
    border: none;
    background: lightgray;
}
button.reCommentRegBtn, button#registerCommentBtn {
	vertical-align: middle;
	background-color: #335492;
	color: #ffffff;
	border: 1px solid #dddddd;
	background-color: #335492;
	padding: 6px 12px;
	border-radius: 5px 5px;
}
</style>
<body>

	<sec:authentication var="principal" property="principal" />
	
	<div class="container">
		<div class="boardNameDiv">
		   <h1 class="page-header">${boardName}</h1>
		</div>
		
		<div class="panel-body">

			<div class="form-group">
				<input type='hidden' id='boardId' value='${board.id }'> 
				<input type='hidden' id='userId' value='${principal.id}'> 
				<div class="titleDiv"><c:out value="${board.title }"/></div>
			</div>
			<div class="form-group2">
				<img class="userIcon" src="../../../../resources/img/마이.png"><c:out value="${board.nickname }"/>
			</div>
			<div class="form-group2 form-group3">
				<fmt:formatDate  value="${board.writtenAt }"/>
				<label>조회</label> <c:out value="${board.viewCnt }"/>
			</div>
			<hr>
			<c:if test="${board.typeId == 4}">
				<div>
					<h>수강 클래스 : </h>
					<strong><p><c:out value="${board.lessonTitle}" /></p></strong> 
					<br>
					<lable>강의 만족도</lable>
					<p id="lesson_star_rate">
						<a href="#" id="star1">★</a> 
						<a href="#" id="star2">★</a> 
						<a href="#" id="star3">★</a> 
						<a href="#" id="star4">★</a> 
						<a href="#" id="star5">★</a>
					</p>
					<input type='hidden' name='lessonReview' value='<c:out value="${board.lessonReview}"/>'>

					<lable>강사 만족도</lable>
					<p id="teacher_star_rate">
						<a href="#" id="star1">★</a> 
						<a href="#" id="star2">★</a> 
						<a href="#" id="star3">★</a> 
						<a href="#" id="star4">★</a> 
						<a href="#" id="star5">★</a>
					</p>
					<input type='hidden' name='teacherReview' value='<c:out value="${board.teacherReview}"/>'>
				</div>
			</c:if>
			<div class="form-group">
				<textarea class="form-control" id='content' rows="10" name='content'
					readonly="readonly"><c:out value="${board.content }" /></textarea>
			</div>

			<div class="form-group2 form-group4">
				<input type="hidden" id="isLike" value="false"> 
				<input type="hidden" id="likeCnt" value="${board.likeCnt }" /> 
				<a class='likeCnt' href='<c:out value="${board.likeCnt }"/>'><span class="redText">♡</span> 좋아요 <c:out value="${board.likeCnt }" /></a> 
				<a class='commentCnt' href='<c:out value="${board.commentCnt }"/>'>댓글 <c:out value="${board.commentCnt }" /> </a>
			</div>


			<div class="form-group4 form-group5">
				<button data-oper='write' class="btn btn-info" 
						onclick="location.href='/board/write?typeId=<c:out value="${board.typeId}"/>&id=<c:out value="${board.id}"/>&pid=<c:out value="${board.parentId}"/>&boardOrder=<c:out value="${board.boardOrder}"/>'">답글쓰기</button>
				<c:if test="${principal.id eq board.writerId}">
					<button data-oper='update' class="btn btn-default" onclick="location.href='/board/update?id=<c:out value="${board.id}"/>'">수정</button>
				</c:if>
				<button data-oper='list' class="btn btn-info" onclick="location.href='/board/list?typeId='${board.typeId}">목록</button>
			</div>

			<form id='operForm' action="/board/modify" method="get">
				<input type='hidden' id='id' name='id' value='<c:out value="${board.id }"/>'> 
				<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'> 
				<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
				<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'> 
				<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
				<input type='hidden' name='typeId' value='<c:out value="${board.typeId }"/>'>
			</form>

			<!-- 댓글  -->
			<input type='hidden' name='replyNickname' id='replyNickname' value='${principal.nickname}'>
			<div class="panel panel-default">
				<div class="panel-heading"> 댓글 </div>
	
				<div class="panel-body2">
					<ul class="chat">
						<li>
							<strong class="primary-font">user00</strong> 
							<small class="pull-right text-muted">2020-07-03</small> 
							<pre>Good job!</pre>
						</li>
					</ul>
	
					<!-- 댓글입력 -->
					<div class="comment">
						<textarea id="commentContent" name='comment' cols="70" rows="2" placeholder='댓글을 남겨보세요'></textarea>
						<button id="registerCommentBtn">등록</button>
					</div>
				</div>
				<input type="hidden" id="targetUser" name="targetUser" value="<sec:authentication property="principal.nickname"/>" />
			</div>
		
		</div>
	</div>


	<script type="text/javascript" src="/resources/js/comment.js"></script>

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

			$.getJSON("/boards/getFileList", { boardId : boardId }, function(arr) {
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

		// 댓글 리스트
		showComment();
		
		var commentUL = $(".chat");
		
		// 댓글 리스트
		function showComment(id) {
			if(id==null) {
				id = boardId;
			}
			commentService.getList({boardId:id}, function(list) {
				
				var str="";
				
				if(list==null || list.length==0) {
					commentUL.html("");
					return;
				}

				for(var i=0, len=list.length||0; i<len; i++) {
					str += " <li class='reChat'> "; 
					for(var j=0; j<list[i].depth; j++) {
						str += "<ul><li> ";
					}
						str += "		<div class='commentDiv'>";
					if(list[i].deleted=="Y" && list[i].commentCnt>=1) {
						str += " 			<p style='margin:auto'>삭제된 댓글입니다.</p>";
						str += "<hr> ";
					} else if(list[i].deleted=='N') {
						str += "			<img class='userIcon' src='../../../../resources/img/마이.png'>";
						str += "			<strong>"+list[i].nickname+"</strong>";
						if(list[i].userId == $userId.val() ) {
						str += "			<div class='commentDropdown'>";
						str += "				<button class='commentDropBtn' data-toggle='dropdown'>‥</button>";
						str += "				<ul class='dropdown-menu'>";
						str += "					<li><a class='commentEditBtn'>수정</a></li>";
						str += "					<li><a class='commentDeleteBtn'>삭제</a></li>";
						str += "				</ul>";
						str += "			</div>";
						}
						str += "			<pre class='preContent' style='margin:auto;'>"+list[i].content+"</pre>";
						str += "			<div class='commentDate'>" + moment(list[i].writtenAt).format('YYYY-MM-DD hh:mm');
						str += "			<a role='button' class='coCommentBtn'>답글쓰기</a></div>";
						str += "			<input type='hidden' class='commentId' id='commentId"+i+"' value='"+list[i].id+"'/>";
						str += "			<input type='hidden' class='commentDepth' id='commentDepth"+i+"' value='"+list[i].depth+"'/>";
						str += "			<input type='hidden' class='commentCnt' id='commentCnt"+i+"' value='"+list[i].commentCnt+"'/>";
						str += "<hr> ";
					}
						str += "		</div>";
					for(var j=0; j<list[i].depth; j++) {
						str += "	</li></ul>";
					}
					str += " </li>";
					
					
				}
				
				commentUL.html(str);
			});
		
		}
		
		// 댓글쓰기 버튼 이벤트
		$(document).on("click","a[class='coCommentBtn']", function(e){
			
			$(".replyDiv").remove();
			$(".commentEditDiv").remove();
			
			var commentDepth = $(this).parent().find(".commentDepth").val();
			if(commentDepth>9) {
				alert("댓글 차수를 초과하여 더 이상 대댓글을 등록할 수 없습니다!");
				return;
			}
			
			var replyDiv = document.createElement("div");
			replyDiv.setAttribute("class", "replyDiv");
			 
			var textArea = document.createElement("textarea");
			textArea.setAttribute("id", "replyTextarea");
			textArea.setAttribute("cols", "30");
			textArea.setAttribute("placeholder", "댓글을 입력해주세요");
			 
			var reCommentRegBtn = document.createElement("button");
			reCommentRegBtn.setAttribute("class", "reCommentRegBtn");
			reCommentRegBtn.innerHTML="등록";

			replyDiv.appendChild(textArea);
			replyDiv.appendChild(reCommentRegBtn);
			 
			e.target.after(replyDiv);
		});

		var $replyNickname = $("#replyNickname");
		var $commentContent = $('#commentContent');
		
		// 댓글 등록버튼 이벤트
		$("#registerCommentBtn").on("click", function(e) {
			
			var commentValue = {
					content : $commentContent.val(),
					boardId : boardId,
					nickname : $replyNickname.val(),
					userId : $userId.val()
			};
			
			// 댓글추가
			addComment(commentValue)
				.then(function(response) {
					// 댓글 리스트 새로고침
					showComment();
					// 입력창 빈칸으로 초기화
					$('#commentContent').val("");
				})
				.then(function(response){
					// 댓글 수 구하기
					return countComments($boardId.val());
				})
				.then(function(response){
					console.log(response);
					// 댓글 수 다시 그리기
					drawCommentCnt(response);
				})
				.catch(function(error) {
					var errorMessage = error.responseJSON.defaultMessage;
					console.log(error.responseJSON);
					alert(errorMessage);
					var errorFocus = error.responseJSON.field;
					$('#commentContent').focus();
				});
			
		})
		
		// 좋아요  수
		var $likeCnt = $(".likeCnt");
		// 댓글 수
		var $commentCnt = $(".commentCnt");
		
		$likeCnt.click(function(e){
			e.preventDefault();
			
			// 좋아요 상태가 true면
			if($isLike.val()=="true"){
				// 좋아요 제거
				removeLike(likeData)
				.then(function(response){
					return countLike($boardId.val());
				})
				.then(function(response){
					$isLike.val('false');
					drawLikeCnt(response);
				})
				.catch(function(error){
					console.log(error);
				});
			// 좋아요 상태가 false면
			} else {
				// 좋아요 추가
				addLike(likeData)
				.then(function(response){
					return countLike($boardId.val());
				})
				.then(function(response){
					$isLike.val('true');
					drawLikeCnt(response);
				})
				.catch(function(error){
					console.log(error);
				});
			}	
		})
		
		
		// 대댓글 등록 버튼 이벤트
		$(document).on("click","button[class='reCommentRegBtn']", function(e){
			
			var commentId = $(this).parent().parent().find(".commentId").val();
			var commentDepth = $(this).parent().parent().find(".commentDepth").val();
			var commentCnt = $(this).parent().parent().find(".commentCnt").val();
			
			var reCommentValue = { 
					id : commentId,
					content :  $('#replyTextarea').val(),
					commentCnt : commentCnt,
					boardId : boardId,
					nickname : $replyNickname.val(),
					depth : commentDepth,
					userId : $userId.val()
			}

			// 대댓글추가
			addReComment(reCommentValue)
				.then(function(response) {
					// 댓글 리스트 새로고침
					showComment();
				})
				.then(function(response){
					return countComments($boardId.val());
				})
				.then(function(response){
					console.log(response);
					drawCommentCnt(response);
				})
				.catch(function(error) {
					var errorMessage = error.responseJSON.defaultMessage;
					console.log(error.responseJSON);
					alert(errorMessage);
					var errorFocus = error.responseJSON.field;
					$('#replyTextarea').focus();
				});
			 
		})
		
		
		// 댓글  드랍다운 수정 클릭시 수정창 보여주기
		$(document).on("click","a[class='commentEditBtn']", function(e){

			e.preventDefault();
			// 숨겨둔 댓글 내용 보여줌
			commentUL.find('pre').css("display", "block");
			
			var commentId = $(this).parent().parent().parent().parent().find(".commentId").val();
			var commentPre = $(this).parent().parent().parent().parent().find("pre");
			var where= $(this).parent().parent().parent().parent().find("strong");
			
			// 수정할 댓글 내용 숨김
			commentPre.css("display", "none");
			
			// 수정창, 답댓글 입력창 지우기
			$(".commentEditDiv").remove();
			$(".replyDiv").remove();

			var commentEditDiv = document.createElement("div");
			commentEditDiv.setAttribute("class", "commentEditDiv");
			 
			var textAreaEdit = document.createElement("textarea");
			textAreaEdit.setAttribute("id", "textAreaEdit");
			textAreaEdit.innerHTML = commentPre.html();
			 
			var reCommentEditBtn = document.createElement("button");
			reCommentEditBtn.setAttribute("class", "reCommentEditBtn");
			reCommentEditBtn.innerHTML="수정";

			commentEditDiv.appendChild(textAreaEdit);
			commentEditDiv.appendChild(reCommentEditBtn);
			 
			where.after(commentEditDiv);
			
			
		});
		
		// 수정 완료 이벤트
		$(document).on("click","button[class='reCommentEditBtn']", function(e){ 

			//showComment();

			var commentId = $(this).parent().parent().parent().find(".commentId").val();
			
			var editVal = {
					id : commentId,
					content :  $('#textAreaEdit').val()
			}
			
			editComment(editVal)
				.then(function(response) {
					showComment();
				})
				.catch(function(error) {
					var errorMessage = error.responseJSON.defaultMessage;
					console.log(error.responseJSON);
					alert(errorMessage);
					var errorFocus = error.responseJSON.field;
					 $('#textAreaEdit').focus();
				});
			
		});
		
		// 댓글 삭제 버튼 이벤트
		$(document).on("click","a[class='commentDeleteBtn']", function(e){

			var commentId = $(this).parent().parent().parent().parent().find(".commentId").val();
			
			deleteComment(commentId)
			.then(function(response) {
				if(response=="ok") {
					showComment();					
				} else {
					alert("삭제 실패!");
				}
			});
			
		});
		
		// 댓글 추가
		function addComment(comment) {
			
			return $.ajax({
				type : 'POST',
				url : '/comments',
				data : JSON.stringify(comment),
				contentType : "application/json; charset=utf-8"
			});
		}
		
		// 대댓글 추가
		function addReComment(comment) {

			return $.ajax({
				type : 'POST',
				url : '/comments/reComment',
				data : JSON.stringify(comment),
				contentType : "application/json; charset=utf-8"
			}); 
		}

		// 댓글 수정
		function editComment(editVal) {

			return $.ajax({
				type : 'PUT',
				url : '/comments/' + editVal.id,
				data : JSON.stringify(editVal),
				contentType : "application/json; charset=utf-8"
			}); 
			
		}

		// 댓글 삭제(진짜 삭제 x 작성자 0으로 바꿔줌)
		function deleteComment(commentId) {

			return $.ajax({
				type : 'DELETE',
				url : '/comments/' + commentId,
				data : JSON.stringify(commentId),
				contentType : "application/json; charset=utf-8"
			}); 
			
		}
		
		// 좋아요 추가
		function addLike(likeData) {
			return $.ajax({
				type : "POST",
				url : '/boards/like/',
				data : JSON.stringify(likeData),
				contentType : "application/json; charset=utf-8"
			});
		}
		
		// 좋아요 삭제
		function removeLike(likeData) {
			return $.ajax({
				type : 'DELETE',
				url : '/boards/like/' +likeData.userId+'/'+likeData.boardId,
				contentType : "application/json; charset=utf-8"
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
		
		// 댓글 수 갱신 반영
		function drawCommentCnt(commentCnt){
			$commentCnt.html("댓글 "+commentCnt);
		}
		
		// 좋아요 수 갱신 반영 및 좋아요 여부 반영
		function drawLikeCnt(likeCnt) {
			if($isLike.val()=="true") {
				$likeCnt.html("<span class='redText'>♥</span> 좋아요 "+likeCnt);
			} else {
			$likeCnt.html("<span class='redText'>♡</span> 좋아요 "+likeCnt);
			}
		}
		
		// 댓글 수 구하기
		function countComments(id) {
			return $.ajax({				
				type: 'GET',
				url: '/boards/comments/' + id,
				contentType : "application/json; charset=utf-8;"
			});
		}
		
		// 좋아요 여부 확인
		function isLike(likeData){
			return $.ajax({
				type : "GET",
				url : '/boards/like/'+likeData.userId+'/'+likeData.boardId,
				contentType : "application/json; charset=utf-8"
			});
		}
		
		document.getElementsByClassName('note-editable card-block')[0].style.background='white';
		document.getElementsByClassName('note-editor note-frame card')[0].style.border='none';
		document.getElementsByClassName('note-editor note-frame card')[0].style.width='80%';
		document.getElementsByClassName('note-statusbar')[0].style.border='none';
	});
</script>
</body>
</html>