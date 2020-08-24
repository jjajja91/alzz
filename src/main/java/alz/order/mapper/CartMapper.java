package alz.order.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import alz.order.domain.CartDTO;
import alz.order.domain.CartListDTO;

public interface CartMapper {

	// 1. 장바구니추가
	public void insertCart(CartDTO cart);

	// 2. 장바구니 리스트
	public List<CartDTO> listCart(long userId);

	// 3. 장바구니 삭제
	public void deleteCart(long cartNum);
	public void delete(CartDTO cart);

	// 4. 장바구니 수정
	public void modifyCart(CartDTO cart);

	// 5. 장바구니 금액 합계
	public int sumMoney(long userId);

	// 6. 장바구니 상품확인
	public int countCart(@Param("merchandiseId") long merchandiseId, @Param("userId") long userId);

	// 7. 장바구니 상품수량 변경
	public void updateCart(CartDTO cart);

	// 8. 장바구니 체크 리스트
	public CartListDTO buyList(long cartId);
	
	
	public CartListDTO findCartId(@Param("merchandiseId") long merchandiseId, @Param("userId") long userId);


}
