<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%-- <%@include file="../includes/header.jsp"%> --%>
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
	margin-top: 70px;
	margin-left: 10%;
	min-height: 100%;
	position: relative;
}

body {
	margin: 0px;
}

.lessonHeaderDiv {
	width:100%;
	height:30px;
	margin: 0px;
	padding-top: 10px;
	border-bottom: solid 1px;
    position: fixed;
    top: 0px;
    background-color: white;
    z-index: 1;
}

.lessonHeaderLeft {
	padding-left: 2%;
}
.lessonHeaderRight {
    position: absolute;
    right: 20;
}
.pageTitle {
    font-size: 30px;
    font-weight: 600;
    padding-right:10px;
    color: #335492;
}

.lessonText {
	color: black;
	font-weight: bold;
	font-size: 20px;
    margin-bottom: 20px;
    line-height: 30px;
}

.lessonForm {
	font-size: 14px;
	color: #585858;
    margin-top: 20px;
}


.lessonForm button[name="prev"] {
    right: 22%;
    position: absolute;
    background: #335492;
    color: white;
    height: 35px;
    width: 70px;
    border-radius: 3px;
    border: none;
    font-weight: bold;
}
.lessonForm button[name="next"] {
    right: 15%;
    position: absolute;
    background: #335492;
    color: white;
    height: 35px;
    width: 70px;
    border-radius: 3px;
    border: none;
    font-weight: bold;
}

.form-control {
	width:80%;
	height: 30px;
	padding: 5px;
    margin: 5px;
}

#nickname {
	width: 30%;
}

.teacherTextarea {
	height: 200px;
}

.titleDiv {
	border-bottom: solid;
    border-color: #335492;
    padding-bottom: 15px;
    width: 85%;
}

.lessonList {
	width: 70%;
}

.mainCategoryList, .subCategoryList{
	width:220px;
}
.lessonMainImgDiv {
	display: flex;
    margin-bottom: 30px;
}
.lessonMainImgLeftDiv {
    display: table-cell;
    border: solid #335492;
    border-style: dashed;
    border-radius: 5px;
    text-align: center;
    height: 200px;
    vertical-align: middle;
}
.lessonMainImgRightDiv {
    width: 50%;
    padding: 15px;
}

.lessonTitleInput {
	width:100%;
}
.studentAmount {
	width:10%;
}

.dateInput, .lessonDate {
	width: 130px;
}

.startAt, .endAt {
	width: 100px;
}

input[type="button"] {
    position: absolute;
    background: #335492;
    color: white;
    height: 30px;
    width: 80px;
    border-radius: 3px;
    border: none;
    margin-top: 5px;
}

</style>
<body>
	<div class="lessonHeaderDiv">
		<span class="lessonHeaderLeft">클래스 등록 > 4. 세부설명 등록</span>
		<span class="lessonHeaderRight"><a href="/">HOME</a></span>
	</div>
	<div class="container">
		<div class="titleDiv">
			<span class="pageTitle">세부설명</span>
		</div>
		<div class="lessonText">
			<br>
			클래스를 통해 어떤 것을 배울 수 있는지<br> 상상해볼 수 있도록 클래스 소개를 채워주세요.
		</div>
		
		<form class="lessonForm" role="form" action="/lesson/registerDetail" method="post">
			<input type="hidden" name="lessonId" value='<c:out value="${param.lessonId }"/>' readonly>
			<input type="hidden" name="originalId" value='<c:out value="${param.originalId }"/>' readonly>
			<input type="hidden" name="id" id="id" value='<c:out value="${detail.id }"/>' readonly>
			<input type="hidden" name="location" id="location" readonly/>

		
			
			<textarea class="form-control" id="summernote" placeholder="클래스를 통해 알려주실 것과 완성할 수 있는 것들을 설명해 주세요." name="detail"><c:out value="${detail.detail }" /></textarea>
			
			<br> <br>
			
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
			<br> <br>
			<button type="submit" name="prev">이전</button>
			<button type="submit" name="next">다음 </button>
			<br> <br>
		</form>
	</div>
<script>
	
	$(document).ready(function(){
		var formObj = $("form[role='form']");
		var $summernote = $('#summernote');
		var $lessonId = $("input[name=lessonId]");
		
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
		
		// 서머노트 필요없는 버튼 제거
		makeFileBtn();
		
		// 서머노트 필요없는 버튼 제거
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
		
		$('.note-editor').width($(window).width()* 0.6);
		
		// 파일 변경시 변경
		$("input[type='file']").change(function(e){
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			

			sendFile(files);
		});
		
		// 다음 클릭시 지우고 저장
		$("button[type=submit]").click(function(e){

			var $originalId = $("input[name=originalId]");
			var $inputlocation = $("#location");
			
			var name = $(this).attr("name");

			var fileList = [];
			var data = {};
			
			
			if (name === 'prev') {
				
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
				
				data = {
						lessonId : $lessonId.val(),
						fileList: fileList
					};
				
				lessonWriteApi(data)
					.then(function(response){
						console.log(response);
					})
					.catch (function(error){
						var errorMessage = error.responseJSON.defaultMessage;
						console.log(error.responseJSON);
						alert(errorMessage);
						var errorFocus = error.responseJSON.field;
						inputData[errorFocus].focus();
					});
				
				$inputlocation.val("prev");
				formObj.submit();
				
			} else {

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
				
				data = {
						lessonId : $lessonId.val(),
						fileList: fileList
					};
				
				lessonWriteApi(data)
				.then(function(response){
					console.log(response);
				})
				.catch (function(error){
					var errorMessage = error.responseJSON.defaultMessage;
					console.log(error.responseJSON);
					alert(errorMessage);
					var errorFocus = error.responseJSON.field;
					inputData[errorFocus].focus();
				});
				
				$inputlocation.val("next");
				formObj.submit();
			}
			
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
		
		//글쓰는 ajax
		function lessonWriteApi(data) {
			return $.ajax({
				url: "/lessons",
				type: "POST",
				data: JSON.stringify(data),
				contentType: "application/json",
			});
		}
		
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
					imgstr += "<pr><img style='width:100%; 'src='/file/display?fileName="+imagePath+"'></pr>";
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

		// 파일 리스트 불러오는 함수
  		(function() {
		$.getJSON("/lessons/getFileList",{lessonId : $lessonId.val()}, function(arr){
			var str = "";
			$(arr).each(function(i, file){
				if(file.fileType){
					var fileCallPath = encodeURIComponent(file.uploadPath+"/s_"+file.uuid+"_"+file.fileName);
					str += "<li data-path='"+file.uploadPath+"'";
					str += " data-uuid='"+file.uuid+"' data-filename='"+file.fileName+"' data-type='"+file.fileType+"'><div>";
					str += "<span> " + file.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/file/display?fileName="+fileCallPath+"'>";
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