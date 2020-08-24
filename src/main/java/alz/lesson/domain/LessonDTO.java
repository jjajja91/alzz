package alz.lesson.domain;

import java.sql.Date;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

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
public class LessonDTO {

	private Long originalId;
	private Long id;
	private Long teacherId;
	private Long categoryMain;
	private Long categorySub; 
	private String categoryName;
	private String categoryTotal;
	private String title;
	private Long lessonType;
	private String typeName;
	private Long lessonLevel;
	private String levelName;
	private Long minStudent;
	private Long maxStudent;
	private Long currentStudent;
	private Long state;
	private Date openAt;
	private Date closeAt;
	private String startAt;
	private String endAt;
	private String detail;
	private String thumbnail;
	
	private Long originPrice;
	private Long salePrice;
	private Double discountRate;
	
	private Long Rate;
	
	private String location;
	
}
