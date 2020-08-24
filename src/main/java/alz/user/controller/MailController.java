package alz.user.controller;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MailController {

	@Autowired
	private JavaMailSender mailSender;

   @RequestMapping(value = "/callMail", method = RequestMethod.GET)
   public String callSMS() {
	   return "user/anonymous/Mail";
   }
	
	// mailSending 코드
	@RequestMapping(value = "mailSending")
	public String mailSending(HttpServletRequest request
//			, MultipartHttpServletRequest multi
			) {

		String setfrom = "alz10041004";
		String tomail = request.getParameter("tomail"); // 받는 사람 이메일
		String title = request.getParameter("title"); // 제목
		String content = request.getParameter("content"); // 내용
		
//		String filename =  request.getParameter("submitFile");

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,
					true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content); // 메일 내용

//			FileSystemResource fsr = new FileSystemResource({{파일경로}});
//		    messageHelper.addAttachment(filename, fsr);
			
			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return "user/anonymous/Success";
//		return "redirect:/main";
	}
	
//	@Autowired
//	private UserMailSendService mailsender;
//
//    // 회원가입 컨트롤러
//	@RequestMapping(value = "/user/reg", method = RequestMethod.POST)
//	public String userRegPass(UserVO userVO, Model model, HttpServletRequest request) {
//
//		// 암호 확인
//		System.out.println("첫번째:" + userVO.getUser_pw());
//		// 비밀번호 암호화
//		String encryPassword = UserSha256.encrypt(userVO.getUser_pw());
//		userVO.setUser_pw(encryPassword);
//		System.out.println("두번째:" + userVO.getUser_pw());
//		// 회원가입 메서드
//		reg_service.userReg_service(userVO);
//		// 인증 메일 보내기 메서드
//		mailsender.mailSendWithUserKey(userVO.getUser_email(), userVO.getUser_id(), request);
//
//		return "redirect:/";
//	}
}
