package alz.board.domain;

import java.util.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.Accessors;


@Getter
@Setter
@Builder
@Accessors(chain=true)
@NoArgsConstructor
@AllArgsConstructor
public class CommentDTO {
	
	private Long id;
	@NotBlank(message = "댓글 내용을 입력해주세요")
	@Size(min=0, max=300, message="댓글 내용이 초과했습니다. 댓글내용을 줄여주세요.")
	private String content;
	private Date writtenAt;
	private Date updatedAt;
	private Long likeCnt;
	private Long commentCnt;
	private String commentCode;
	private Long boardId;
	private String nickname;
	private Long depth;
	private String deleted;
	private Long userId;

}
