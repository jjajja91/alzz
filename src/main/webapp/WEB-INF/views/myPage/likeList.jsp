<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@include file="../includes/myPageNav.jsp"%>
<%@include file="../includes/header.jsp"%>


	<div class="container">
		<h1 class="page-header">내 좋아요</h1>
	</div>

	<div class="container">

		
		<table class="table table-striped" id="table">
			<thead id="table-header">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list }" var="board">
					<tr>
						<td><c:out value="${board.id }" /></td>
						<td><a class='read' href='<c:out value="${board.id }"/>'><c:out
									value="${board.title }" /> (<c:out value="${board.commentCnt}" />)</a>
						</td>
						<td><c:out value="${board.nickname }" /></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd"
								value="${board.writtenAt }" /></td>
						<td><c:out value="${board.viewCnt }" /></td>
					</tr>
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
						href="${num }" class='paging'>${num }</a></li>
				</c:forEach>

				<c:if test="${pageMaker.next }">
					<li class="paginate_button next"><a
						href="${pageMaker.endPage +1 }">Next</a></li>
				</c:if>
			</ul>
		</div>


		<form id='actionForm' action="/myPage/boardList" method='get'>
			<input type='hidden' id='pageNum' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum }"/>' />
			<input type='hidden' id='amount' name='amount' value='<c:out value="${pageMaker.cri.amount }"/>' />
			</form>

	</div>

	<script type="text/javascript">
	$(document).ready(function() {
		
		
		$pageBtn = $(".paging");
		$tbody = $("tbody");

		$pageBtn.on().click(function(e){
			$pageBtn.parent().removeClass("active")
			e.preventDefault();
			var $target = $(e.target)
			$target.parent().addClass("active");
			var pageNum = $target.text();
			getMyLikeList(pageNum)
			.then(function(response){
				drawMyLikeList(response);
			})
			.catch(function(error){
				console.log(error);
			});
		});
		
		function getMyLikeList(pageNum){
			return $.ajax({
				type : "GET",
				url : "/myPages/likeList/"+pageNum,
				contentType : "application/json"
			});
		};
		
		function drawMyLikeList(likeList){
			$tbody.html("");
			var fragment = document.createDocumentFragment();
			for(var i = 0; i<likeList.length; i++){
				var like = likeList[i];
				var str = "";
				var tr = document.createElement("tr");
				str += "<td>"+like.id+"</td>";
				str += "<td><a class='read' href='/board/read?id="+like.id+"'>"+like.title+"("+like.commentCnt+")</a></td>";
				str += "<td>"+like.nickname+"</td>"
				str += "<td>"+like.viewCnt+"</td>"
				var writtenAt = like.writtenAt
				var date = new Date(writtenAt);
				str += "<td>"+formatDate(date)+"</td>"
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