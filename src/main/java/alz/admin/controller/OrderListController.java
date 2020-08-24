package alz.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import alz.admin.domain.OrderCriteria;
import alz.admin.domain.OrderPageDTO;
import alz.admin.service.OrdersService;
import alz.order.domain.OrderDTO;
import alz.order.domain.OrderDetailDTO;
import alz.order.service.OrderService;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
public class OrderListController {

	private OrdersService ordersService;
	// 기존 오더서비스 사용
	private OrderService orderService;

	@Autowired
	public OrderListController(OrdersService ordersService, OrderService orderService) {
		this.ordersService = ordersService;
		this.orderService = orderService;
	}

//	@GetMapping("/order/orderMain")
//	public void orderMain(Model model) {
//		model.addAttribute("list", ordersService.orderList());
//	}
	
	@GetMapping("/order/orderMain")
	public void orderMain(OrderCriteria cri, Model model) {
		System.out.println("list: " + cri);
		model.addAttribute("list", ordersService.orderListPaging(cri));
//		model.addAttribute("pageMaker", new OrderPageDTO(cri, 123));
		
		int total = ordersService.getTotal(cri);
		System.out.println("total: " + total);
		model.addAttribute("pageMaker", new OrderPageDTO(cri, total));
	}

	@GetMapping("/order/orderCanceled")
	public void orderCanceled() {
	}

	@GetMapping("/order/orderDetail")
	public void orderDetail(@RequestParam("id") String id, @ModelAttribute("cri") OrderCriteria cri, Model model) {
		// 모델에 유저 정보 추가
		model.addAttribute("orderId", id);

		List<OrderDetailDTO> orderList = orderService.orderResult(id);
		OrderDTO order = orderService.findOrderer(id);

		model.addAttribute("orderList", orderList);
		model.addAttribute("orderer", order);
	}
	
	@PostMapping("/order/stateChange")
	@ResponseBody
	public void stateChange(@RequestBody OrderDTO order, Model model) {
		
		ordersService.stateChange(order);
		
	}
	
}
