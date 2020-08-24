package alz.admin.mapper;

import java.util.List;

import alz.admin.domain.BoardCriteriaAdmin;
import alz.board.domain.BoardCriteria;
import alz.board.domain.BoardDTO;

public interface BoardMapperAdmin {

	List<BoardDTO> selectWithPaging(BoardCriteriaAdmin cri);
	
	// 페이징을 위한 count(검섹/페이징/게시판타입)
		int getTotalCount(BoardCriteriaAdmin cri);

		void deleteById(Long id);

		//삭제된 글 목록 불러오기
		List<BoardDTO> printDeletedBoard(BoardCriteriaAdmin cri);
}
