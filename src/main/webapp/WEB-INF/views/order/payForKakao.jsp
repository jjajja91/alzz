<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
	<sec:authentication var="principal" property="principal" />
	<script>
	
	<!-- 값 가져오기 -->
	
	var name = "${orderer}";	// 주문자 이름
	var phone = "${orderPhone}";
	var totalPrice = ${totalPrice};
	var merchandiseName = "${merchandiseName}";
	var merchandises = ${merchandises};
	var itemId = "${merchandise}";
	
	var method = "${method}";
	
	var msg;
	var orderId;
	var subNum = "";
	var orderName = "";
	
	var buyList = [
		  <c:forEach items="${buyList}" var="list">
		                 "${list.merchandiseId}",
		  </c:forEach>
		             ];
	
	console.log(buyList);
	console.log(buyList[0]);
	
	// 단품구매시 buyList에 담기위해서 값 변경해주기
	if( buyList[0]===""){
		buyList[0] = itemId;
	}
	
	console.log(buyList[0]);
	console.log(buyList);
	
	console.log("merchandises : "+ merchandises);
	console.log("itemId : "+ itemId);
	console.log("buyList.length : "+ buyList.length);
	
		
	  
	  function one() {
		  if (merchandises === 0) {
			  orderName = merchandiseName;
			} else if (merchandises >= 1) {
				orderName = merchandiseName + " 외 " + merchandises + "건";
			}
		  return orderName;
	  }
	  
	  $(function(){
			var IMP = window.IMP; // 생략가능
			IMP.init("imp41338638"); // 발급받은 "가맹점 식별코드"를 사용
			

				IMP.request_pay({
				pg : 'kakaopay',
				pay_method : 'card',
				merchant_uid : 'merchant_' + new Date().getTime(),
				name : one(),
				amount : totalPrice,
				buyer_name : name,
				buyer_tel : phone,
			}, function(rsp) {
				if (rsp.success) {
					//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
					$.ajax({
						url : "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
						type : 'POST',
						dataType : 'json',
						data : {
							imp_uid : rsp.imp_uid
						//기타 필요한 데이터가 있으면 추가 전달
						}
					}).done(function(data) {
						//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
						if (everythings_fine) {
							msg = '결제가 완료되었습니다.';
							msg += '\n고유ID : ' + rsp.imp_uid;
							msg += '\n상점 거래ID : ' + rsp.merchant_uid;
							msg += '\결제 금액 : ' + rsp.paid_amount;
							msg += '카드 승인번호 : ' + rsp.apply_num;

							alert(msg);
						} else {
							// else 처리
						}
					});
					// 성공시 진행할 것 
					orderComplete();
										

				} else {
					msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
					//실패시 이동할 페이지
					location.href = "/merchandise/cart";
					alert(msg);
				 }
	        });
	        
	    });
	  
	  // 결제 완료 후 실행됨
	  function orderComplete() {
			// 1. 오더 테이블 등록
			addNewOrder(buyList)
			.then(function(response){
					console.log(response)
					location.href = "/order/buy?orderId="+orderId; 
			})
			.catch(function(error){
					console.log(response)
					var msg = '결제에 실패하였습니다.';
					location.href = "/merchandise/cart";
					alert(msg);
			});
				
		}
	  
	  
	  // 주문 등록
	  function addNewOrder(merchandiseId) {
		  
		  // 주문 번호 생성
		  var date = new Date(); 
		  var year = date.getFullYear(); 
		  var month = new String(date.getMonth()+1); 
		  var day = new String(date.getDate()); 

		  // 한자리수일 경우 0을 채워준다. 
		  if(month.length == 1){ 
		    month = "0" + month; 
		  };
		  if(day.length == 1){ 
		    day = "0" + day; 
		  };
		  
		  // 6자리 난수 생성
		  for (var i = 1; i <= 6; i++) {
				subNum += Math.floor(Math.random() * 10);
			};

		  orderId = year + "" + month + "" + day + "_" + subNum;
		  console.log(orderId);   // ex) 20200804_615664
		  
		  
		  var orderData = {
				  	id : orderId,
					name: name,
					phone: phone,
					totalPrice: totalPrice,
					method: method,
					state : "결제완료",
					merchandiseId : merchandiseId
				};
				
				
				return $.ajax({
					url: "/order/addNewOrder",
					type: "POST",
					data: JSON.stringify(orderData),
					contentType: "application/json"
				});
	  }
	  
		function addOneOrder(itemId) {
		  
		  // 주문 번호 생성
		  var date = new Date(); 
		  var year = date.getFullYear(); 
		  var month = new String(date.getMonth()+1); 
		  var day = new String(date.getDate()); 

		  // 한자리수일 경우 0을 채워준다. 
		  if(month.length == 1){ 
		    month = "0" + month; 
		  };
		  if(day.length == 1){ 
		    day = "0" + day; 
		  };
		  
		  // 6자리 난수 생성
		  for (var i = 1; i <= 6; i++) {
				subNum += Math.floor(Math.random() * 10);
			};

		  orderId = year + "" + month + "" + day + "_" + subNum;
		  console.log(orderId);   // ex) 20200804_615664
		  
		  
		  var orderData = {
				  	id : orderId,
					name: name,
					phone: phone,
					totalPrice: totalPrice,
					method: method,
					state : "결제완료",
					merchandiseId : itemId
				};
				
				
				return $.ajax({
					url: "/order/addNewOrder",
					type: "POST",
					data: JSON.stringify(orderData),
					contentType: "application/json"
				});
	  }


	</script>

</body>
</html>