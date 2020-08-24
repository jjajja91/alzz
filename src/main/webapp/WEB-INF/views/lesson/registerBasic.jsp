<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%-- <%@include file="../includes/header.jsp"%> --%>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
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
}

.lessonForm {
	font-size: 16px;
	color: black;
    line-height: 30px;
    margin-top: 20px;
    font-weight: 600;
}

.lessonForm button {
    position: absolute;
    right: 55%;
    background: #335492;
    color: white;
    height: 35px;
    width: 70px;
    border-radius: 3px;
    border: none;
    font-weight: bold;
}

.lessonForm button[name="prev"] {
    right: 21%;
}
.lessonForm button[name="next"] {
    right: 15%;
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
	width: 140px;
}
</style>
<body>
	<div class="lessonHeaderDiv">
		<span class="lessonHeaderLeft">클래스 등록 > 2. 기본 정보 등록</span>
		<span class="lessonHeaderRight"><a href="/">HOME</a></span>
	</div>
	<div class="container">
		<div class="titleDiv">
			<span class="pageTitle">기본 정보</span>(2/5)
		</div>
		<form class="lessonForm" role="form" action="/lesson/registerBasic" method="post" enctype="multipart/form-data">
			<input type="hidden" name="userId" value='<sec:authentication property="principal.id"/>' readonly>
			<input type="hidden" name="teacherId" value='<c:out value="${param.teacherId }"/>' readonly> 
			<input type="hidden" name="state" class="state" value='<c:out value="${lesson.state }"/>' readonly /> 
			<input type="hidden" name="location" id="location" readonly /> 
			<input type="hidden" name="originalId" id="originalId" value='<c:out value="${param.originalId }"/>' readonly> 
			<input type="hidden" name="id" id="id" value='<c:out value="${lesson.id }"/>' readonly>
	
			<c:if test="${!empty oldLessons}">
				<strong>개설했던 클래스들 </strong>
				<select name="lessonList" class="lessonList form-control">
					<option>클래스를 선택해주세요</option>
	
					<c:forEach var="lessonList" items="${oldLessons}">
						<option value="${lessonList.id}">${lessonList.title}</option>
					</c:forEach>
				</select>
			</c:if>
	
			<div class="lessonBasic">
				<br> <br>
				<div class="lessonText">
					어떤 클래스인지 알려주세요<br>
					가르쳐보고 싶은게 있으신가요? 카테고리를 설정해봐요
				</div>
				<div class="lessonCategoryDiv">
					<label>카테고리 </label>
					<c:if test="${!empty mainCategory}">
						<select name="categoryMain" id="mainCategoryList" class="mainCategoryList form-control">
							<option>클래스 대분류를 선택해주세요</option>
	
							<c:forEach var="mainCategoryList" items="${mainCategory}">
								<option value="${mainCategoryList.main}"
									<c:if test="${lesson.categoryMain eq mainCategoryList.main}" > selected="selected"</c:if>>${mainCategoryList.name}</option>
							</c:forEach>
						</select>
					</c:if>
	
					<c:if test="${!empty subCategory}">
						<select name="categorySub" id="subCategoryList"
							class="subCategoryList form-control">
							<option>클래스 하위분류를 선택해주세요</option>
	
							<c:forEach var="subCategoryList" items="${subCategory}">
								<option value="${subCategoryList.sub}"
									<c:if test="${lesson.categorySub eq subCategoryList.sub}" > selected="selected"</c:if>>${subCategoryList.name}</option>
							</c:forEach>
						</select>
					</c:if>
				</div>
	
				<br> <br>
				<div class="lessonText">
					감성적이면서도 클래스를 잘 표현하는 제목과 이미지를 등록해 주세요.<br>예를 들어, 가죽공예, 어반 스케치,
					다이어리꾸미기 이런식으로요.
				</div>
				<div class="lessonMainImgDiv">
					<div class="lessonMainImgLeftDiv">
						<input type="file" id="uploadFile" name="uploadFile" accept="image/gif, image/jpeg, image/png, image/jpg">
						<br>
						<c:if test="${!empty lesson.thumbnail}">
						<img src="/resources/img/lesson/thumb/${lesson.teacherId}${lesson.openAt}/${lesson.thumbnail}" />
						</c:if>
					</div>
					<div class="lessonMainImgRightDiv">
						<label>클래스 제목</label> 
						<input class="form-control lessonTitleInput" name='title' id="title" value='<c:out value="${lesson.title}"/>'> 
						<br>
						<small>최대 30자</small>
					</div>
				</div>
	
				<div>
					<br>
					<label>난이도</label> <select name="lessonLevel" id=lessonLevel
						class="lessonLevel form-control">
						<c:forEach var="level" items="${levelList}">
							<option value="${level.id}"
								<c:if test="${lesson.lessonLevel eq level.id}" > selected="selected"</c:if>>${level.name}</option>
						</c:forEach>
					</select> 
					<br> <br>
					<label>클래스 과정</label>
					<input type="radio" class="lessonType" name="lessonType" id="lessonTypeOneday" value="1"
						<c:if test="${lesson.lessonType eq 1}" > checked</c:if> /> 
					<label for="lessonTypeOneday">원데이</label> 
					<input type="radio" class="lessonType" name="lessonType" id="lessonTypeRegular" value="2" 
						<c:if test="${lesson.lessonType eq 2}" > checked</c:if> />
					<label for="lessonTypeRegular">정규</label> 
					<br> <br>
					<label>클래스 인원</label> 
					<br> 
					<small>- 최소인원 미달 시 수업 2일전 자동취소/환불 됩니다.<br>- 최소인원은 1명으로 권장합니다.</small> 
					<br> 
					최소<input type="text" class="form-control studentAmount" placeholder="최소인원" name="minStudent" value='<c:out value="${lesson.minStudent}"/>'> ~ 
					최대<input type="text" class="form-control studentAmount" placeholder="최대인원" name="maxStudent" value='<c:out value="${lesson.maxStudent}"/>'> 
					<br> <br>
					<label>스케줄 선택</label> 
					<br>
					<small>클래스 시작일과 종료일을 입력해주세요.</small>
					<br>
					<input type="date" class="form-control dateInput" id="openAt" name="openAt" value='<c:out value="${lesson.openAt}"/>'> ~ 
					<input type="date" class="form-control dateInput" id="closeAt" name="closeAt" value='<c:out value="${lesson.closeAt}"/>'>
				</div>
	
				<br> <br> <br>
				<button type="submit" name="prev">이전</button>
				<button type="submit" name="next">다음</button>
				<br> <br>
			</div>
		</form>
	</div>

<script>
	var formObj;
	var lessonBasicDiv;

	// 카테고리를 담기위한 변수
	var mainCategory = [];
	var subCategory = [];
	var lessonLevel = [];

	var $mainCategory = $("#mainCategoryList");
	var $subCategory = $("#subCategoryList");
	var $inputTitle = $("#title");
	var $lessonLevel = $("#lessonLevel");
	var $lessonType = $(".lessonType");
	var $minStudent = $("input[name=minStudent]");
	var $maxStudent = $("input[name=maxStudent]");
	var $inputState = $(".state");
	var $inputLessonId = $("#id");
	var $inputOriginalId = $("#originalId");
	var $inputlocation = $("#location");
	var $openAt = $("#openAt");
	var $closeAt = $("#closeAt");

	$(document).ready(function() {

		formObj = $("form[role='form']");
		lessonBasicDiv = $(".lessonBasic");		
		
		// 메인 카테고리 불러오기
		getMainCategory().then(function(main) {
			mainCategory = main;
		});

		// 서브 카테고리 불러오기
		getSubCategory().then(function(sub) {
			subCategory = sub;
			
			$subCategory.children().remove(); //기존 리스트 삭제
		    $subCategory.append("<option value=''>클래스 하위분류를 선택해주세요</option>");
			for(var i=0;i<subCategory.length;i++){
				if($mainCategory.val() == subCategory[i].main){
					let str= "";
					if("${lesson.categorySub}"==subCategory[i].sub) {
						str= " selected='selected'";
					}
					$subCategory.append("<option value='"+subCategory[i].sub+"'"+str+">"+subCategory[i].name+"</option>");
				}
			}
		});
		
		for(var i=0;i<mainCategory.length;i++){
			$mainCategory.append("<option value='"+mainCategory[i].main+"'>"+mainCategory[i].name+"</option>");
	    }
		
		//*********** 1depth카테고리 선택 후 2depth 생성 START ***********
	    $(document).on("change","select[name='categoryMain']",function(){
	        //두번째 셀렉트 박스를 삭제 시킨다.
	        var $subCategory = $("select[name='categorySub']");
	        $subCategory.children().remove(); //기존 리스트 삭제
	        //선택한 첫번째 박스의 값을 가져와 일치하는 값을 두번째 셀렉트 박스에 넣는다.
	        $("option:selected", this).each(function(){
	            var selectValue = $(this).val(); //main category 에서 선택한 값
	            $subCategory.append("<option value=''>클래스 하위분류를 선택해주세요</option>");
	            for(var i=0;i<subCategory.length;i++){
	                if(selectValue == subCategory[i].main){
	                	$subCategory.append("<option value='"+subCategory[i].sub+"'>"+subCategory[i].name+"</option>");
	                }
	            }
	        });
	    });
	    //*********** 1depth카테고리 선택 후 2depth 생성 END ***********
	});

	$("button[type=submit]").click(function(e) {
		var name = $(this).attr("name");
		if (name === 'prev') {
			$inputlocation.val("prev");
			formObj.submit();
		} else {
			let selectedCategory = $("select[name=sub]").val();
			$("input[name=categoryId]").val(selectedCategory);
			$inputlocation.val("next");

			formObj.submit();
		}
	});

	// 개설했던 클래스 선택
	$('.lessonList').change(function(e) {

		var value = $(this).val();
		// 선택한 클래스 자동완성
		selectLesson(value).then(function(response) {
			// 새로고침...
			autoComplete(response);
		});
	});

	// 선택한 클래스 자동완성
	function selectLesson(id) {
		return $.getJSON("/lessons/" + id + ".json");
	}

	// 메인 카테고리 불러오기
	function getMainCategory() {
		return $.getJSON("/lessons/mainCategory.json");
	}

	// 서브 카테고리 불러오기
	function getSubCategory() {
		return $.getJSON("/lessons/subCategory.json");
	}

	// 난이도 불러오기
	function getLessonLevel() {
		return $.getJSON("/lessons/lessonLevel.json");
	}

	

	// 난이도 불러오기
	getLessonLevel().then(function(level) {
		lessonLevel = level;
	});

	// 자동완성 값 넣어주는 함수
	function autoComplete(response) {

		if (response == null || response.length == 0) {
			return;
		}
		// 제목
		$inputTitle.val(response.title);
		//메인카테고리
		$mainCategory.children().remove(); //기존 리스트 삭제
	    $mainCategory.append("<option value=''>클래스 대분류를 선택해주세요</option>");
		for (let i = 0; i < mainCategory.length; i++) {
			let str ="";
			if(mainCategory[i].main==response.categoryMain) {
				str = "selected='selected'";
			}
			$mainCategory.append("<option value='"+mainCategory[i].main+"'"+str+">"+mainCategory[i].name+"</option>");
		}
		// 서브카테고리
		$subCategory.children().remove(); //기존 리스트 삭제
	    $subCategory.append("<option value=''>클래스 하위분류를 선택해주세요</option>");
		for(var i=0;i<subCategory.length;i++){
			if($mainCategory.val() == subCategory[i].main){
				let str= "";
				if(subCategory[i].sub==response.categorySub) {
					str= " selected='selected'";
				} 
				$subCategory.append("<option value='"+subCategory[i].sub+"'"+str+">"+subCategory[i].name+"</option>");
			}
		}
		// 난이도
		let lessonLevelOptions = $lessonLevel.children();
		for (let i = 0; i < lessonLevelOptions.length; i++) {
			let lessonLevelOption = lessonLevelOptions[i];
			if (lessonLevelOption.text == response.lessonLevel) {
				lessonLevelOption.setAttribute("selected", "selected");
			}
		}
		// 클래스 타입
		let responseLessonType = response.lessonType;
		responseLessonType = responseLessonType == '원데이' ? 1 : 2;
		for (let i = 0; i < $lessonType.length; i++) {
			let lessonType = $lessonType[i];
			if (lessonType.value == responseLessonType) {
				lessonType.setAttribute("checked", "checked");
			}
		}
		$minStudent.val(response.minStudent);
		$maxStudent.val(response.maxStudent);
		$inputState.val(response.state);
		$inputLessonId.val(response.id);
		$inputOriginalId.val(response.id);
		$openAt.val(moment(response.openAt).format('YYYY-MM-DD'));
		$closeAt.val(moment(response.closeAt).format('YYYY-MM-DD'));

	} // autoComplete end

	function goBack() {
		self.location = "/lesson/register";
	}

	inputFile = $("input[type='file']");
    
    inputFile.change(function(e){
       
       imgTarget = $(e.target);
       
       console.log(imgTarget);
       console.log(imgTarget.next().find('img'));
       
       if(this.files){
          let reader = new FileReader;

              reader.onload = function(data) {
            	  imgTarget.next().find('img').attr("src", data.target.result).width(100);
               }
               reader.readAsDataURL(this.files[0]);
           }
       
     });
    
</script>
</body>
</html>