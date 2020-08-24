package alz.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import alz.board.domain.CommentDTO;
import alz.board.mapper.CommentMapper;

@Service
public class CommentServiceImpl implements CommentService {
	
	//mapper 가져와서 사용
	private CommentMapper commentMapper;
	
	@Autowired
	public CommentServiceImpl(CommentMapper commentMapper) {
		this.commentMapper = commentMapper;
	}
	
	// 새댓글
	@Override
	public int create(CommentDTO comment) {
		int affectedRowCount = commentMapper.insert(comment);
		//CommentDTO createdComment = commentMapper.selectById(comment.getId()); 
		return affectedRowCount;
	}
	
	// 대댓글
	@Override
	public int create2(CommentDTO comment) {
		comment.setCommentCnt(comment.getCommentCnt()+1L);
		comment.setDepth(comment.getDepth()+1L);
		
		int updateRowCount = commentMapper.updateCnt(comment);
		
		if(updateRowCount!=1) return 0;
		
		int affectedRowCount = commentMapper.insert2(comment);
		//CommentDTO createdComment = commentMapper.selectById(comment.getId()); 
		return affectedRowCount;
	}

	@Override
	public CommentDTO readById(Long id) {
		CommentDTO comment = commentMapper.selectById(id);
		return comment;
	}

	@Override
	public List<CommentDTO> readAll(Long boardId) {
		List<CommentDTO> list = commentMapper.selectAll(boardId);
		return list;
	}

	@Override
	public CommentDTO updateById(Long id, CommentDTO comment) {
		
		int updatedRow = commentMapper.updateById(comment);
		
		CommentDTO searchedComment = commentMapper.selectById(id);
		return searchedComment;
	}

	@Override
	public int deleteById(Long id) {
		CommentDTO searchedComment = commentMapper.selectById(id);
		if(searchedComment==null) return 0;
		
		int affectedRowCount = commentMapper.deleteById(id);
		return affectedRowCount;
	}

}
