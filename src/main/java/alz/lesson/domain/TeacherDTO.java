package alz.lesson.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

@Getter
@Setter
@Builder
@Accessors(chain=true)
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class TeacherDTO {

	private Long originalId;
	private Long id;
	private Long userId;
	private Long state;
	private String nickname;
	private String profile;
	private String snsType;
	private String snsId;
	private String snsUrl;
	
}
