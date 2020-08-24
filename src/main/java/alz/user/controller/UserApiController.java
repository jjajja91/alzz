package alz.user.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import alz.user.domain.UserDTO;
import alz.user.service.UserService;


@RestController
@RequestMapping("/users")
public class UserApiController {
	
	@Autowired // 서비스를 호출하기 위해서 의존성을 주입
	JavaMailSender mailSender; // 메일 서비스를 사용하기 위해 의존성을 주입함.

	private UserService userService;

	@Autowired
	public UserApiController(UserService userService) {
		this.userService = userService;
	}

	
	public UserDTO getLoginUserInfo() {
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication auth = context.getAuthentication();
		UserDTO userInfo = (UserDTO)auth.getPrincipal();
		return userInfo;
	}
	
	
//	@PostMapping
//	public ResponseEntity<?> create(@RequestBody UserDTO user) {
//		UserDTO openedUser = userService.create(user);
//		return ResponseEntity.status(HttpStatus.CREATED).body(openedUser);
//	}
	
	// 이메일 중복 체크
	@PostMapping(value = "/emailChk", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<?> emailChk(@RequestBody UserDTO user) {
		boolean result = userService.emailChk(user.getEmail());
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}
	
	// 닉네임 중복 체크
	@GetMapping(value = "/nicknameChk/{nickname}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<?> nicknameChk(@PathVariable String nickname) {
		boolean result = userService.nicknameChk(nickname);
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}
	
	// 전화번호 중복 체크 (사용 X)
	@PostMapping(value = "/phoneNumberChk", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<?> phoneNumberChk(@RequestBody UserDTO user) {
		UserDTO foundUser = userService.readByPhoneNumber(user.getPhoneNumber());
		return ResponseEntity.status(HttpStatus.OK).body(foundUser);
	}
	
//	@GetMapping
//	public ResponseEntity<?> readAll() {
//		List<UserDTO> user = userService.readAll();
//		return ResponseEntity.status(HttpStatus.OK).body(user);
//	}
//
	// 개인 정보 수정
	@PutMapping(produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> updateOne(@RequestBody UserDTO user) {
		user.setId(getLoginUserInfo().getId());
		UserDTO updatedUser = userService.updateById(user);
		return ResponseEntity.status(HttpStatus.OK).body(updatedUser);
	}
	
	@PostMapping(value = "/checkUser", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<?> checkUser(@RequestBody UserDTO user) {
		System.out.println(user);
		boolean result = userService.findUserByEmailNickname(user);
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}
	
	// 이메일 인증
	@PostMapping(value = "/emailCode", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> sendEmailCode(@RequestBody String email){
		// 랜덤한 난수 (인증번호)를 생성해서 이메일로 보내고 그 인증번호를 입력하면 비밀번호를 변경할 수 있는 페이지로 이동시킴

		Random r = new Random();
		int dice = r.nextInt(157211) + 48271;

		String setfrom = "alz10041004@gmail.com";
		String tomail = email;
		String title = "비밀번호 찾기 인증 이메일 입니다."; // 제목
		String content =

				System.getProperty("line.separator") +

						System.getProperty("line.separator") +

						"안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다"

						+ System.getProperty("line.separator") +

						System.getProperty("line.separator") +

						"비밀번호 찾기 인증번호는 " + dice + " 입니다. "

						+ System.getProperty("line.separator") +

						System.getProperty("line.separator") +

						"받으신 인증번호를 홈페이지에 입력해 주시면 다음으로 넘어갑니다."; // 내용

		try {

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content); // 메일 내용

			mailSender.send(message);

		} catch (Exception e) {
			System.out.println(e);
		}
		
		return ResponseEntity.status(HttpStatus.OK).body(dice);
	}
	
//
//	@DeleteMapping("/{id}")
//	public ResponseEntity<?> deleteOne(@PathVariable UserDTO user) {
//		int affectedRowCount = userService.deleteById(user, null);
//		return ResponseEntity.status(HttpStatus.OK).body("ok");
//	}
}
