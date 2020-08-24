package alz.board.mapper;

import java.util.List;

import alz.board.domain.CommentDTO;

public interface CommentMapper {
	
	// 댓글 작성
	int insert(CommentDTO comment);
	
	// 대댓글 작성
	int insert2(CommentDTO comment);
	
	// 식별자로 댓글 가져오기
	CommentDTO selectById(Long id);
	
	// ???
	List<CommentDTO> selectAll(Long id);
	
	// 댓글 수정
	int updateById(CommentDTO comment);
	
	// 대댓글 입력시 comment_cnt 올려주는 메서드(노필요/트리거 사용할거임)
	int updateCnt(CommentDTO comment);
	
	// 댓글 삭제
	int deleteById(Long id);

}
