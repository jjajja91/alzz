package alz.board.service;

import java.util.List;

import alz.board.domain.CommentDTO;

public interface CommentService {

	// 댓글 작성
	int create(CommentDTO comment);
	
	// 대댓글 작성
	int create2(CommentDTO comment);

	// 댓글 읽기
	CommentDTO readById(Long id);

	// 게시글에 대한 댓글 목록
	List<CommentDTO> readAll(Long boardId);

	// 댓글 수정
	CommentDTO updateById(Long id, CommentDTO comment);

	// 댓글 삭제
	int deleteById(Long id);

}
