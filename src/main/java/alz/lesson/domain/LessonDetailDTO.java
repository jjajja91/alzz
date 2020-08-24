package alz.lesson.domain;

import java.util.List;

import alz.file.domain.LessonFileDTO;
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
public class LessonDetailDTO {
	
	private Long originalId;
	private Long id;
	private Long lessonId;
	private String Detail;
	
	private String location;
	
	private List<LessonFileDTO> fileList;

}
