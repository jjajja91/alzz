<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@include file="../includes/myPageNav.jsp"%>
<%@include file="../includes/header.jsp"%>
<head>
<style>
.container {
	position: relative;
	margin-top: 200px;
}

.container h1 {
	text-align: center;
	font-size: 2em;
	color: #335492;
}

.table-container {
	position: absolute;
	top: 90px;
	right: 15%;
}

.content-table {
  border-collapse: collapse;
  font-size: 0.8em;
  min-width: 400px;
  width: 700px;
  overflow: hidden;
}

.content-table thead tr {
  background-color: #335492;
  color: #ffffff;
  text-align: left;
}

.content-table th {
padding: 13px 15px
}
.content-table td {
  padding: 8px 15px;
}

.content-table td a {
  text-decoration: none;
  color: #335492;
}

.content-table tbody tr {
  border-bottom: 1px solid #dddddd;
}

.content-table tbody tr:nth-of-type(even) {
  background-color: #f3f3f3;
}

.content-table tbody tr:last-of-type {
  border-bottom: 2px solid #335492;
}

.content-table tbody tr.active-row {
  font-weight: bold;
  color: #335492;
}

.page-footer{
	right: 0%;
	bottom: 0%;
	margin-top: 20px;
}

.page-footer li{
	float: left;
}

.paginate_button a {
	text-decoration: none;
	background-color: #eee;
	padding: 5px 10px;
	color: #335492;
}

.active a{
	color: #eee;
	background-color: #335492;
}
</style>
</head>
<body>


	<div class="container">
		<h1 class="page-header">내 댓글</h1>

	<div class="table-container">

		
		<table class="content-table" id="table">
			<thead>
				<tr>
					<th>번호</th>
					<th>댓글</th>
					<th>작성자</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list }" var="comment">
					<tr>
						<td><c:out value="${comment.id }" /></td>
						<td><a class='read' href='/board/read?id=<c:out value="${comment.boardId }"/>'><c:out
									value="${comment.content }" /></a>
						</td>
						<td><c:out value="${comment.nickname }" /></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd"
								value="${comment.writtenAt }" /></td>
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
						href="${num }" class="paging">${num }</a></li>
				</c:forEach>

				<c:if test="${pageMaker.next }">
					<li class="paginate_button next"><a
						href="${pageMaker.endPage +1 }">Next</a></li>
				</c:if>
			</ul>
		</div>
		</div>
		</div>




	<script type="text/javascript">
	$(document).ready(function() {
		
		$pageBtn = $(".paging");
		$tbody = $("tbody");

		$pageBtn.on().click(function(e){
			// active 관련은 나중에 없앨 수도 있음
			$pageBtn.parent().removeClass("active")
			e.preventDefault();
			var $target = $(e.target)
			$target.parent().addClass("active");
			var pageNum = $target.text();
			getMyCommentList(pageNum)
			.then(function(response){
				console.log(response);
				drawMyCommentList(response);
			})
			.catch(function(error){
				console.log(error);
			});
		});
		
		function getMyCommentList(pageNum){
			return $.ajax({
				type : "GET",
				url : "/myPages/commentList/"+pageNum,
				contentType : "application/json"
			});
		};
		
		function drawMyCommentList(commentList){
			$tbody.html("");
			var fragment = document.createDocumentFragment();
			for(var i = 0; i<commentList.length; i++){
				var comment = commentList[i];
				var str = "";
				var tr = document.createElement("tr");
				str += "<td>"+comment.id+"</td>";
				str += "<td><a class='read' href='/board/read?id="+comment.boardId+"'>"+comment.content+"</a></td>";
				str += "<td>"+comment.nickname+"</td>"
				var writtenAt = comment.writtenAt
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