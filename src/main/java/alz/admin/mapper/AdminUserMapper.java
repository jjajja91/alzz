package alz.admin.mapper;

import java.util.List;

import alz.user.domain.UserDTO;

public interface AdminUserMapper {

	// 이메일로 유저 정보 가져오기
	UserDTO selectByEmail(String email);

	// 이메일 중복체크하기
	int emailChk(String email);

	// 닉네임 중복체크하기
	int nicknameChk(String nickname);

	// 회원 목록
	public List<UserDTO> userList();

//	// 회원 입력(관리자)
//	public void insertManager(UserDTO dto);
//
//	// 회원 입력(일반회원)
//	public void insertUser(UserDTO dto);

	// 회원 정보 상세보기
	public UserDTO viewUser(String email);

//	// 회원삭제
//	public void deleteUser(UserDTO dto);

	// 회원정보 수정
	public void updateUser(UserDTO dto);

	// 비밀번호 체크
	public int checkPw(UserDTO dto);

	// 회원정보를 찾는 메소드
	List<UserDTO> member_info(String email) throws Exception;

	// 강제탈퇴 시킬때 해당 회원이 있는지 체크하는 메소드
	void dropOut(UserDTO dto) throws Exception;
	// 상태를 탈퇴로 바꿔주는 메소드
	void dropOutStateChange(UserDTO user);

	// 강제정지 시킬때 해당 회원이 있는지 체크하는 메소드
	void suspended(UserDTO dto) throws Exception;
	// 상태를 가입으로 바꿔주는 메소드
	void suspendedStateChange(UserDTO user);

	// 휴면전환 시킬때 해당 회원이 있는지 체크하는 메소드
	void inactive(UserDTO dto) throws Exception;
	// 상태를 휴면으로 바꿔주는 메소드
	void inactiveStateChange(UserDTO user);
	
	// 일반회원으로 전환 시킬때 해당 회원이 있는지 체크하는 메소드
	void backNormal(UserDTO dto) throws Exception;
	// 상태를 가입으로 바꿔주는 메소드
	void backNormalStateChange(UserDTO user);

	// 일반 계정으로 바꿀 때 해당 회원이 있는지 체크하는 메소드
	void asUser(UserDTO dto) throws Exception;
	
	// 관리자 계정으로 바꿀 때 해당 회원이 있는지 체크하는 메소드
	void asManager(UserDTO dto) throws Exception;


	
}
