package alz.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import alz.admin.service.LessonServiceAdmin;
import alz.admin.service.MemberService;
import alz.admin.service.OrdersService;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
public class AdminPageController {
 
	private LessonServiceAdmin classService;
	private MemberService memberService;
	private OrdersService orderService;

	@Autowired
	public AdminPageController(LessonServiceAdmin classService, MemberService memberService, OrdersService orderService) {
		this.memberService = memberService;
		this.classService = classService;
		this.orderService = orderService;
	}
	
	@GetMapping("/index")
	public void index() {
	}

	
}
