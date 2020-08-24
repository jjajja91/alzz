package alz.board.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
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
import alz.board.domain.CommentDTO;
import alz.board.exceptions.TemporaryServerException;
import alz.board.exceptions.UnsatisfiedContentException;
import alz.board.service.CommentService;
import alz.user.domain.UserDTO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/comments")
@Log4j
public class CommentApiController {
	
	private CommentService commentService;
	
	@Autowired
	public CommentApiController(CommentService commentService) {
		this.commentService = commentService;
	}
	
	
	// 로그인 유저 정보 획득
	public UserDTO getLoginUserInfo() {
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication auth = context.getAuthentication();
		UserDTO userInfo = (UserDTO)auth.getPrincipal();
		return userInfo;
	}
	
	// 댓글 쓰기
	@PostMapping(produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> create(@RequestBody @Valid CommentDTO comment, BindingResult result){
		if(result.hasErrors()) {
			FieldError error = result.getFieldError();
			if(result.getFieldError().getCode().indexOf("NotNull")!=-1)
				throw new TemporaryServerException(error);
			else throw new UnsatisfiedContentException(error);
		} else {
			commentService.create(comment);
		}
		
		return ResponseEntity.status(HttpStatus.CREATED).body(comment);
	}
	
	// 대댓글 쓰기
	@PostMapping(value = "/reComment", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> create2(@RequestBody @Valid CommentDTO comment, BindingResult result){
		if(result.hasErrors()) {
			FieldError error = result.getFieldError();
			if(result.getFieldError().getCode().indexOf("NotNull")!=-1)
				throw new TemporaryServerException(error);
			else throw new UnsatisfiedContentException(error);
		} else {
			commentService.create2(comment);
		}
		return ResponseEntity.status(HttpStatus.CREATED).body(comment);
	}
	
	// 하나 읽기
	@GetMapping()
	public ResponseEntity<?> readOne(@PathVariable("boardId") Long boardId){
		CommentDTO searchedComment = commentService.readById(boardId);
		return ResponseEntity.status(HttpStatus.OK).body(searchedComment);
	}
	
	// 해당 글 전체 댓글 목록
	@GetMapping(value = "/{boardId}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<?> readAll(@PathVariable("boardId") Long boardId) {
		List<CommentDTO> comments = commentService.readAll(boardId);
		return ResponseEntity.status(HttpStatus.OK).body(comments);
	}
	
	// 수정하기
	@PutMapping(value = "/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> updateOne(@PathVariable Long id, @RequestBody @Valid CommentDTO comment, BindingResult result){

		// 작성자와 로그인 유저가 다른 경우
		if(!commentService.readById(id).getUserId().equals(getLoginUserInfo().getId())) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(false); // 임시
		// 작성자와 로그인 유저가 같은 경우
		} else {
			CommentDTO updatedComment;

			if(result.hasErrors()) {
				FieldError error = result.getFieldError();
				if(result.getFieldError().getCode().indexOf("NotNull")!=-1)
					throw new TemporaryServerException(error);
				else throw new UnsatisfiedContentException(error);
			} else {
				updatedComment = commentService.updateById(id, comment);
			}
				return ResponseEntity.status(HttpStatus.OK).body(updatedComment);
		}
	}
	
	@DeleteMapping("/{id}")
	public ResponseEntity<?> deleteOne(@PathVariable Long id) {
		// 작성자와 로그인 유저가 다른 경우
		if(!commentService.readById(id).getUserId().equals(getLoginUserInfo().getId())) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("fail"); // 임시		
		// 작성자와 로그인 유저가 같은 경우
		} else {			
			int affectedRowCount = commentService.deleteById(id);
			return ResponseEntity.status(HttpStatus.OK).body("ok");
		}
	}

}
