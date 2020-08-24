package alz.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import alz.admin.domain.BoardCriteriaAdmin;
import alz.admin.mapper.BoardMapperAdmin;
import alz.board.domain.BoardDTO;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImplAdmin implements BoardServiceAdmin {

	private BoardMapperAdmin boardMapper;
	
	@Autowired
	public BoardServiceImplAdmin(BoardMapperAdmin boardMapper) {
		this.boardMapper = boardMapper;
	}
	

	@Override
	public List<BoardDTO> readAll(BoardCriteriaAdmin cri) {
		List<BoardDTO> list = boardMapper.selectWithPaging(cri);
		return list;
	}


	@Override
	public int getTotal(BoardCriteriaAdmin cri) {
		int total = boardMapper.getTotalCount(cri);
		return total;
	}


	@Override
	public void deletebyId(List<Long> boardId) {
		for(int i=0; i<boardId.size();i++) {
		boardMapper.deleteById(boardId.get(i));}
		
	}


	@Override
	public List<BoardDTO> readDeletedAll(BoardCriteriaAdmin cri) {
		List<BoardDTO> list = boardMapper.printDeletedBoard(cri);
		return list;
	}
	
	
}
