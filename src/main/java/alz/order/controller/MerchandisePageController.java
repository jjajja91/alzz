package alz.order.controller;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import alz.lesson.domain.LessonDTO;
import alz.lesson.domain.TeacherDTO;
import alz.lesson.service.LessonService;
import alz.order.domain.MerchandiseCriteria;
import alz.order.domain.MerchandiseDTO;
import alz.order.domain.MerchandisePageDTO;
import alz.order.service.MerchandiseService;
import alz.user.domain.UserDTO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/merchandise/*")
public class MerchandisePageController {

	private MerchandiseService merchandiseService;
	private LessonService lessonService;
	
	
	public UserDTO getLoginUserInfo() {
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication auth = context.getAuthentication();
		UserDTO userInfo = (UserDTO)auth.getPrincipal();
		return userInfo;
	}

	@GetMapping("/register")
	public void register(Model model) {
		TeacherDTO teacher = lessonService.teacherByUserId(getLoginUserInfo().getId());
		System.out.println("teacher : " + teacher);
		LessonDTO myLesson = new LessonDTO();
		myLesson.setTeacherId(teacher.getId()).setState(4L);
		System.out.println("myLesson : " + myLesson);
		List<LessonDTO> lessonList = lessonService.lessonsByTeacherId(myLesson);
		System.out.println(lessonList);
		model.addAttribute("lessonList", lessonList);
	}

//	@GetMapping("/list")
//	public void list(Model model) {
//
//		log.info("list");
//		model.addAttribute("list", merchandiseService.readAll());
//
//	}

	// 목록 출력
	@GetMapping("/list")
	public void list(MerchandiseCriteria cri, Model model) {
		System.out.println("cri: " + cri);
		model.addAttribute("list", merchandiseService.readAll(cri));
		
		int total = merchandiseService.getTotal(cri);

		System.out.println("total: " + total);

		model.addAttribute("pageMaker", new MerchandisePageDTO(cri, total));
	}

	// 상품 등록
	@PostMapping("/register")
	public String register(MerchandiseDTO merchandise, RedirectAttributes rttr) {

		log.info("register: " + merchandise);

		merchandiseService.create(merchandise);

		rttr.addFlashAttribute("result", merchandise.getId());

		return "redirect:/merchandise/list";
	}

	// 상품 상세 및 수정
	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("id") Long id, @ModelAttribute("cri") MerchandiseCriteria cri, Model model) {

		log.info("/get or modify");
		model.addAttribute("merchandise", merchandiseService.readById(id));
	}

	// 상품 삭제
	@PostMapping("/remove")
	public String remove(@RequestParam("id") Long id, @ModelAttribute("cri") MerchandiseCriteria cri,
			RedirectAttributes rttr) {

		log.info("remove..." + id);
		if (merchandiseService.deleteById(id) == id) {
			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/merchandise/myList" + cri.getListLink();
	}

	// 상품 삭제
	@PostMapping("/modify")
	public String modify(@RequestParam("id") Long id, @ModelAttribute("cri") MerchandiseCriteria cri,
			MerchandiseDTO merchandise, RedirectAttributes rttr) {
		log.info("modify:" + merchandise);
		System.out.println(merchandise);

		if (merchandiseService.updateById(id, merchandise) != null) {
			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/merchandise/myList" + cri.getListLink();
	}
	
	// 로그인한 선생님의 수업 리스트
	@GetMapping("/myList")
	public void myList(MerchandiseCriteria cri, Model model) {
		
		long userId = getLoginUserInfo().getId();
		cri.setUserId(userId);
		
		System.out.println("cri: " + cri);
		model.addAttribute("list", merchandiseService.readMyLesson(cri));
		
		int total = merchandiseService.getCount(cri);

		System.out.println("total: " + total);

		model.addAttribute("pageMaker", new MerchandisePageDTO(cri, total));
	}

}
