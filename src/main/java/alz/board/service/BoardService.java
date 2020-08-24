package alz.board.service;

import java.util.List;

import javax.validation.Valid;

import alz.board.domain.BoardCriteria;
import alz.board.domain.BoardDTO;
import alz.board.domain.LikeDTO;
import alz.board.domain.ReviewDTO;
import alz.board.domain.ReviewOptDTO;
import alz.file.domain.BoardFileDTO;

public interface BoardService {
	
	// 게시글 작성
	void create(BoardDTO board);

	// 게시글 읽기
	BoardDTO readById(Long id);

	// 게시글 리스트 얻기
	List<BoardDTO> readAll();
	// 페이징된 게시글 리스트 얻기
	List<BoardDTO> readAll(BoardCriteria cri);

	// 게시글 수정
	BoardDTO updateById(Long id, BoardDTO board);
	boolean update(Long id, BoardDTO board);

	// 게시글 삭제
	int deleteById(Long id);

	// 페이징 된 리스트의 게시글 수
	int getTotal(BoardCriteria cri);
	
	// 파일 리스트 얻기
	public List<BoardFileDTO> getFileList(Long boardId);

	// 댓글 수(트리거가 올려줌)
	Long getCommentsCnt(Long id);

	// 좋아요 수(트리거가 올려줌)
	Long getLikeCnt(Long id);

	// 좋아요 추가
	void addLike(LikeDTO like);

	// 좋아요 여부 확인
	boolean isLike(LikeDTO likeDTO);

	// 좋아요 삭제
	boolean removeLike(LikeDTO likeDTO);

	List<ReviewOptDTO> reviewOption(Long id);

	void createReview(BoardDTO board);

	void createReviewRate(BoardDTO board);

	BoardDTO readReview(BoardDTO board);

	String getBoardName(Integer typeId);

}
