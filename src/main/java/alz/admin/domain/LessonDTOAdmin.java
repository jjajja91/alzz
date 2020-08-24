package alz.admin.domain;

import java.sql.Date;

import javax.validation.constraints.NotEmpty;

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
public class LessonDTOAdmin {

	private Long id;
	private Long teacherId;
	private Long categoryMain;
	private Long categorySub; 
	private String categoryName;
	private String title;
	private Long lessonType;
	private String typeName;
	private Long lessonLevel;
	private String levelName;
	private Long minStudent;
	private Long maxStudent;
	private Long currentStudent;
	private Long stateNum;
	private String state;
	private Date openAt;
	private Date closeAt;
	private String startAt;
	private String endAt;
	private String detail;
	private String thumbnail;
	
	private String location;
	
}
