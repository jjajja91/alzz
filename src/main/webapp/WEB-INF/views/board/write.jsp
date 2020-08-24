<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@include file="../includes/header.jsp"%>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>

<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css"rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

</head>
<style>
.container {
	margin-top: 200px;
	margin-left: 27%;
	width: 700px;
	min-height: 100%;
	position: relative;
}
div.form-group {
	margin-bottom: 50px;
}
#lesson_star_rate a.lessonOn {
   color: red;
}

#lesson_star_rate a {
   text-decoration: none;
   color: gray;
   font-size: 30px;
}

#teacher_star_rate a {
   text-decoration: none;
   color: gray;
   font-size: 30px;
}

#teacher_star_rate a.teacherOn {
   color: red;
}

</style>
<body>
	<div class="container">
		<div class="write-container">
			<h2 id="head">Board Write</h2>
			<form role="form" id="form" action="/board/write" method="post">
				<c:if test="${typeId == 4}">
					<div>
						<strong>수강했던 클래스</strong> 
						<select name="reviewOpts" id="reviewOpts" class="reviewOpts">
							<option value="" disabled selected hidden>수강 완료한 클래스를 선택해 주세요</option>

							<c:forEach var="reviewOpts" items="${reviewOpt}">
								<option value="${reviewOpts.id}">${reviewOpts.title}</option>
							</c:forEach>
						</select> 
						
						<br>
						<br>
						<lable>강의 만족도</lable>
						<p id="lesson_star_rate">
							<a href="#" id="star1">★</a> 
							<a href="#" id="star2">★</a> 
							<a href="#" id="star3">★</a> 
							<a href="#" id="star4">★</a> 
							<a href="#" id="star5">★</a>
						</p>
						<input type='hidden' name='lessonReview'>
						<lable>강사 만족도</lable>
						<p id="teacher_star_rate">
							<a href="#" id="star1">★</a> 
							<a href="#" id="star2">★</a> 
							<a href="#" id="star3">★</a> 
							<a href="#" id="star4">★</a> 
							<a href="#" id="star5">★</a>
						</p>
						<input type='hidden' name='teacherReview'>
					</div>
				</c:if>

				<div class="form-group">
					<label for="title">title:</label> 
					<input class="form-control" rows="1" name="title"></input> 
					
					<label for="content">content:</label>
					<textarea id="summernote" name="content"></textarea>
					
					<label>Writer:</label> 
					<input class="form-control" rows="1" name="nickname" value='<sec:authentication property="principal.nickname"/>' readonly="readonly"></input> 
					
					<label>boardType:</label> 
					<input class="form-control" rows="1" name="typeId" value="${typeId}" readonly="readonly"></input> 
					<input type="hidden" name="parentId" value='<c:out value="${param.pid}"/>'> 
					<input type="hidden" name="boardOrder" value='<c:out value="${param.boardOrder}"/>'> 
					<input type="hidden" name="id" value='<c:out value="${param.id}"/>'>
					<input type="hidden" name="writerId" value='<sec:authentication property="principal.id"/>'>

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

					<button type="submit" data-oper='write' class="btn btn-default">Submit</button>
					<button type="submit" data-oper='list' class="btn btn-default">List</button>
				</div>
			</form>
		</div>
	</div>

	<script type="text/javascript">
	//var $lessonId;
	$(document).ready(function(e){
		var $title = $("input[name=title]");
		var $content = $("textarea[name=content]");
		var inputData = {
			title: $title,
			content: $content
		};
		var $nickname = $("input[name=nickname]");
		var $typeId = $("input[name=typeId]");
		var $parentId = $("input[name=parentId]");
		var $boardOrder = $("input[name=boardOrder]");
		var $id = $("input[name=id]");
		var $writerId = $("input[name=writerId]");
		var $lessonReview = $("input[name=lessonReview]");
		var $teacherReview = $("input[name=teacherReview]");
	
		var $lessonId = $("select[name=reviewOpts]");
		
		var $summernote = $('#summernote');
	
		// 서머노트 커스터마이징
		$summernote.summernote({
			placeholder : 'content',
			minHeight : 370,
			maxHeight : null,
			shortcuts: false,
			focus : true,
			lang : 'ko-KR',
			height : 320,
			
			// 콜백으로 파일 서버 저장
			callbacks : {
				onImageUpload: function(files, editor, welEditable) {
					sendFile(files);
			    }
			}
		});
		
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
        
		// 파일 제출(저장)
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
		 
		// 서머노트 필요없는 버튼 제거
		makeFileBtn();
		
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
		
		//글쓰는 ajax
		function boardWriteApi(data) {
			return $.ajax({
				url: "/boards",
				type: "POST",
				data: JSON.stringify(data),
				contentType: "application/json",
			});
		}
		
		var formObj = $("form[role='form']");
		
		$("button[type='submit']").on("click", function(e){
			e.preventDefault();
			console.log("submit clicked");
			
			var fileList = [];
			
			var operation = $(this).data("oper");
			//글목록으로 돌아가기 버튼 눌렀을때
			if(operation === 'list') {
				console.log("submit clicked");
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
				//글쓰기 버튼 눌렀을때
			} else if(operation === 'write'){
				//서머노트 디폴트값이면 비우기
				$('.summernote').each(function(){
					var summernote = $(this);
					$('form').on('submit',function(){
						if (summernote.summernote('isEmpty')) {
							summernote.val('');
						} else if(summernote.val()=='<p><br></p>'){
							summernote.val('');
						}
					});
				});
			
				// 파일 적용
				$(".uploadResult ul li").each(function(i, obj){
					var jobj = $(obj);
					console.dir(jobj);
					var file = {
							fileName: jobj.data("filename"),
							uuid: jobj.data("uuid"),
							uploadPath: jobj.data("path"),
							fileType: jobj.data("type")
					};
					fileList[i] = file;
				});
				var data = {
						title: $title.val(),
						content: $content.val(),
						nickname: $nickname.val(),
						typeId: $typeId.val(),
						parentId : $parentId.val(),
						boardOrder : $boardOrder.val(),
						id : $id.val(),
						writerId : $writerId.val(),
						lessonReview : $lessonReview.val(),
						teacherReview : $teacherReview.val(),
						lessonId : $lessonId.val(),
						
						fileList: fileList
				};
				console.log(data);
				boardWriteApi(data)
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
			} // else if end
		}); // button event end
		
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
		
		// 파일 올린 결과 출력
		function showUploadResult(uploadResultArr) {
			if(!uploadResultArr||uploadResultArr.length==0){return;}
			var uploadUL = $(".uploadResult ul");
			var str = "";
			var imgstr = "";
			
			$(uploadResultArr).each(function(i, obj){
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
	
		// 파일 변경시 변경
		$("input[type='file']").change(function(e){
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			sendFile(files);
		});
	       
		// 파일 삭제 
		$(".uploadResult").on("click", "button", function(e){
			console.log("delete file");
			
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			var targetLi = $(this).closest("li");
			
			$.ajax({
				url: '/file/deleteFile',
				data: {fileName: targetFile, type:type},
				dataType: 'text',
				type: 'POST',
				success: function(result){
					alert(result);
					targetLi.remove();
				}
			});
		});

	});
</script>

</body>
</html>