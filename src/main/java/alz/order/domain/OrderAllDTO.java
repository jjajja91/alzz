package alz.order.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

@Setter
@Getter
@Builder
@Accessors(chain = true)
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class OrderAllDTO {

	
	private Long rownum;
	// 순번
	private Long no;
	// 주문번호 (ex. 20200731_123456)
	private String id;
	// 주문 상세 번호 (1,2,3,4...)
	private Long orderId;
	// 상품 번호
	private Long merchandiseId;
	// 상품 수량
	private Long amount;
	// 유저 아이디
	private Long userId;
	// 유저 이메일
	private String email;
	// 주문자 이름
	private String name;
	// 주문자 번호
	private String phone;
	// 결제 방법
	private String method;
	// 주문 상태
	private String state;
	// 주문 상태
	private String merchandiseName;
	// 결제 금액
	private Long totalPrice;
	// 주문 일시
	private Date orderAt;
	// 주문 일시
	private Long count;

}
