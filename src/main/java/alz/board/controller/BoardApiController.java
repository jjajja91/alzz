package alz.board.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import alz.board.domain.BoardCriteria;
import alz.board.domain.BoardDTO;
import alz.board.domain.LikeDTO;
import alz.board.exceptions.TemporaryServerException;
import alz.board.exceptions.UnsatisfiedContentException;
import alz.board.service.BoardService;
import alz.file.domain.BoardFileDTO;

@RestController
@RequestMapping("/boards")
public class BoardApiController {

	private BoardService boardService;

	@Autowired
	public BoardApiController(BoardService boardService) {
		this.boardService = boardService;
	}

	// 댓글 수
	@GetMapping(value = "/comments/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> countComments(@PathVariable Long id) {
		Long commentsCnt = boardService.getCommentsCnt(id);
		return ResponseEntity.status(HttpStatus.OK).body(commentsCnt);
	}

	// 파일 리스트 얻어오기
	@GetMapping(value = "/getFileList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<BoardFileDTO>> getFileList(Long boardId) {
		List<BoardFileDTO> boardFiles = boardService.getFileList(boardId);
		return ResponseEntity.status(HttpStatus.OK).body(boardFiles);
	}

	// 글 작성
	@PostMapping(produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> create(@RequestBody @Valid BoardDTO board, BindingResult result) {
		// 에러가 있으면
		if (result.hasErrors()) {
			// 에러 객체에 담아서
			FieldError error = result.getFieldError();
			// 예외를 던져줌
			if (result.getFieldError().getCode().indexOf("NotNull") != -1)
				throw new TemporaryServerException(error);
			else
				throw new UnsatisfiedContentException(error);
		} else {
			if (board.getTypeId() == 4) {
				// 후기작성
				
				boardService.createReview(board);
				boardService.createReviewRate(board);
				
			} else {
				boardService.create(board);
			}
		}
		return ResponseEntity.status(HttpStatus.CREATED).body(board);
	}

	// 하나 읽기
	@GetMapping("/{id}")
	public ResponseEntity<?> readOne(@PathVariable Long id) {
		BoardDTO searchedBoard = boardService.readById(id);
		return ResponseEntity.status(HttpStatus.OK).body(searchedBoard);
	}

	// 전체 리스트 가져오기
	@GetMapping
	public ResponseEntity<?> readAll() {
		List<BoardDTO> boards = boardService.readAll();
		return ResponseEntity.status(HttpStatus.OK).body(boards);
	}
//
//	// 페이징 글목록
//	@GetMapping(value = "/{typeId}/{pageNum}")
//	public ResponseEntity<?> getListByPage(@PathVariable Integer typeId, @PathVariable Integer pageNum) {
//		BoardCriteria cri = new BoardCriteria(pageNum, 10, typeId);
//		List<BoardDTO> boardList = boardService.readAll(cri);
//		return ResponseEntity.status(HttpStatus.OK).body(boardList);
//	}
//	
//	
//	// 검색 결과 글목록
//	@GetMapping(value = { "/{typeId}/{pageNum}/{amount}/{type}/{keyword}",
//			"/{typeId}/{pageNum}/{amount}/{type}" }, produces = { MediaType.APPLICATION_JSON_UTF8_VALUE })
//	public ResponseEntity<?> searchList(@PathVariable Integer typeId, @PathVariable String type,
//			@PathVariable(name = "keyword", required = false) String keyword, @PathVariable Integer pageNum,
//			@PathVariable Integer amount) {
//
//		BoardCriteria cri = new BoardCriteria();
//		cri.setKeyword(keyword).setType(type).setPageNum(pageNum).setAmount(amount).setTypeId(typeId);
//		List<BoardDTO> boards = boardService.readAll(cri);
//
//		return ResponseEntity.status(HttpStatus.OK).body(boards);
//	}
//
//	// 글 수 카운트
//	@GetMapping(value = {"/total/{typeId}/{type}", "/total/{typeId}/{type}/{keyword}"}, produces = {
//			MediaType.APPLICATION_JSON_UTF8_VALUE })
//	public int totalNumber(@PathVariable Integer typeId, @PathVariable String type, 
//			@PathVariable(required = false) String keyword) {
//		BoardCriteria cri = new BoardCriteria();
//System.out.println("keyword = " +keyword);
//System.out.println(keyword != null);
//		if (keyword != null) {
//			cri.setKeyword(keyword).setType(type).setTypeId(typeId);
//			System.out.println(cri);
//		}
//
//		int total = boardService.getTotal(cri);
//
//		return total;
//	}

	// 하나 수정
	@PutMapping(value = "/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> updateOne(@PathVariable Long id, @RequestBody @Valid BoardDTO board, BindingResult result) {
		if (result.hasErrors()) {
			FieldError error = result.getFieldError();
			if (result.getFieldError().getCode().indexOf("NotNull") != -1)
				throw new TemporaryServerException(error);
			else
				throw new UnsatisfiedContentException(error);
		} else {
			BoardDTO updatedBoard = boardService.updateById(id, board);
			return ResponseEntity.status(HttpStatus.OK).body(updatedBoard);
		}
	}

	// 하나 삭제
	@DeleteMapping("/{id}")
	public ResponseEntity<?> deleteOne(@PathVariable Long id) {
		int affectedRowCount = boardService.deleteById(id);
		return ResponseEntity.status(HttpStatus.OK).body("ok");
	}

	// 좋아요 관련

	// 좋아요 수
	@GetMapping(value = "/like/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> countLike(@PathVariable Long id) {
		Long likeCnt = boardService.getLikeCnt(id);
		return ResponseEntity.status(HttpStatus.OK).body(likeCnt);
	}

	// 좋아요 생성
	@PostMapping("/like")
	public ResponseEntity<?> addLike(@RequestBody LikeDTO like) {
		boardService.addLike(like);
		return ResponseEntity.status(HttpStatus.OK).body("좋아요");
	}

	// 좋아요 해제
	@DeleteMapping(value = "/like/{userId}/{boardId}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> removeLike(@PathVariable Long userId, @PathVariable Long boardId) {
		LikeDTO likeDTO = new LikeDTO();
		likeDTO.setUserId(userId).setBoardId(boardId);
		boolean isRemoved = boardService.removeLike(likeDTO);
		return ResponseEntity.status(HttpStatus.OK).body(isRemoved);
	}

	// 좋아요 여부 확인
	@GetMapping(value = "/like/{userId}/{boardId}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> isLike(@PathVariable Long userId, @PathVariable Long boardId) {
		LikeDTO likeDTO = new LikeDTO();
		likeDTO.setUserId(userId).setBoardId(boardId);
		boolean isLike = boardService.isLike(likeDTO);
		return ResponseEntity.status(HttpStatus.OK).body(isLike);
	}
	

}
