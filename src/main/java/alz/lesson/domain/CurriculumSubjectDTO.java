package alz.lesson.domain;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

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
public class CurriculumSubjectDTO {
	
	private Long subjectId;
	private Long lessonId;
	private Long curriculumOrder;
	private String subject;
	
	private List<CurriculumDetailDTO> detailList;


}