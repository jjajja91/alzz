package alz.file.mapper;

import java.util.List;

import alz.file.domain.BoardFileDTO;

public interface BoardFileMapper {
	
	public void insert(BoardFileDTO file);
	
	public void delete(String uuid);
	
	public List<BoardFileDTO> findByBoardId(Long boardId);
	
	public void deleteAll(Long boardId);
	
	public List<BoardFileDTO> getOldFiles();

}
