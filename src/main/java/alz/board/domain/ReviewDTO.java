package alz.board.domain;


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
@Accessors(chain=true)
@NoArgsConstructor
@AllArgsConstructor
public class ReviewDTO {

	private Long lessonReview;
	private Long teacherReview;
	private Long lessonId;
	private Long boardId;
	private Long reviewerId;
	
	
}
