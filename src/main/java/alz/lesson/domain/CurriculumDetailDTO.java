package alz.lesson.domain;

import java.sql.Date;

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
public class CurriculumDetailDTO {

	private Long curriculumId;
	private Long lessonId;
	private Long detailOrder;
	private String detail;

}
