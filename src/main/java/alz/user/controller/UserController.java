package alz.user.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import alz.user.domain.UserDTO;
import alz.user.service.UserService;
import alz.user.sms.Coolsms;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class UserController {

	@Autowired
	UserService userService; // 서비스를 호출하기 위해 의존성을 주입
	
	public UserDTO getLoginUserInfo() {
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication auth = context.getAuthentication();
		UserDTO userInfo = (UserDTO)auth.getPrincipal();
		return userInfo;
	}

//	@ModelAttribute("path")
//	public String getContextPath(HttpServletRequest request) {
//		return request.getContextPath();
////      /login 을 출력합니다
//	}
//
//	@ModelAttribute("serverTime")
//	public String getServerTime(Locale locale) {
//
//		Date date = new Date();
//		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
//
//		return dateFormat.format(date);
//	}

	@RequestMapping(value = "/callSMS", method = RequestMethod.GET)
	public String callSMS() {
		return "user/anonymous/SMS";
	}

	// 문자를 보낼때 맵핑되는 메소드
	@RequestMapping(value = "/sendSms")
	public String sendSms(HttpServletRequest request) throws Exception {

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ api키 넣기
		String api_key = ""; // 위에서 받은 api key를 추가
		String api_secret = ""; // 위에서 받은 api secret를 추가

		Coolsms coolsms = new Coolsms(api_key, api_secret);
		// 이 부분은 홈페이지에서 받은 자바파일을 추가한다음 그 클래스를 import해야 쓸 수 있는 클래스이다.

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@번호 넣기
		HashMap<String, String> set = new HashMap<String, String>();
		set.put("to", ""); // 수신번호

		set.put("from", (String) request.getParameter("from")); // 발신번호, jsp에서 전송한 발신번호를 받아 map에 저장한다.
		set.put("text", (String) request.getParameter("text")); // 문자내용, jsp에서 전송한 문자내용을 받아 map에 저장한다.
		set.put("type", "sms"); // 문자 타입

		System.out.println(set);

		JSONObject result = coolsms.send(set); // 보내기&전송결과받기

		if ((boolean) result.get("status") == true) {

			// 메시지 보내기 성공 및 전송결과 출력
			System.out.println("성공");
			System.out.println(result.get("group_id")); // 그룹아이디
			System.out.println(result.get("result_code")); // 결과코드
			System.out.println(result.get("result_message")); // 결과 메시지
			System.out.println(result.get("success_count")); // 메시지아이디
			System.out.println(result.get("error_count")); // 여러개 보낼시 오류난 메시지 수
		} else {

			// 메시지 보내기 실패
			System.out.println("실패");
			System.out.println(result.get("code")); // REST API 에러코드
			System.out.println(result.get("message")); // 에러메시지
		}

		return "/user/anonymous/Success"; // 문자 메시지 발송 성공했을때 number페이지로 이동함
	}

	// 로그인 페이지
	@GetMapping("/login")
	public String login() {
		return "user/users/login";
	}

	// 가입 페이지
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() {
		return "user/anonymous/join";
	}

	// 마이페이지 페이지
	@RequestMapping(value = "/callMypage", method = RequestMethod.GET)
	public String callMypage() {
		return "/myPage";
	}

	// 수정 페이지
	@GetMapping("/modify")
	public String callUpdate() {
		System.out.println(getLoginUserInfo().getNickname());
		return "/user/users/Modify";
	}

	// 아이디 찾기 페이지
	@RequestMapping(value = "/find_id_form")
	public String find_id_form() throws Exception {
		return "/user/users/find_id_form";
	}

//	// 비밀번호 찾기 페이지로 이동
//	@RequestMapping("/find_password_form")
//	public String find_password_form() {
//		return "user/users/find_password_form";
//	}
	
	@GetMapping("/findPwd")
	public String findPwd() {
		return "/user/users/findPwd";
	}

//위에는 페이지로 보내주는
//------------------------------------------------------------------
//아래는 로직

	// 회원가입 페이지에서 버튼을 누르면 @RequestMapping을 찾아 실행한다.
	// Form의 값들은 HttpServletRequest에 담겨서 넘어온다.
	// Controller에서 받은 Param 값들은 Model에 담아 다시 View 페이지로 전달할 수 있습니다. Model은 데이터만 담는다
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public String Insert(UserDTO user, HttpServletRequest request, Model model) {

		model.addAttribute("email", request.getParameter("email"));
		model.addAttribute("nickname", request.getParameter("nickname"));
		model.addAttribute("phoneNumber", request.getParameter("phoneNumber"));

		// 회원가입 메서드
		userService.create(user);

		return "home";
	}

	// ModelAndView는 스프링에서 제공하는 자체 객체로서 데이터랑 view의 이름을 같이 전달함.
	// login시 session.setAttribute 했던 값을 getAttribute( "저장했던 값" )을 통해 호출 할 수 있음
	@RequestMapping(value = "/updateById", method = RequestMethod.POST)
	public ModelAndView Modify(HttpServletRequest request, UserDTO user) {

		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		UserDTO dto = userService.updateById(user);

		if (dto == null) {
			mv.setViewName("/user/users/Modify");
		} else {
			session.setAttribute("sessionUser", dto);
			mv.setViewName("/user/users/ModifyInfo");
		}

		return mv;
	}

	// 소셜회원 최초 로그인 시 가입화면
	@GetMapping("/socialJoin")
	public String socialJoin() {
		return "user/anonymous/socialJoin";
	}

	// 소셜 로그인 시 로그인 처리
	@GetMapping("/socialLogin")
	public String socialLogin(String email, String id, Model model) {
		model.addAttribute("email", email);
		model.addAttribute("id", id);
		return "user/users/socialLogin";
	}

	// 카카오 요청
	@GetMapping("/kakao/request")
	@ResponseBody
	public Map<String, String> requestKakao(HttpSession session) {

		String clientId = "bbee380452a4341a2b39cba2ef0bdefe";
		String redirectUrl = "http://localhost:8080/kakao/oauth";
		String kakaoLoginUrl = "https://kauth.kakao.com/oauth/authorize?" + "client_id=" + clientId + "&redirect_uri="
				+ redirectUrl + "&response_type=code";

		Map<String, String> map = new HashMap<String, String>();
		map.put("url", kakaoLoginUrl);
		return map;
	}

	// 카카오 인증
	@GetMapping("/kakao/oauth")
	public String kakaoLogin(String code, RedirectAttributes rttr) {
		String accessToken = userService.getKakaoAccessToken(code);
		HashMap<String, Object> userInfo = userService.getKakaoUserInfo(accessToken);
		System.out.println("login Controller : " + userInfo);

		String email = userInfo.get("email").toString();
		String password = userInfo.get("id").toString();
		
		if (userService.duplicateCheck(email)) {
			return "redirect:/socialLogin?email="+ email + "&id=" +password;
		} else {
			rttr.addFlashAttribute("email", email);
			rttr.addFlashAttribute("id", password);
			rttr.addFlashAttribute("role", "ROLE_KAKAO");
			return "redirect:/socialJoin";
		}
	}

	// 네이버 요청
	@GetMapping("/naver/request")
	@ResponseBody
	public Map<String, String> requestNaver(HttpSession session) throws UnsupportedEncodingException {
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130, random).toString(32);
		session.setAttribute("state", state);

		String clientId = "ukX6QVXRUc7_8u8KKks7";
		String redirectUrl = URLEncoder.encode("http://localhost:8080/naver/oauth", "UTF-8");
		String naverLoginUrl = "https://nid.naver.com/oauth2.0/authorize?response_type=code" + "&client_id=" + clientId
				+ "&redirect_uri=" + redirectUrl + "&state=" + (String) session.getAttribute("state");

		Map<String, String> map = new HashMap<String, String>();
		map.put("url", naverLoginUrl);
		return map;
	}

	// 네이버 인증
	@GetMapping("/naver/oauth")
	public String naverLogin(String code, String state, RedirectAttributes rttr) {
		String accessToken = userService.getNaverAccessToken(code, state);
		HashMap<String, Object> userInfo = userService.getNaverUserInfo(accessToken);
		System.out.println("login Controller : " + userInfo);

		String email = userInfo.get("email").toString();
		String password = userInfo.get("id").toString();

		if (userService.duplicateCheck(email)) {
			return "redirect:/socialLogin?email="+ email + "&id=" +password;
		} else {
			rttr.addFlashAttribute("email", email);
			rttr.addFlashAttribute("id", password);
			rttr.addFlashAttribute("role", "ROLE_NAVER");
			return "redirect:/socialJoin";
		}

	}

	// 구글 요청
	@GetMapping("/google/request")
	@ResponseBody
	public Map<String, String> requestGoogle(HttpSession session) throws UnsupportedEncodingException {
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130, random).toString(32);
		session.setAttribute("state", state);

		String clientId = "316214908433-1li7s1krvf7l2m5t5c832b1uol43p6pc.apps.googleusercontent.com";
		String redirectUrl = URLEncoder.encode("http://localhost:8080/google/oauth", "UTF-8");
		String googleLoginUrl = "https://accounts.google.com/o/oauth2/v2/auth?response_type=code&"
				+ "scope=openid%20profile%20email" + "&client_id=" + clientId + "&redirect_uri=" + redirectUrl
				+ "&state=" + (String) session.getAttribute("state");

		Map<String, String> map = new HashMap<String, String>();
		map.put("url", googleLoginUrl);
		return map;
	}

	// 구글 인증
	@GetMapping("/google/oauth")
	public String googleLogin(String code, RedirectAttributes rttr) {
		String accessToken = userService.getGoogleAccessToken(code);
		HashMap<String, Object> userInfo = userService.getGoogleUserInfo(accessToken);
		System.out.println("login Controller : " + userInfo);

		String email = userInfo.get("email").toString();
		String password = userInfo.get("id").toString();

		if (userService.duplicateCheck(email)) {
			return "redirect:/socialLogin?email="+ email + "&id=" +password;
		} else {
			rttr.addFlashAttribute("email", email);
			rttr.addFlashAttribute("id", password);
			rttr.addFlashAttribute("role", "ROLE_GOOGLE");
			return "redirect:/socialJoin";
		}

	}

	// 아이디 찾기 로직
	@RequestMapping(value = "/find_id", method = RequestMethod.POST)
	public String find_id(@RequestParam("nickname") String nickname, @Param("phoneNumber") String phoneNumber,
			HttpServletResponse response, Model md) throws Exception {

		if (nickname == null && phoneNumber == null) {
			System.out.println("일치하는 회원 정보가 없습니다.");
			return "user/users/find_id_form";
		} else 
		
		
		md.addAttribute("email", userService.find_id(nickname, phoneNumber, response));
		return "user/users/find_id";
	}
	
	@PostMapping("/modifyPwd")
	public String modifyPwd(UserDTO user) {
		log.info(user);
		System.out.println(user);
		if(userService.modifyPwd(user)) {
			System.out.println("성공"+user);
			return "redirect:/login";
		} else {
			System.out.println("실패"+user);
			return "redirect:/";
		}
	}

//	// 비밀번호 찾기 처리 (1) 이메일 발송
//	@RequestMapping(value = "/find_password_email", method = RequestMethod.POST)
//	public ModelAndView find_password_email(HttpServletRequest request, String email,
//			HttpServletResponse response_email) throws IOException {
//
//		// 랜덤한 난수 (인증번호)를 생성해서 이메일로 보내고 그 인증번호를 입력하면 비밀번호를 변경할 수 있는 페이지로 이동시킴
//
//		Random r = new Random();
//		int dice = r.nextInt(157211) + 48271;
//
//		String setfrom = "alz10041004@gmail.com";
//		String tomail = request.getParameter("email"); // 받는 사람의 이메일
//		String title = "비밀번호 찾기 인증 이메일 입니다."; // 제목
//		String content =
//
//				System.getProperty("line.separator") +
//
//						System.getProperty("line.separator") +
//
//						"안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다"
//
//						+ System.getProperty("line.separator") +
//
//						System.getProperty("line.separator") +
//
//						"비밀번호 찾기 인증번호는 " + dice + " 입니다. "
//
//						+ System.getProperty("line.separator") +
//
//						System.getProperty("line.separator") +
//
//						"받으신 인증번호를 홈페이지에 입력해 주시면 다음으로 넘어갑니다."; // 내용
//
//		try {
//
//			MimeMessage message = mailSender.createMimeMessage();
//			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
//
//			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
//			messageHelper.setTo(tomail); // 받는사람 이메일
//			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
//			messageHelper.setText(content); // 메일 내용
//
//			mailSender.send(message);
//
//		} catch (Exception e) {
//			System.out.println(e);
//		}
//
//		ModelAndView mv = new ModelAndView(); // ModelAndView로 보낼 페이지를 지정하고, 보낼 값을 지정한다.
//		mv.setViewName("/user/users/find_password_email"); // 뷰의이름
//		mv.addObject("dice", dice);
//		mv.addObject("email", email);
//
//		System.out.println("mv : " + mv);
//
//		response_email.setContentType("text/html; charset=UTF-8");
//		PrintWriter out_email = response_email.getWriter();
//		out_email.println("<script>alert('이메일이 발송되었습니다. 인증번호를 입력해주세요.');</script>");
//		out_email.flush();
//
//		return mv;
//
//	}
//
//	// 인증번호를 입력한 후에 확인 버튼을 누르면 자료가 넘어오는 컨트롤러
//	@RequestMapping(value = "/find_password_change{dice},{email}", method = RequestMethod.POST)
//	public ModelAndView find_password_change(String find_password_change, @PathVariable String dice,
//			@PathVariable String email, HttpServletResponse response_equals) throws IOException {
//
//		System.out.println("마지막 : find_password_change : " + find_password_change);
//
//		System.out.println("마지막 : dice : " + dice);
//
//		ModelAndView mv = new ModelAndView();
//
//		mv.setViewName("/user/users/find_password_change");
//
//		mv.addObject("email", email);
//
//		if (find_password_change.equals(dice)) {
//
//			// 인증번호가 일치할 경우 인증번호가 맞다는 창을 출력하고 비밀번호 변경창으로 이동시킨다
//
//			mv.setViewName("user/users/find_password_change");
//
//			mv.addObject("email", email);
//
//			// 만약 인증번호가 같다면 이메일을 비밀번호 변경 페이지로 넘기고, 활용할 수 있도록 한다.
//
//			response_equals.setContentType("text/html; charset=UTF-8");
//			PrintWriter out_equals = response_equals.getWriter();
//			out_equals.println("<script>alert('인증번호가 일치하였습니다. 비밀번호 변경창으로 이동합니다.');</script>");
//			out_equals.flush();
//
//			return mv;
//
//		} else if (find_password_change != dice) {
//
//			ModelAndView mv2 = new ModelAndView();
//
//			mv2.setViewName("user/users/find_password_email");
//
//			response_equals.setContentType("text/html; charset=UTF-8");
//			PrintWriter out_equals = response_equals.getWriter();
//			out_equals.println("<script>alert('인증번호가 일치하지않습니다. 인증번호를 다시 입력해주세요.'); history.go(-1);</script>");
//			out_equals.flush();
//
//			return mv2;
//		}
//		return mv;
//	}
//
//	// 변경할 비밀번호를 입력한 후에 확인 버튼을 누르면 넘어오는 컨트롤러
//	@RequestMapping(value = "/find_password_result", method = RequestMethod.POST)
//	public ModelAndView find_password_result(@RequestParam("email") String email, @RequestParam("password") String password, HttpServletRequest request,
//			HttpServletResponse pass) throws Exception {
//		
//		System.out.println(email);
//		System.out.println(password);
//
//		request.getParameter("password");
//		UserDTO dto = new UserDTO();
//		dto.setEmail(email);
//		dto.setPassword(password);
//
//		// 값을 여러개 담아야 하므로 해쉬맵을 사용해서 값을 저장함
//
//		Map<String, Object> map = new HashMap<>();
//
//		map.put("emai", dto.getEmail());
//		map.put("password", dto.getPassword());
//
//		userService.find_password_result(password, map, dto);
//
//		ModelAndView mv = new ModelAndView();
//
//		mv.setViewName("user/users/find_password_result");
//
//		return mv;
//
//	}

}

//   @GetMapping("/async-handler")
//   @ResponseBody
//   public Callable<String> asyncHandler() {
//      SecurityLogger.log("MVC");
//      return () -> {
//            SecurityLogger.log("Callable");
//            return "Async Handler";
//      };
//   }
//
//   @GetMapping("/async-service")
//   @ResponseBody
//   public String asyncService() {
//      SecurityLogger.log("MVC, before async service");
//      userService.asyncService();
//      SecurityLogger.log("MVC, after async service");
//      return "Async Service";
//   }

