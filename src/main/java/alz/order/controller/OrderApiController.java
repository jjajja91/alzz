package alz.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import alz.order.service.OrderService;
import alz.user.domain.UserDTO;

@RestController
@RequestMapping("/orders")
public class OrderApiController {

	private OrderService orderService;
	
	public UserDTO getLoginUserInfo() {
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication auth = context.getAuthentication();
		UserDTO userInfo = (UserDTO)auth.getPrincipal();
		return userInfo;
	}

	@Autowired
	public OrderApiController(OrderService orderService) {
		this.orderService = orderService;
	}

	// 새 주문 추가
//	@PostMapping("/addNewOrder")
//	public ResponseEntity<?> create(@RequestBody OrderDTO order) throws Exception {
//		orderService.insertOrder(order);
//		return ResponseEntity.status(HttpStatus.CREATED).body("");
//	}
//
//	@GetMapping("/{id}")
//	public ResponseEntity<?> readOne(@PathVariable Long id) {
//		return ResponseEntity.status(HttpStatus.OK).body("");
//	}
//
//	@GetMapping
//	public ResponseEntity<?> readAll() {
//		return ResponseEntity.status(HttpStatus.OK).body("");
//	}
//
//	@PutMapping("/{id}")
//	public ResponseEntity<?> updateOne(@PathVariable Long id, @RequestBody OrderDTO order) {
//		OrderDTO updatedOrder = orderService.updateById(id, order);
//		return ResponseEntity.status(HttpStatus.OK).body(updatedOrder);
//	}
//	
//	@DeleteMapping("/{id}")
//	public ResponseEntity<?> deleteOne(@PathVariable Long id) {
//		int affectedRowCount = orderService.deleteById(id);
//		return ResponseEntity.status(HttpStatus.OK).body(affectedRowCount);
//	}

}
