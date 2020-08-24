package alz.order.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import alz.order.domain.CartDTO;
import alz.order.domain.CartListDTO;

public interface CartService {

	// 1. 장바구니추가
	public void insertCart(CartDTO cart);

	// 2. 장바구니 목록
	List<CartDTO> listCart(long userId);

	// 3. 장바구니 삭제
	public void deleteCart(long Id);

	public void delete(CartDTO cart);

	// 4. 장바구니 수정
	public void modifyCart(CartDTO cart);

	// 5. 장바구니 금액 합계
	public int sumMoney(long userId);

	// 6. 장바구니 상품확인
	public int countCart(long merchandiseId, long userId);

	// 7. 장바구니 상품수량 변경
	public void updateCart(CartDTO cart);

	// 8. 체크된 장바구니 목록
	public CartListDTO buyList(Long cartId);
	
	public CartListDTO findCartId(long merchandiseId, long userId);
	


}
