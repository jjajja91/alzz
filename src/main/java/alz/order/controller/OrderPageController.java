package alz.order.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import alz.order.domain.CartListDTO;
import alz.order.domain.MerchandiseDTO;
import alz.order.domain.OrderDTO;
import alz.order.domain.OrderDetailDTO;
import alz.order.domain.OrderRequestDTO;
import alz.order.service.CartService;
import alz.order.service.MerchandiseService;
import alz.order.service.OrderService;
import alz.user.domain.UserDTO;
import alz.user.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
@RequestMapping("/order/*")
public class OrderPageController {

	private OrderService orderService;
	private MerchandiseService merchandiseService;
	private UserService userService;
	private CartService cartService;

	public UserDTO getLoginUserInfo() {
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication auth = context.getAuthentication();
		UserDTO userInfo = (UserDTO) auth.getPrincipal();
		return userInfo;
	}

	// 상품 상세에서 바로 구매
	@GetMapping("/orderForm")
	public void orderEach(@RequestParam("id") long merchandiseId, Model model) {

		long userId = getLoginUserInfo().getId();

		model.addAttribute("userInfo", userService.userInfo(userId));

		List<MerchandiseDTO> list = new ArrayList<MerchandiseDTO>();

		MerchandiseDTO merchandise = new MerchandiseDTO();

		merchandise = merchandiseService.readByrefId(merchandiseId);

		list.add(merchandise);
		
		model.addAttribute("buyList", list);
		model.addAttribute("merchandise", merchandise);

		/* 개별 구매 완료시 해당 아이템이 카트에 있다면 결제 후 카트에서 삭제해주는 것도 필요하겠네 */
	}

	// 장바구니 체크된 항목 구매하기
	@PostMapping("/orderForm")
	public void orderCart(@RequestParam("cartId") long[] cartId, Model model) throws Exception {

		long userId = getLoginUserInfo().getId();

		model.addAttribute("userInfo", userService.userInfo(userId));

		List<CartListDTO> list = new ArrayList<CartListDTO>();

		System.out.println("cartId.length : " + cartId.length);
		// 장바구니 목록중 선택한것 가져오기
		for (int i = 0; i < cartId.length; i++) {
			long no = 0;
			CartListDTO cartList = new CartListDTO();
			no = cartId[i];
			cartList = cartService.buyList(no);
			list.add(cartList);
		}

		if (!list.isEmpty()) {
			model.addAttribute("buyList", list);
		}

	}

	@GetMapping("/buy")
	public void orderform(@RequestParam("orderId") String orderId, Model model) throws Exception {

		// 모델에 유저 정보 추가
		model.addAttribute("orderId", orderId);

		List<OrderDetailDTO> orderList = orderService.orderResult(orderId);
		OrderDTO order = orderService.findOrderer(orderId);
		
		model.addAttribute("orderList", orderList);
		model.addAttribute("orderer", order);
		

		// 카트 비우기
		long userId = getLoginUserInfo().getId();
		orderService.removeCart(userId);

	}

	@PostMapping("/payForKakao")
	public void payForKakao(@RequestParam("name") String name,@RequestParam("phone") String phone, @RequestParam("cartId") long[] cartId, Model model, @RequestParam("merchandise") String id,
			@RequestParam("merchandiseName") String[] merchandiseName, @RequestParam("totalPrice") long totalPrice, @RequestParam("method") String method) {

		System.out.println("method: "+method);
		System.out.println("상품아이디 : " + id);
		long userId = getLoginUserInfo().getId();

		int merchandises = cartId.length - 1;

		model.addAttribute("userInfo", userService.userInfo(userId));
		model.addAttribute("orderer", name);
		model.addAttribute("orderPhone", phone);
		model.addAttribute("merchandiseName", merchandiseName[0]);
		model.addAttribute("merchandise", id);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("merchandises", merchandises);
		model.addAttribute("method", method);

		List<CartListDTO> list = new ArrayList<CartListDTO>();
		System.out.println("장바구니 상품 개수 :" +cartId.length);
		// 장바구니 목록중 선택한것 가져오기
		for (int i = 0; i < cartId.length; i++) {
			long no = 0;
			CartListDTO cartList = new CartListDTO();
			no = cartId[i];
			cartList = cartService.buyList(no);
			list.add(cartList);
		}

		if (!list.isEmpty()) {
			model.addAttribute("buyList", list);
		} 

		System.out.println("list : " + list);

	}
	
	@PostMapping("/payForInicis")
	public void payForInicis(@RequestParam("name") String name,@RequestParam("phone") String phone, @RequestParam("cartId") long[] cartId, Model model, @RequestParam("merchandise") String id,
			@RequestParam("merchandiseName") String[] merchandiseName, @RequestParam("totalPrice") long totalPrice, @RequestParam("method") String method) {

		System.out.println(method);
		System.out.println("상품아이디 : " + id);
		long userId = getLoginUserInfo().getId();

		int merchandises = cartId.length - 1;

		model.addAttribute("userInfo", userService.userInfo(userId));
		model.addAttribute("orderer", name);
		model.addAttribute("orderPhone", phone);
		model.addAttribute("merchandiseName", merchandiseName[0]);
		model.addAttribute("merchandise", id);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("merchandises", merchandises);

		List<CartListDTO> list = new ArrayList<CartListDTO>();
		System.out.println("장바구니 상품 개수 :" +cartId.length);
		// 장바구니 목록중 선택한것 가져오기
		for (int i = 0; i < cartId.length; i++) {
			long no = 0;
			CartListDTO cartList = new CartListDTO();
			no = cartId[i];
			cartList = cartService.buyList(no);
			list.add(cartList);
		}

		if (!list.isEmpty()) {
			model.addAttribute("buyList", list);
		} 

		System.out.println("list : " + list);

	}

	@PostMapping("/addNewOrder")
	@ResponseBody
	public String orderInsert(@RequestBody OrderRequestDTO order, Model model) throws Exception {

		System.out.println("addNewOrder: " + order);

		long userId = getLoginUserInfo().getId();

		model.addAttribute("userInfo", userService.userInfo(userId));

		System.out.println(order.getId());
		// 주문에 유저 아이디와 생성된 주문번호 추가
		order.setUserId(userId);
		// 주문등록
		orderService.insertOrder(order);
		System.out.println("orderInsert Complete");


		return "redirect:/order/buy";

	}


}
