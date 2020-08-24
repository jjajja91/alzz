package alz.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import alz.order.domain.CartDTO;
import alz.order.service.CartService;
import alz.order.service.MerchandiseService;
import alz.user.domain.UserDTO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/merchandise/*")
public class CartController {

	private CartService cartService;
	private MerchandiseService merchandiseService;

	// 장바구니 페이지 연결
//	@GetMapping("/cartList")
//	public void cartList(Principal pr, OrderDTO order, OrderDetailDTO orderDetail) throws Exception {
//
//	}

	public UserDTO getLoginUserInfo() {
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication auth = context.getAuthentication();
		UserDTO userInfo = (UserDTO) auth.getPrincipal();
		return userInfo;
	}

	// 장바구니 추가
	@PostMapping("/cartInsert")
	@ResponseBody
	public String addCart(@ModelAttribute CartDTO cart, @RequestParam("id") long id) {

		System.out.println("id: "+id);

		long merchandiseId = merchandiseService.findMerchandiseId(id);
		long userId = getLoginUserInfo().getId();
		System.out.println("merchandiseId: "+ merchandiseId);
		cart.setUserId(userId);

		String result = "false";
		// 카트에 닉네임, 상품 저장
		cart.setUserId(userId);
		cart.setMerchandiseId(merchandiseId);
		// 장바구니에 기존 상품이 있는지 검사
		int count = cartService.countCart(cart.getMerchandiseId(), userId);
		if (count == 0) {
			// 없으면 insert
			cartService.insertCart(cart);
			result = "true";
		}

		return result;
	}

	// 장바구니 처리
	@GetMapping("/cart")
	public ModelAndView list(@ModelAttribute CartDTO cart, ModelAndView mav) {

		// 장바구니 정보를 담을 map 생성
		Map<String, Object> map = new HashMap<String, Object>();

		long userId = getLoginUserInfo().getId();

		cart.setUserId(userId);

		List<CartDTO> list = cartService.listCart(userId); // 장바구니 정보
		int sumMoney = cartService.sumMoney(userId); // 장바구니 전체 금액 호출

		map.put("list", list); // 장바구니 정보를 map에 저장
		map.put("count", list.size()); // 장바구니 상품의 유무
		map.put("sumMoney", sumMoney); // 장바구니 전체 금액
		map.put("allSum", sumMoney); // 주문 상품 전체 금액
		mav.setViewName("merchandise/cartList"); // view(jsp)의 이름 저장
		mav.addObject("map", map); // map 변수 저장

		return mav;
	}

	// 장바구니 삭제(x버튼)
	@GetMapping("delete")
	public String delete(@RequestParam long id) {
		System.out.println(getLoginUserInfo().getId());
		cartService.deleteCart(id);
		return "redirect:/merchandise/cart";
	}

	// 장바구니 삭제(체크박스)
	@PostMapping("delete")
	@ResponseBody
	public String deleteCart(@RequestParam(value = "chkbox[]") List<String> chArr, CartDTO cart) throws Exception {
		log.info("delete cart");

		UserDTO user = getLoginUserInfo();
		long userId = user.getId();

		String result = "0";
		long id = 0;

		if (user != null) {
			cart.setUserId(userId);

			for (String i : chArr) {
				id = Long.parseLong(i);
				cart.setId(id);
				cartService.delete(cart);
			}
			result = "1";
		}

		log.info(id);
		return result;

	}
}