package alz.board.domain;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import alz.file.domain.BoardFileDTO;
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
public class BoardDTO {
	
	
	// valid 애너테이션으로 처리
	private Long id;
	@NotBlank(message = "글 제목을 입력해주세요")
	@Size(min=1, max=100, message="제목은 100자 이내로 입력해주세요")
	private String title;
	@NotBlank(message = "글 내용을 입력해주세요")
	@Size(max=1000, message="글자 수를 초과했습니다. 1000자 이내로 입력해주세요")
	private String content;
	private Date writtenAt;
	private Date updatedAt;
	//대부모 id
	private Long boardOrder;
	private Long likeCnt;
	private Long commentCnt;
	private Long viewCnt;
	@NotNull(message = "서버 오류입니다")
	private String nickname;
	//내가 답글단 글의 id
	private Long parentId;
	@NotNull(message = "서버 오류입니다")
	private Integer typeId;
	private Long writerId;
	
	private Long lessonReview;
	private Long teacherReview;
	private Long lessonId;
	private String lessonTitle;
	private Long merchandiseId;
	
	private List<BoardFileDTO> fileList;

		
	


}
