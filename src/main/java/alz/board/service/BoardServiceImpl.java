package alz.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import alz.board.domain.BoardCriteria;
import alz.board.domain.BoardDTO;
import alz.board.domain.LikeDTO;
import alz.board.domain.ReviewDTO;
import alz.board.domain.ReviewOptDTO;
import alz.board.mapper.BoardMapper;
import alz.board.mapper.LikeMapper;
import alz.file.domain.BoardFileDTO;
import alz.file.mapper.BoardFileMapper;
import alz.lesson.domain.LessonDTO;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {

	private BoardMapper boardMapper;
	private BoardFileMapper boardFileMapper;
	private LikeMapper likeMapper;

	@Autowired
	public BoardServiceImpl(BoardMapper boardMapper, BoardFileMapper boardFileMapper, LikeMapper likeMapper) {
		this.boardMapper = boardMapper;
		this.boardFileMapper = boardFileMapper;
		this.likeMapper = likeMapper;
	}

	@Transactional
	@Override
	public void create(BoardDTO board) {
		if (board.getParentId() == null) {
			boardMapper.insert(board);
		} else if (board.getParentId() == 0) {
			boardMapper.replyInsert(board);
			boardMapper.insertReply(board);

		} else {
			board.setParentId(board.getId());
			boardMapper.rereplyInsert(board);
			boardMapper.insertReply(board);
			boardMapper.insertReply(board);

		}
		if (board.getFileList() == null || board.getFileList().size() <= 0) {
			return;
		}

		board.getFileList().forEach(file -> {
			file.setBoardId(board.getId());
			boardFileMapper.insert(file);
		});

	}

	@Override
	public BoardDTO readById(Long id) {
		BoardDTO searchBoardWriter = boardMapper.selectById(id);
		return searchBoardWriter;
	}

	@Override
	public List<BoardDTO> readAll() {
		List<BoardDTO> boards = boardMapper.selectAll();

		return boards;
	}

	@Override
	public List<BoardDTO> readAll(BoardCriteria cri) {
		List<BoardDTO> list = boardMapper.selectWithPaging(cri);

		return list;
	}

	@Override
	public BoardDTO updateById(Long id, BoardDTO board) {
		BoardDTO searchedBoard = boardMapper.selectById(id);
		if(board.getTypeId()==4) {
		boardMapper.updateReview(board);
		ReviewDTO review = boardMapper.readReview(board);
		searchedBoard.setLessonId(review.getLessonId()).setLessonReview(review.getLessonReview()).setTeacherReview(review.getTeacherReview());
		}
		searchedBoard.setTitle(board.getTitle()).setContent(board.getContent());
		int affectedRowCount = boardMapper.updateById(searchedBoard);
		return searchedBoard;

	}

	@Override
	public boolean update(Long id, BoardDTO board) {
		log.info("modify....." + board);
		boardFileMapper.deleteAll(id);

		BoardDTO searchedBoard = boardMapper.selectById(id);
		searchedBoard.setTitle(board.getTitle()).setContent(board.getContent()).setFileList(board.getFileList());
		boolean modifyResult = boardMapper.updateById(searchedBoard) == 1;

		if (modifyResult && board.getFileList() != null && board.getFileList().size() > 0) {
			board.getFileList().forEach(file -> {
				file.setBoardId(id);
				boardFileMapper.insert(file);
			});
		}

		return modifyResult;
	}

	@Transactional
	@Override
	public int deleteById(Long id) {
		boardFileMapper.deleteAll(id);
		int affectedRowCount = boardMapper.deleteById(id);

		return affectedRowCount;
	}

	@Override
	public int getTotal(BoardCriteria cri) {
		int total = boardMapper.getTotalCount(cri);
		return total;
	}

	@Override
	public List<BoardFileDTO> getFileList(Long boardId) {
		log.info("get File list by board_id" + boardId);
		return boardFileMapper.findByBoardId(boardId);
	}

	@Override
	public Long getCommentsCnt(Long id) {
		return boardMapper.getCommentsCnt(id);
	}

	@Override
	public Long getLikeCnt(Long id) {
		return boardMapper.getLikeCnt(id);
	}

	@Override
	public void addLike(LikeDTO like) {
		BoardDTO board = new BoardDTO();
		likeMapper.addLike(like);
	}

	@Override
	public boolean isLike(LikeDTO likeDTO) {
		return likeMapper.getLike(likeDTO) == null ? false : true;
	}

	@Override
	public boolean removeLike(LikeDTO likeDTO) {
		return likeMapper.removeLike(likeDTO) == 0 ? false : true;
	}

	@Override
	public List<ReviewOptDTO> reviewOption(Long id) {
		List<ReviewOptDTO> list = boardMapper.reviewOption(id);
		return list;
	}

	@Override
	public void createReview(BoardDTO board) {

		boardMapper.createReview(board);
		System.out.println(board.getId());

	}

	@Transactional
	@Override
	public void createReviewRate(BoardDTO board) {
		boardMapper.createReviewRate(board);
		Long merchandiseId = boardMapper.lessonChk(board);
		board.setMerchandiseId(merchandiseId);
		boardMapper.reviewChk(board);
	}

	@Override
	public BoardDTO readReview(BoardDTO board) {
		ReviewDTO review = boardMapper.readReview(board);
		LessonDTO lesson=boardMapper.getTitle(review.getLessonId());
		board.setLessonId(review.getLessonId()).setTeacherReview(review.getTeacherReview())
		.setLessonReview(review.getLessonReview()).setLessonTitle(lesson.getTitle());
		
		return board;
	}

	@Override
	public String getBoardName(Integer id) {
		return boardMapper.getBoardName(id);
	}

}
