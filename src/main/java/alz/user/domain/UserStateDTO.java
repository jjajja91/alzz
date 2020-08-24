package alz.user.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

@Getter
@Setter
@ToString
@Builder
@Accessors(chain = true)
@NoArgsConstructor
@AllArgsConstructor
public class UserStateDTO {

	private Long id;
	private Long userId;
	// 상태 테이블(PFK -> FK 변경 예정)
	// 휴면, 정지, 탈퇴 등 상태
	private String state;
	private Date startAt;
	private Date endAt;
	private String description;
	
}