<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@include file="../includes/header.jsp"%>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>

<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
</head>
<style>
.container {
	margin-top: 200px;
	margin-left: 600px;
	min-height: 100%;
	position: relative;
}
</style>
<body>
	<div class="container">
		<h1 class="page-header">Board</h1>
		<div class="panel-body">

			<form role="form" action="/board/update" method="post">
				<c:if test="${board.typeId == 4}">
					<div>
						<h>수강 클래스 : </h>
						<strong><p>
								<c:out value="${board.lessonTitle}" />
							</p></strong> <br>
						<lable>강의 만족도</lable>
						<p id="lesson_star_rate">
							<a href="#" id="star1">★</a> <a href="#" id="star2">★</a> <a
								href="#" id="star3">★</a> <a href="#" id="star4">★</a> <a
								href="#" id="star5">★</a>
						</p>
						<input type='hidden' name='lessonReview'
							value='<c:out value="${board.lessonReview}"/>'>

						<lable>강사 만족도</lable>
						<p id="teacher_star_rate">
							<a href="#" id="star1">★</a> <a href="#" id="star2">★</a> <a
								href="#" id="star3">★</a> <a href="#" id="star4">★</a> <a
								href="#" id="star5">★</a>
						</p>
						<input type='hidden' name='teacherReview'
							value='<c:out value="${board.teacherReview}"/>'>

					</div>
				</c:if>
				<input type='hidden' name='pageNum'
					value='<c:out value="${cri.pageNum }"/>'> <input
					type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
				<input type='hidden' name='keyword'
					value='<c:out value="${cri.keyword }"/>'> <input
					type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
				<input type='hidden' name='typeId' id='typeId'
					value='<c:out value="${board.typeId }"/>'> <input
					type='hidden' id='id' name='id'
					value='<c:out value="${board.id }"/>'> <input type='hidden'
					id='writerId' name='writerId'
					value='<sec:authentication property="principal.id"/>'>

				<div class="form-group">
					<label>제 목</label> <input class="form-control" id='title'
						name='title' value='<c:out value="${board.title }"/>'>
				</div>
				<div class="form-group">
					<textarea id="summernote" class="form-control content" rows="10"
						name='content'><c:out value="${board.content }" />
				</textarea>
				</div>

				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-defualt">
							<div class="panel-heading">Files</div>
							<div class="panel-body">
								<div class='uploadResult'>
									<ul>

									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>

				<button type="submit" data-oper='update' class="btn btn-default">수정</button>
				<button type="submit" data-oper='delete' class="btn btn-danger">삭제</button>
				<button type="submit" data-oper='list' class="btn btn-info">목록</button>

			</form>
			<input type="hidden" name="nickname" id="nickname"
				value='<sec:authentication property="principal.nickname"/>' />
		</div>

	</div>

	<script type="text/javascript">
	$(document).ready(function() {
		var $summernote = $('#summernote');
  		var $id = $("#id");
  		var $title = $("#title");
  		var $content = $(".content");
  		var $nickname = $("#nickname");
  		var $typeId = $("#typeId");
  		var $writerId = $("#writerId");
		var inputData = {
				title: $title,
				content: $content
			};
		var $lessonReview = $("input[name=lessonReview]");
		var $teacherReview = $("input[name=teacherReview]");
	
		var $lessonId = $("select[name=reviewOpts]");
		
		// 서머노트 커스터마이징
		$summernote.summernote({
			placeholder : 'content',
			minHeight : 370,
			maxHeight : null,
			focus : true,
			lang : 'ko-KR',
			height : 320,
			
			// 콜백으로 이미지를 서버에 저장ㄴ
			callbacks : {
				onImageUpload: function(files, editor, welEditable) {
			            sendFile(files);
			          }
			}
		});
		
		//별 클릭 함수
		 $('#lesson_star_rate a').click(function(){
	            $(this).parent().children("a").removeClass("lessonOn");  /* 별점의 on 클래스 전부 제거 */ 
	            $(this).addClass("lessonOn").prevAll("a").addClass("lessonOn"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
	            var lesson_star_rate = $(".lessonOn").length;
	            return $("input[type=hidden][name=lessonReview]").val(lesson_star_rate);
	        });
		 $('#teacher_star_rate a').click(function(){
	            $(this).parent().children("a").removeClass("teacherOn");  /* 별점의 on 클래스 전부 제거 */ 
	            $(this).addClass("teacherOn").prevAll("a").addClass("teacherOn"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
	            var teacher_star_rate = $(".teacherOn").length;
	            return $("input[type=hidden][name=teacherReview]").val(teacher_star_rate);
	        });
		
		// 필요 없는 이미지 등록 버튼 제거
		makeFileBtn();
		
		// 서머노트 이미지 복사 붙여넣기를 파일업로드로 사용하기 위해 저장하는 메서드
		function sendFile(files){
    		var formData = new FormData();
    		   for(var i=0; i<files.length; i++){
                   if(!checkExtension(files[i].name, files[i].size)){
                      return false;
                   }
                   formData.append("uploadFile", files[i]);
                }
            $.ajax({
               url: '/file/uploadAjaxAction',
               processData: false,
               contentType: false,
               data: formData,
               type: 'POST',
               dataType: 'json',
               success: function(result){
                  console.log(result);
                  showUploadResult(result);
               }
            });
    	}
		

		
		// 쓸데 없는 버튼을 제거하고 파일 업로드 버튼만 나오게하는 메서드
		function makeFileBtn() {
			$("button[data-original-title=Picture]").remove();
			$("button[data-original-title=Video]").remove();
			$("button[data-original-title^=Link]").remove();
			$("div[class$=note-insert]").remove();
			var str = ""
			str += "<div class='note-btn-group btn-group note-file form-group uploadDiv'>";
			str += "<input type='file' name='uploadFile' multiple='multiple'>";
			str += "</div>";
			$("div[class*=toolbar]").append(str);
		}
    
		// 게시글 제거 함수
  		function boardDeleteApi(data) {
    		  return $.ajax({
    		    url: "/boards/"+$id.val(),
    		    type: "Delete",
    		    data: JSON.stringify(data),
    		    contentType: "application/json",
    		  });
    		}
  		
		// 게시글 수정 함수
  		function boardUpdateApi(data) {
  		  return $.ajax({
  		    url: "/boards/"+$id.val(),
  		    type: "PUT",
  		    data: JSON.stringify(data),
  		    contentType: "application/json",
  		  });
  		}
		
		
		var formObj = $("form[role='form']");

		// 제출 버튼 이벤트
		$('button[type=submit]').on("click", function(e) {
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			console.log(operation);
	
			if(operation === 'delete') {			
				boardDeleteApi(data) 
				.then(function(response){
				   self.location = "/board/list?typeId="+$typeId.val();
				})					
			} else if(operation === 'list') {
				//move to list
				formObj.attr("action", "/board/list").attr("method", "get");
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name='type']").clone();
				var typeIdTag = $("input[name='typeId']").clone();
				
				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
				formObj.append(typeIdTag);
				
				formObj.submit();
				
			} else if(operation === 'update'){
				$('.summernote').each(function(){
				      var summernote = $(this);
				      $('form').on('submit',function(){
				          if (summernote.summernote('isEmpty')) {
				               summernote.val('');
				          }else if(summernote.val()=='<p><br></p>'){
				               summernote.val('');
				          }
				     });
				 });
				
				console.log("submit clicked");
		
				var str = "";
				
				var blockImgArr = $(".card-block").find("img");
				var targetLi = $(".uploadResult ul li").clone();

				$(".uploadResult ul li").remove();
				
				var targetUl = $(".uploadResult ul");
				
				for(var i = 0; i < blockImgArr.length; i++){
					var blockImg = $(blockImgArr[i]);
					var blockImgSrc = blockImg.attr("src");
					for(var j = 0; j < targetLi.length; j++){
						var $targetLi = $(targetLi[j])
						var targetUuid = $targetLi.data("uuid");
						if(blockImgSrc.indexOf(targetUuid)!=-1){
							targetUl.append($targetLi);
						}
					}
				}
				
				var fileList = [];
				
				$(targetUl).find("li").each(function(i, obj){
					var jobj = $(obj);
					console.dir(jobj);
					
					var file = {
							fileName: jobj.data("filename"),
							uuid: jobj.data("uuid"),
							uploadPath: jobj.data("path"),
							fileType: jobj.data("type")
					};
					
					fileList[i] = file;
/* 					
					str += "<input type='hidden' name='fileList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
					str += "<input type='hidden' name='fileList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
					str += "<input type='hidden' name='fileList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
					str += "<input type='hidden' name='fileList["+i+"].fileType' value='"+jobj.data("type")+"'>"; */
				});
			
				
		  		var data = {
						title: $title.val(),
						content: $content.val(),
						id : $id.val(),
						typeId : $typeId.val(),
						nickname : $nickname.val(),
						writerId : $writerId.val(),
						lessonReview : $lessonReview.val(),
						teacherReview : $teacherReview.val(),
						lessonId : $lessonId.val(),
						
						fileList: fileList
				};
				console.log(data);
				boardUpdateApi(data)
				.then(function(response){
					console.log(response);
					self.location = "/board/list?typeId="+$typeId.val();
				})
				.catch (function(error){
					var errorMessage = error.responseJSON.defaultMessage;
					console.log(error.responseJSON);
					alert(errorMessage);
					var errorFocus = error.responseJSON.field;
					inputData[errorFocus].focus();
				});
			}
		});
		
		// 파일 리스트 불러오는 함수
  		(function() {
		var boardId = '<c:out value="${board.id}"/>';
		$.getJSON("/boards/getFileList",{boardId : boardId}, function(arr){
			var str = "";
			$(arr).each(function(i, file){
				if(file.fileType){
					var fileCallPath = encodeURIComponent(file.uploadPath+"/s_"+file.uuid+"_"+file.fileName);
					str += "<li data-path='"+file.uploadPath+"'";
					str += " data-uuid='"+file.uuid+"' data-filename='"+file.fileName+"' data-type='"+file.fileType+"'><div>";
					str += "<span> " + file.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img style='width:100%;' src='/file/display?fileName="+fileCallPath+"'>";
					str += "</div></li>";
				} else {
					var fileCallPath = encodeURIComponent(file.uploadPath+"/"+file.uuid+"_"+file.fileName);
					var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
													
					str += "<li data-path='"+file.uploadPath+"'";
					str += " data-uuid='"+file.uuid+"' data-filename='"+file.fileName+"' data-type='"+file.fileType+"'><div>";
					str += "<span> " + file.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'>";
					str += "</div></li>";									
				}
			});
			$(".uploadResult ul").html(str);
		});
		})();
  		
  		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
  		var maxSize = 5242880;
  		
  		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
  		var maxSize = 5242880;
  		
  		function checkExtension(fileName, fileSize) {
  			if(fileSize >= maxSize){
  				alert("파일 사이즈 초과");
  				return false;
  			}
  			
  			if(regex.test(fileName)){
  				alert("해당 종류의 파일은 업로드할 수 없습니다.");
  				return false;
  			}
  			return true;
  		}
  		
  		// 올린 파일 결과 보여주기
  		function showUploadResult(uploadResultArr) {
  			if(!uploadResultArr||uploadResultArr.length==0){return;}
  			var uploadUL = $(".uploadResult ul");
  			var str = "";
  			var imgstr = "";
  			
  			$(uploadResultArr).each(function(i, obj){
  				console.log(obj);
  				if(obj.image){
  					var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
  					var imagePath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
  					str += "<li data-path='"+obj.uploadPath+"'";
  					str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
  					str += "<span> " + obj.fileName+"</span>";
  					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
  		  			imgstr += "<pr><img style='width:100%;' src='/file/display?fileName="+imagePath+"'></pr>";
  					str += "<img src='/file/display?fileName="+fileCallPath+"'>";
  					str += "</div></li>";
  				} else {
  					var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
  					var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
  					
  					str += "<li data-path='"+obj.uploadPath+"'";
  					str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
  					str += "<span> " + obj.fileName+"</span>";
  					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
  					str += "<img src='/resources/img/attach.png'>";
  					str += "</div></li>";
  					
  				}
  			});
  			uploadUL.append(str);
  			$(".card-block").append(imgstr);
  			$summernote.summernote("insertParagraph");
  			
  		}
  		
  		// 파일 바꾸면
  		$("input[type='file']").change(function(e){
  			var formData = new FormData();
  			var inputFile = $("input[name='uploadFile']");
  			var files = inputFile[0].files;
  			
  			for(var i=0; i<files.length; i++){
  				
  				if(!checkExtension(files[i].name, files[i].size)){
  					return false;
  				}
  				formData.append("uploadFile", files[i]);
  			}
  			
  			$.ajax({
  				url: '/file/uploadAjaxAction',
  				processData: false,
  				contentType: false,
  				data: formData,
  				type: 'POST',
  				dataType: 'json',
  				success: function(result){
  					console.log(result);
  					showUploadResult(result);
  				}
  			});
  		});
  		
  		// 파일 삭제
  		$(".uploadResult").on("click", "button", function(e){
  			console.log("delete file");
  			if(confirm("Remove this file? ")){
  				var targetLi=$(this).closest("li");
  				var targetImgSrc = targetLi.find("img").attr("src").replace("s_","");
  				var blockImgArr = $(".card-block").find("img");
  				
  				for(var i = 0; i<blockImgArr.length; i++){
  					var blockImg = $(blockImgArr[i]);
  					var blockImgSrc = blockImg.attr("src");
  					if(blockImgSrc===targetImgSrc){
  						blockImg.remove();
  					}
  				}
  				targetLi.remove();
  				$summernote.summernote("insertParagraph");
  			}
  		});
  		
	});
</script>

</body>
</html>