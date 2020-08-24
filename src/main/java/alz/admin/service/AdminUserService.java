package alz.admin.service;

import java.util.List;

import alz.user.domain.UserDTO;

public interface AdminUserService {

	// 이메일 중복 체크
	boolean emailChk(String email);

	// 닉네임 중복 체크
	boolean nicknameChk(String nickname);

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
	public boolean checkPw(UserDTO dto);

	// 회원정보를 찾는 메소드
	List<UserDTO> find_member_info(String email) throws Exception;

	// 강제탈퇴 시킬때 해당 회원이 있는지 체크하는 메소드
	void dropOut(UserDTO dto) throws Exception;

	// 강제정지 시킬때 해당 회원이 있는지 체크하는 메소드
	void suspended(UserDTO dto) throws Exception;

	// 휴면전환 시킬때 해당 회원이 있는지 체크하는 메소드
	void inactive(UserDTO dto) throws Exception;
	
	// 일반회원으로 전환 시킬때 해당 회원이 있는지 체크하는 메소드
	void backNormal(UserDTO dto) throws Exception;
	
	// 일반 계정으로 바꿀 때 해당 회원이 있는지 체크하는 메소드
	void asUser(UserDTO dto) throws Exception;
	
	// 관리자 계정으로 바꿀 때 해당 회원이 있는지 체크하는 메소드
	void asManager(UserDTO dto) throws Exception;
	
//	void asyncService();

}