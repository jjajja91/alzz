package alz.file.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain=true)
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class LessonFileDTO {
	
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	private Long lessonId;

}
