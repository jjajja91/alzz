<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="resources/css/common.css" />
</head>
<body>
	<h3>수정 정보 출력</h3>
	
			<table>
				<tr>
					<td>EMAIL</td>
					<td>
						${sessionUser.email}
					 </td>
				</tr>
				<tr>
					<td>NICKNAME</td>
					<td>
						${sessionUser.nickname}
					</td>
				</tr>
				<tr>
					<td>PHONENUMBER</td>
					<td>
						${sessionUser.phoneNumber}
					</td>
				</tr>
			</table>
		
		<P>  The time on the server is ${serverTime}. </P>
		
		<hr>
		
		<a href="/">메인 페이지 이동</a>	<br>
		
		
</body>
</html>