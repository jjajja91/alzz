package alz.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import alz.admin.service.AdminUserService;
import alz.user.domain.UserDTO;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class AdminUserController {

	@Autowired
	AdminUserService adminUserService; // 서비스를 호출하기 위해 의존성을 주입

//	private static final Logger logger = LoggerFactory.getLogger(AdminUserController.class);

	// 01 회원 목록
	// url pattern mapping
	@RequestMapping("admin/list")
	public String userList(Model model) {
		// controller => service => dao 요청
		List<UserDTO> list = adminUserService.userList();
		model.addAttribute("list", list);
		return "admin/user/member_list";
	}

	// 02_01 회원 등록 페이지로 이동
	@RequestMapping("admin/write")
	public String userWrite() {

		return "admin/user/member_write";
	}

//	// 02_02 회원 등록 처리 후 ==> 회원목록으로 리다이렉트
//	// @ModelAttribute에 폼에서 입력한 데이터가 저장된다.
//	@RequestMapping("admin/insertManager")
//	// * 폼에서 입력한 데이터를 받아오는 법 3가지
//	// public String userInsert(HttpServlet request){
//	// public String userInsert(String email, String password, String userName,
//	// String userEmail){
//	public String InsertManager(@ModelAttribute UserDTO dto) {
//		// 테이블에 레코드 입력
//		dto.setRole("ROLE_ADMIN");
//		adminUserService.insertManager(dto);
//		// * (/)의 유무에 차이
//		// /admin/list : 루트 디렉토리를 기준
//		// admin/list : 현재 디렉토리를 기준
//		// member_list.jsp로 리다이렉트
//		return "redirect:/admin/list";
//	}
//
//	// 02_02 회원 등록 처리 후 ==> 회원목록으로 리다이렉트
//	// @ModelAttribute에 폼에서 입력한 데이터가 저장된다.
//	@RequestMapping("admin/insertUser")
//	// * 폼에서 입력한 데이터를 받아오는 법 3가지
//	// public String userInsert(HttpServlet request){
//	// public String userInsert(String email, String password, String userName,
//	// String userEmail){
//	public String InsertUser(@ModelAttribute UserDTO dto) {
//		// 테이블에 레코드 입력
//		dto.setRole("ROLE_USER");
//		adminUserService.insertUser(dto);
//		// * (/)의 유무에 차이
//		// /admin/list : 루트 디렉토리를 기준
//		// admin/list : 현재 디렉토리를 기준
//		// member_list.jsp로 리다이렉트
//		return "redirect:/admin/list";
//	}

	// 03 회원 상세정보 조회
	@RequestMapping("admin/view")
	public String userView(@RequestParam String email, Model model) {
		// 회원 정보를 model에 저장
		model.addAttribute("dto", adminUserService.viewUser(email));
		System.out.println("클릭한 아이디 확인 : " + email);
//		logger.info("클릭한 아이디 : " + email);
		// member_view.jsp로 포워드
		return "admin/user/member_view";
	}

	// 04. 회원 정보 수정 처리
	@RequestMapping("admin/update")
	public String userUpdate(@ModelAttribute UserDTO dto, Model model) {
		// 비밀번호 체크
		boolean result = adminUserService.checkPw(dto);
		if (result) { // 비밀번호가 일치하면 수정 처리후, 전체 회원 목록으로 리다이렉트
			adminUserService.updateUser(dto);
			model.addAttribute("dto", dto);
			model.addAttribute("message", "수정 완료");
//			return "redirect:/admin/member_view";
			return "admin/user/member_view";
		} else { // 비밀번호가 일치하지 않는다면, div에 불일치 문구 출력, viwe.jsp로 포워드
			// 가입일자, 수정일자 저장
			UserDTO dto2 = adminUserService.viewUser(dto.getEmail());
			model.addAttribute("dto", dto);
			model.addAttribute("message", "비밀번호 불일치");
			return "admin/user/member_view";
		}

	}

//	// 05. 회원정보 삭제 처리
//	// @RequestMapping : url mapping
//	// @RequestParam : get or post방식으로 전달된 변수값
//	@RequestMapping("admin/delete")
//	public String userDelete(UserDTO dto, Model model) {
//		// 비밀번호 체크
//		boolean result = adminUserService.checkPw(dto);
//		if (result) { // 비밀번호가 맞다면 삭제 처리후, 전체 회원 목록으로 리다이렉트
//			adminUserService.deleteUser(dto);
//			return "redirect:/admin/list";
//		} else { // 비밀번호가 일치하지 않는다면, div에 불일치 문구 출력, viwe.jsp로 포워드
//			model.addAttribute("message", "비밀번호 불일치");
//			model.addAttribute("dto", adminUserService.viewUser(dto.getEmail()));
//			return "admin/user/member_view";
//		}
//	}

	// 관리자로 로그인한 후에 회원정보 버튼을 누르면 맵핑되는 메소드 회원정보 페이지로 이동시킨다.
	@RequestMapping(value = "/admin/admin_member_info")
	public String member_info() throws Exception {

		return "admin/user/member_info";
	}

	// 회원아이디로 해당 회원의 정보를 검색하는 메소드
	@RequestMapping(value = "/admin/find_member")
	public ModelAndView find_member_info(String email, UserDTO dto) throws Exception {

		// 데이터베이스에서 검색한 값들을 DTO타입에 LIST에 저장한다.
		List<UserDTO> list = adminUserService.find_member_info(email); // 넘길 데이터가 많기 때문에

		Map<String, Object> map = new HashMap<>();

		// map에 리스트를 저장해서 출력할 view로 이동시킨다.
		// list가 null이면 회원정보가 없는것이므로 경고창을 출력하도록 함

		ModelAndView mv = new ModelAndView();

		// if문에서 list null처리를 할때에는 isEmpty()를 사용해서 null체크후 처리를 해주어야 한다.
		// list안에 값이 들어있을때 실행되는 구문
		if (!list.isEmpty()) {

//						// join_date의 형식을 바꾸어야 하기 때문에 join_date만 따로 빼서 형식을 변경한 후에 따로 넘긴다.
//						for (int i = 0; i < list.size(); i++) {
//							join_date = list.get(i).getJoin_date();
//						}
//						String re_join_date = new SimpleDateFormat("yyyy-MM-dd").format(join_date);
//						map.put("re_join_date", re_join_date);
			map.put("list", list);
			mv.addObject("map", map);

			mv.setViewName("admin/user/member_info");

		} else {
			mv.addObject("message", "회원정보가 없는 회원입니다.");
			mv.setViewName("admin/user/member_info");
		}

		return mv;
	}

	// 관리자로 로그인 후에 회원을 강제 탈퇴시키는 페이지로 연결시키는 메소드
	@RequestMapping("/admin/changeStateView")
	public String admin_member_forced_evction_view() {

		return "admin/user/changeState";
	}

	// 관리자로 로그인 후에 강제 탈퇴시킬 회원의 아이디를 입력후 강제탈퇴 버튼을 누르면 연결되는 메소드
	@RequestMapping("/admin/dropOut")
	public ModelAndView dropOut(String email) throws Exception {

		// 유저의 아이디를 강제탈퇴 시키기위해서 dto에 담는다.
		UserDTO dto = new UserDTO();
		dto.setEmail(email);

		// 회원탈퇴 체크를 하기위한 메소드, 탈퇴 시키려는 회원의 아이디가 있는지 검사한후에 result 변수에 저장한다.
		adminUserService.dropOut(dto);

		ModelAndView mv = new ModelAndView();

		if (dto.getEmail() != null) { // 회원 강제탈퇴가 성공했을시 출력되는 뷰
			mv.addObject("message", "회원이 정상적으로 강제탈퇴 처리 되었습니다.");
			mv.setViewName("admin/index");
		} else {
			mv.addObject("message", "회원 목록에 없는 회원입니다. 다시 확인해주세요.");
			mv.setViewName("admin/changeStateView");
		}
		return mv;

	}

	// 관리자로 로그인 후에 강제 정지시킬 회원의 아이디를 입력후 강제정지 버튼을 누르면 연결되는 메소드
	@RequestMapping("/admin/suspended")
	public ModelAndView suspended(String email) throws Exception {

		// 유저의 아이디를 정지 시키기위해서 dto에 담는다.
		UserDTO dto = new UserDTO();
		dto.setEmail(email);

		// 회원정지 체크를 하기위한 메소드, 정지 시키려는 회원의 아이디가 있는지 검사한후에 result 변수에 저장한다.
		adminUserService.suspended(dto);

		ModelAndView mv = new ModelAndView();

		if (dto.getEmail() != null) { // 회원 강제정지가 성공했을시 출력되는 뷰
			mv.addObject("message", "회원이 정상적으로 강제정지 처리 되었습니다.");
			mv.setViewName("admin/index");

		} else {
			mv.addObject("message", "회원 목록에 없는 회원입니다. 다시 확인해주세요.");
			mv.setViewName("admin/changeStateView");
		}
		return mv;

	}

	// 관리자로 로그인 후에 휴면전환시킬 회원의 아이디를 입력후 휴면전환 버튼을 누르면 연결되는 메소드
	@RequestMapping("/admin/inactive")
	public ModelAndView inactive(String email) throws Exception {

		// 유저의 아이디를 휴면전환 시키기위해서 dto에 담는다.
		UserDTO dto = new UserDTO();
		dto.setEmail(email);

		// 휴면전환 체크를 하기위한 메소드, 휴면전환 시키려는 회원의 아이디가 있는지 검사한후에 result 변수에 저장한다.
		adminUserService.inactive(dto);

		ModelAndView mv = new ModelAndView();

		if (dto.getEmail() != null) { // 회원 휴면전환가 성공했을시 출력되는 뷰
			mv.addObject("message", "회원이 정상적으로 휴면전환 처리 되었습니다.");
			mv.setViewName("admin/index");
		} else {
			mv.addObject("message", "회원 목록에 없는 회원입니다. 다시 확인해주세요.");
			mv.setViewName("admin/changeStateView");
		}
		return mv;

	}

	// 관리자로 로그인 후에 일반회원으로 전환시킬 회원의 아이디를 입력후 일반 버튼을 누르면 연결되는 메소드
	@RequestMapping("/admin/backNormal")
	public ModelAndView backNormal(String email) throws Exception {
		
		// 유저의 아이디를 일반회원으로 전환 시키기위해서 dto에 담는다.
		UserDTO dto = new UserDTO();
		dto.setEmail(email);
		
		// 일반회원 체크를 하기위한 메소드, 일반회원으로 전환 시키려는 회원의 아이디가 있는지 검사한후에 result 변수에 저장한다.
		adminUserService.backNormal(dto);
		
		ModelAndView mv = new ModelAndView();
		
		if (dto.getEmail() != null) { // 회원이 일반회원으로 전환을 성공했을시 출력되는 뷰
			mv.addObject("message", "회원이 정상적으로 일반회원으로 전환 처리 되었습니다.");
			mv.setViewName("admin/index");
		} else {
			mv.addObject("message", "회원 목록에 없는 회원입니다. 다시 확인해주세요.");
			mv.setViewName("admin/changeStateView");
		}
		return mv;
		
	}
	// 관리자로 로그인 후에 일반회원으로 전환시킬 회원의 아이디를 입력후 일반 버튼을 누르면 연결되는 메소드
	@RequestMapping("/admin/asUser")
	public ModelAndView asUser(String email) throws Exception {
		
		// 유저의 아이디를 일반회원으로 전환 시키기위해서 dto에 담는다.
		UserDTO dto = new UserDTO();
		dto.setEmail(email);
		
		// 일반회원 체크를 하기위한 메소드, 일반회원으로 전환 시키려는 회원의 아이디가 있는지 검사한후에 result 변수에 저장한다.
		adminUserService.asUser(dto);
		
		ModelAndView mv = new ModelAndView();
		
		if (dto.getEmail() != null) { // 회원이 일반회원으로 전환을 성공했을시 출력되는 뷰
			mv.addObject("message", "해당 계정이 정상적으로 일반 계정으로 전환 처리 되었습니다.");
			mv.setViewName("admin/index");
		} else {
			mv.addObject("message", "회원 목록에 없는 회원입니다. 다시 확인해주세요.");
			mv.setViewName("admin/changeStateView");
		}
		return mv;
		
	}
	// 관리자로 로그인 후에 일반회원으로 전환시킬 회원의 아이디를 입력후 일반 버튼을 누르면 연결되는 메소드
	@RequestMapping("/admin/asManager")
	public ModelAndView asManager(String email) throws Exception {
		
		// 유저의 아이디를 일반회원으로 전환 시키기위해서 dto에 담는다.
		UserDTO dto = new UserDTO();
		dto.setEmail(email);
		
		// 일반회원 체크를 하기위한 메소드, 일반회원으로 전환 시키려는 회원의 아이디가 있는지 검사한후에 result 변수에 저장한다.
		adminUserService.asManager(dto);
		
		ModelAndView mv = new ModelAndView();
		
		if (dto.getEmail() != null) { // 회원이 일반회원으로 전환을 성공했을시 출력되는 뷰
			mv.addObject("message", "해당 계정이 정상적으로 관리자 계정으로 전환 처리 되었습니다.");
			mv.setViewName("admin/index");
			
		} else {
			mv.addObject("message", "회원 목록에 없는 회원입니다. 다시 확인해주세요.");
			mv.setViewName("admin/changeStateView");
		}
		return mv;
		
	}

}