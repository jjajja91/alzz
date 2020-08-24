<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/myPageNav.jsp"%>
<%@include file="../includes/header.jsp"%>
<body>
	<div class="container">

		<h1 class="page-header">완료된 클래스</h1>
	</div>
	<div class="container">

		<table class="table table-striped" id="table">
			<thead>
				<tr>
					<th class="imgArea"></th>
					<th></th>
				</tr>
			<tbody>
				<c:forEach items="${list}" var="myLessonList">

					<tr>
						<td rowspan="2">
						<c:if test= "${empty myLessonList.thumbnail}">
						<img class="lessonImg" src="../../../resources/img/classtmpimg.jpg">
						</c:if>
						<c:if test= "${!empty myLessonList.thumbnail}">
						<img class="lessonImg" src="/resources/img/lesson/thumb/${myLessonList.teacherId}${myLessonList.openAt}/${myLessonList.thumbnail}">
						</c:if>
						</td>
						<td><c:out value="${myLessonList.title }" /></td>
					</tr>
					<tr>
						<td><c:out value="${myLessonList.closeAt }" />/ 클래스 종료</td>
					</tr>
					<%-- <td><c:out value="${myLessonList.id }" /></td>
					<td><a class='read' href='<c:out value="${board.id }"/>'><c:out
								value="${board.title }" /> (<c:out value="${board.commentCnt}" />)</a>
					</td>
					<td><c:out value="${board.nickname }" /></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd"
							value="${board.writtenAt }" /></td>
					<td><c:out value="${board.viewCnt }" /></td>
					
					--%>


				</c:forEach>
			</tbody>
		</table>

		<!-- paging -->
		<div class="page-footer">
			<ul class="pagination pull-right">
				<c:if test="${pageMaker.prev }">
					<li class="paginate_button previous"><a
						href="${pageMaker.startPage -1 }">Previous</a></li>
				</c:if>

				<c:forEach var="num" begin="${pageMaker.startPage }"
					end="${pageMaker.endPage }">
					<li
						class="paginate_button ${pageMaker.cri.pageNum == num? 'active':'' }"><a
						href="${num }">${num }</a></li>
				</c:forEach>

				<c:if test="${pageMaker.next }">
					<li class="paginate_button next"><a
						href="${pageMaker.endPage +1 }">Next</a></li>
				</c:if>
			</ul>
		</div>

		<form id='actionForm' action="/myPage/finishedLesson" method='get'>
			<input type='hidden' id='pageNum' name='pageNum'
				value='<c:out value="${pageMaker.cri.pageNum }"/>' /> <input
				type='hidden' id='amount' name='amount'
				value='<c:out value="${pageMaker.cri.amount }"/>' />
		</form>

	</div>

	<script type="text/javascript">
	$(document).ready(function() {
		var $pageNum = $("#pageNum");
		var $amount = $("#amount");
		var $writerId = $("#writerId");
		
		var $table = $("#table");
		
		var totalCnt;
		var data;
		

		var actionForm = $("#actionForm");
		
		// 첫 페이지 paging
		$(".paginate_button a").on("click", function(e) {
			e.preventDefault();
			
			data = {
					pageNum : $pageNum.val(),
					amount : $amount.val(),
					writerId : $writerId.val()
				};
			
			var targetPageNum = $(this).attr("href");
			data.pageNum = targetPageNum;
			
			// 글 목록 출력
			getList(data, pageNum);
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		// 읽기 이벤트 추가
		$(".read").on("click", function(e) {
			e.preventDefault();
			actionForm.append("<input type='hidden' name='id' value='"+$(this).attr("href")+"'>");
			actionForm.attr("action", "/board/read");
			actionForm.submit();
		});
		
		
		 
		var pageFooter = $(".page-footer");
		
		// 페이지 번호 출력
		function showPage(totalCnt) {
			
			pageFooter.empty();
			
			var endNum = Math.ceil(data.pageNum / 10.0) * 10;
			var startNum = endNum - 9;
			
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= totalCnt) {
				endNum = Math.ceil(totalCnt/10.0);
			}
			
			if(endNum * 10 < totalCnt) {
				next = true;
			}

			var str = "<ul class='pagination pull-right'>";
			
			if(prev) {
				str += "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Privious</a></li>";
			}
			
			for(var i=startNum; i<=endNum; i++) {
				var active = data.pageNum ==i? "active":"";
				str += "<li class='page-item"+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
			}
			
			if(next) {
				str += "<li class='page-item'><a class='page-link' href='"+(endNum +1)+"'>Next</a></li>";
			}
			
			str += "</ul></div>";
			
			pageFooter.html(str);
		}
		
		// 페이지 번호 클릭 이벤트
		pageFooter.on("click", "li a", function(e) {
			e.preventDefault();
			
			var targetPageNum = $(this).attr("href");
			data.pageNum = targetPageNum;
			
			// 글 목록 출력
			getList(data, pageNum);
		});
		
		// 글목록
		function getList(data) {
			console.log(data);
			// 글 검색 결과
			boardSearch(data)
				.then(function(response) {
					// 글 검색결과 출력
					return printBoardList(response);
				})
				.then(function(response) {
					// 읽기 이벤트 추가
					$(".read").on("click", function(e) {
						e.preventDefault();
						actionForm.append("<input type='hidden' name='id' value='"+$(this).attr("href")+"'>");
						actionForm.attr("action", "/board/read");
						actionForm.submit();
					});
					
				})
				.catch(function(error) {
					console.log(error);
				});
		}
		
		// 글 검색 결과
	function boardSearch(data) {
			return $.ajax({
				type : "GET",
				url : "/myPage/" + data.pageNum + "/" + data.amount+ "/" + ".json",
				contentType : "application/json; charset=utf-8"
			});
		} 
		
		
		// 글목록 출력
		function printBoardList(boards, page) {
			if(page == -1) {
				pageNum = Math.ceil(totalCnt/10.0);
				printBoardList(boards, pageNum);
				return;
			}
			
			var $tableHeader = $table.find("#table-header").clone();
			$table.empty();
			$table.append($tableHeader);
			
			var frag = document.createDocumentFragment();
			for(var i=0; i<boards.length; i++) {
				var board= boards[i];
				
				var tr = document.createElement("tr");
				var id = document.createElement("td");
				id.textContent = board.id;
				tr.appendChild(id);
				
				var title = document.createElement("td");
				var titleA = document.createElement("a");
				titleA.setAttribute("class", "read");
				titleA.setAttribute("href", board.id);
				titleA.textContent = board.title;
				
				title.appendChild(titleA);
				tr.appendChild(title);
				var nickname = document.createElement("td");
				nickname.textContent = board.nickname;
				tr.appendChild(nickname);
				
				var writtenAt = document.createElement("td");
				writtenAt.textContent = moment(board.writtenAt).format('YYYY-MM-DD'); 
				tr.appendChild(writtenAt);
				
				var viewCnt = document.createElement("td");
				viewCnt.textContent = board.viewCnt;
				tr.appendChild(viewCnt);
				
				frag.appendChild(tr);
			}
			
			$table.append($(frag));
		}
		
	});
</script>
</body>
</html>
