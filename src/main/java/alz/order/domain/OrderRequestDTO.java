package alz.order.domain;

import java.util.Date;
import java.util.List;

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
public class OrderRequestDTO {
	
	// 주문번호
	private String id;
	// 유저 아이디
	private Long userId;
	// 주문자 이름
	private String name;
	// 주문자 번호
	private String phone;
	// 결제 방법
	private String method;
	// 주문 상태
	private String state;
	// 주문 가격
	private Long totalPrice;
	// 주문 일자
	private Date orderAt;
	
	private List<Long> merchandiseId;
	
	private Long amount;

	

}
