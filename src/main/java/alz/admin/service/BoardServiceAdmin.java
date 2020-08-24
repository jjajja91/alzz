package alz.admin.service;

import java.util.List;

import alz.admin.domain.BoardCriteriaAdmin;
import alz.board.domain.BoardDTO;

public interface BoardServiceAdmin {

	// 페이징된 게시글 리스트 얻기
	List<BoardDTO> readAll(BoardCriteriaAdmin cri);

	int getTotal(BoardCriteriaAdmin cri);

	void deletebyId(List<Long> boardId);

	List<BoardDTO> readDeletedAll(BoardCriteriaAdmin cri);
}
