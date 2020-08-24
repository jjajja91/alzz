package alz.user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;

import alz.user.domain.UserDTO;

public interface UserService {

	// 유저 생성(가입)
	UserDTO create(UserDTO user);

	// 식별자로 유저 찾기
	UserDTO readById(UserDTO user);
	
	// 이메일로 유저 찾기
	UserDTO readByEmail(String email);

	// 닉네임으로 유저 찾기
	UserDTO readByNickname(String nickname);

	// 폰번호로 유저 찾기
	UserDTO readByPhoneNumber(String phoneNumber);

	// 유저 전체 목록
	List<UserDTO> readAll();

	// 유저 수정
	UserDTO updateById(UserDTO user);

	// 이메일 중복 체크
	boolean emailChk(String email);
	
	// 닉네임 중복 체크
	boolean nicknameChk(String nickname);
	
	// 핸드폰 중복 체크
	int phoneNumberChk(String phoneNumber);
	
	// id로 유저 정보 가져오기
	UserDTO userInfo(long id);
	
	// 이메일로 식별자 찾기
	String searchId(String email);
	
	// 아이디 찾기
	String find_id(@Param("nickname") String nickname, @Param("phoneNumber") String phoneNumber, HttpServletResponse response) throws Exception;
	
	public String find_password_email(UserDTO dto); // 비밀번호 찾기 관련
	
	// 이메일로 중복 체크
	boolean duplicateCheck(String email);
	
	// 카카오 토큰 가져오기
	String getKakaoAccessToken (String authorizeCode);

	// 카카오 유저 정보 가져오기
	HashMap<String, Object> getKakaoUserInfo (String accessToken);
	
	// 네이버 토큰 가져오기
	String getNaverAccessToken(String code, String state);

	// 네이버 유저 정보 가져오기
	HashMap<String, Object> getNaverUserInfo(String accessToken);

	// 구글 토큰 가져오기
	String getGoogleAccessToken(String code);

	// 구글 유저 정보 가져오기
	HashMap<String, Object> getGoogleUserInfo(String accessToken);

	boolean modifyPwd(UserDTO user);

	boolean findUserByEmailNickname(UserDTO user);

//	void asyncService();

}