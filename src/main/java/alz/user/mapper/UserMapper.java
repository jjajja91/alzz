package alz.user.mapper;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;

import alz.user.domain.UserDTO;
import alz.user.domain.UserStateDTO;

public interface UserMapper {

	// 유저 생성
	int insert(UserDTO user);

	// 유저 정보 가져오기
	UserDTO selectById(UserDTO user);
	
	// 닉네임으로 유저 정보 가져오기
	UserDTO selectByNickname(String nickname);

	// 이메일로 유저 정보 가져오기
	UserDTO selectByEmail(String email);

	// 핸드폰번호로 유저 정보 가져오기
	UserDTO selectByPhoneNumber(String phoneNumber);

	// 유저 정보 전부 가져오기(admin 사용)
	List<UserDTO> selectAll();

	// 유저 정보 수정
	int updateById(UserDTO user);

	// 이메일 중복체크하기
	int emailChk(String email);

	// 닉네임 중복체크하기
	int nicknameChk(String nickname);
	
	// 전화번호 중복체크하기
	int phoneNumberChk(String phoneNumber);
	
	// 유저 삭제(스케쥴러나 admin 사용할 듯)
	int deleteById(Long id);

	// 식별자로 유저 정보 가져오기
	UserDTO userInfo(Long id);

	// 유저선택(?)
	UserDTO selectedByUser(UserDTO user);

	// email로 식별자 알아내기
	String searchId(String email);
	
	// parameter를 통해서 식별자 찾아오기
	String find_id(@Param("nickname") String nickname, @Param("phoneNumber") String phoneNumber, HttpServletResponse response) throws Exception;

	public String find_password_email(UserDTO dto); // 비밀번호 찾기

	int modifyPwd(UserDTO user);
	
	// 탈퇴한(15일이 지나서 삭제할 유저 찾기)
	List<Long> findWithdrawUser(String date);

	int insertState(UserStateDTO userState);

	int findUserByEmailNickname(UserDTO user);

	int insertDetail(UserDTO user);

	int checkUser(String email);

	void changeTeacher(Long userId);

}
