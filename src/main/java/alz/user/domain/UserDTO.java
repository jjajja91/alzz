package alz.user.domain;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

@SuppressWarnings("serial")
@Getter
@Setter
@ToString
@Builder
@Accessors(chain = true)
@NoArgsConstructor
@AllArgsConstructor
public class UserDTO implements UserDetails {

	private Long id;
	private String email;
	private String nickname;
	private String password;
	// 유저 역할(권한) => ROLE_USER/ROLE_TEACHER(실명인증후 강의 등록시 사용)/ROLE_ADMIN
	private String role;
	// 실명인증 여부(TEACHER 가능)
	private Integer certificationState;
	// 사용 가능 여부 (탈퇴, 정지, 휴면 같은 경우 로그인을 방지하는 역할)
	private boolean enable;
	private String phoneNumber;
	
	// 상세 테이블(PFK)
	// 최근 접속일(이용해서 task로 얼마 이상 접속 안할 경우 휴면 변경 => 스케쥴러로 할지 관리자단에서 처리할지 고민)
	private Date recentlogAt;
	private Date modifiedAt;
	private Long boardCnt;
	private Long commentCnt;
	
	// 상태 테이블(PFK -> FK 변경 예정)
	// 휴면, 정지, 탈퇴 등 상태
	private String state;
	private Date startAt;
	private Date endAt;	
	private String description;
	

	// 패스워드 인코딩
	public void encodePassword(PasswordEncoder passwordEncoder) {
		this.password = passwordEncoder.encode(this.password);
	}

	// 역할(계층을 주었기 때문에 리스트로 줄 필요는 없지만 인터페이스 구현을 위해 적용
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		ArrayList<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
		auth.add(new SimpleGrantedAuthority(this.role));
		return auth;
	}

	// 유저네임이지만 로그인에 사용하는 아이디이므로 이메일
	@Override
	public String getUsername() {
		return this.email;
	}
	
	public void setUsername(String email) {
		this.email = email;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	// 사용 가능 여부 
	@Override
	public boolean isEnabled() {
		return this.enable;
	}

}
