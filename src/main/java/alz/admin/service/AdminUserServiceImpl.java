package alz.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import alz.admin.mapper.AdminUserMapper;
import alz.user.domain.UserDTO;
import alz.user.domain.UserStateDTO;
import alz.user.mapper.UserMapper;

@Service
public class AdminUserServiceImpl implements AdminUserService, UserDetailsService {

	// mapper 가져와서 사용
	private AdminUserMapper adminUserMapper;
//	private UserMapper userMapper;

	private PasswordEncoder passwordEncoder;

	@Autowired
	public AdminUserServiceImpl(AdminUserMapper adminUserMapper, PasswordEncoder passwordEncoder) {
		this.adminUserMapper = adminUserMapper;
		this.passwordEncoder = passwordEncoder;
	}

	@Override
	public boolean emailChk(String email) {
		return adminUserMapper.emailChk(email) == 1;
	}

	@Override
	public boolean nicknameChk(String nickname) {
		return adminUserMapper.nicknameChk(nickname) == 1;
	}

	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		UserDTO user = adminUserMapper.selectByEmail(email);
		if (user == null) {
			throw new UsernameNotFoundException(email);
		}
		System.out.println("loadUserbyUsername");
		System.out.println(user);
		return user;
	}

	// 01. 전체 회원 목록 조회
	@Override
	public List<UserDTO> userList() {
		return adminUserMapper.userList();
	}

//	// 02. 회원 등록
//	@Override
//	public void insertManager(UserDTO dto) {
//		dto.encodePassword(passwordEncoder);
//		adminUserMapper.insertManager(dto);
//	}
//
//	// 02. 회원 등록
//	@Override
//	public void insertUser(UserDTO dto) {
//		dto.encodePassword(passwordEncoder);
//		adminUserMapper.insertUser(dto);
//	}

	// 03. 회원 정보 상세 조회
	@Override
	public UserDTO viewUser(String email) {
		return adminUserMapper.viewUser(email);
	}

//	// 04. 회원 정보 삭제 처리
//	@Override
//	public void deleteUser(UserDTO dto) {
//		adminUserMapper.deleteUser(dto);
//	}

	// 05. 회원 정보 수정 처리
	@Override
	public void updateUser(UserDTO dto) {
		dto.encodePassword(passwordEncoder);
		adminUserMapper.updateUser(dto);
	}

	// 06. 회원 정보 수정 및 삭제를 위한 비밀번호 체크
	@Override
	public boolean checkPw(UserDTO dto) {
		UserDTO user = adminUserMapper.selectByEmail(dto.getEmail());
		boolean result = false;
//		System.out.println(count);
		if (passwordEncoder.matches(dto.getPassword(), user.getPassword()))
			result = true;
//		Map<String, String> map = new HashMap<String, String>();
//		System.out.println(dto.getEmail());
//		map.put("email", dto.getEmail());
//		map.put("password", dto.getPassword());
//		int count = adminUserMapper.checkPw("member.checkPw", map);
//		if (count == 1)
//			result = true;
		return result;
	}

	// 회원 정보 검색 메소드
	@Override
	public List<UserDTO> find_member_info(String email) throws Exception {

		return adminUserMapper.member_info(email);
	}

	// 회원 강제탈퇴 관련 메소드
	@Transactional //전부 실행 되야만 실행되는 어노테이션
	@Override
	public void dropOut(UserDTO dto) throws Exception {
		
		UserDTO user = adminUserMapper.selectByEmail(dto.getEmail());
//		System.out.println(dto);
		adminUserMapper.dropOutStateChange(user);
		adminUserMapper.dropOut(dto);
	}

	// 회원 강제정지 관련 메소드
	@Transactional //전부 실행 되야만 실행되는 어노테이션
	@Override
	public void suspended(UserDTO dto) throws Exception {
		UserDTO user = adminUserMapper.selectByEmail(dto.getEmail());
//		System.out.println(dto);
		adminUserMapper.suspendedStateChange(user);
		adminUserMapper.suspended(dto);
	}

	// 회원 휴면전환 관련 메소드
	@Transactional //전부 실행 되야만 실행되는 어노테이션
	@Override
	public void inactive(UserDTO dto) throws Exception {
		UserDTO user = adminUserMapper.selectByEmail(dto.getEmail());
//		System.out.println(dto);
		adminUserMapper.inactiveStateChange(user);
		adminUserMapper.inactive(dto);
	}

	// 회원 일반회원으로 전환 관련 메소드
	@Transactional //전부 실행 되야만 실행되는 어노테이션
	@Override
	public void backNormal(UserDTO dto) throws Exception {
		UserDTO user = adminUserMapper.selectByEmail(dto.getEmail());
//		System.out.println(dto);
		adminUserMapper.backNormalStateChange(user);
		adminUserMapper.backNormal(dto);
	}
	
	// 해당 계정을 일반계정으로 전환하는데 관련된 메소드
	@Override
	public void asUser(UserDTO dto) throws Exception {
		adminUserMapper.asUser(dto);
	}
	
	// 해당 계정을 관리자계정으로 전환하는데 관련된 메소드
	@Override
	public void asManager(UserDTO dto) throws Exception {
		adminUserMapper.asManager(dto);
	}
	
//	@Async
//	@Override
//	public void asyncService() {
//		System.out.println("Async service is called");
//	}
}
