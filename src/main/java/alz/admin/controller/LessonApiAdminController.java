package alz.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import alz.admin.domain.BoardCriteriaAdmin;
import alz.admin.domain.LessonStateDTO;
import alz.admin.service.BoardServiceAdmin;
import alz.admin.service.LessonServiceAdmin;
import alz.admin.service.MemberService;
import alz.admin.service.OrdersService;
import alz.board.domain.BoardDTO;

@RestController
@RequestMapping("/admin/lesson")
public class LessonApiAdminController {

	private LessonServiceAdmin lessonService;
	private MemberService memberService;
	private OrdersService orderService;
	private BoardServiceAdmin boardService;
	

	@Autowired
	public LessonApiAdminController(LessonServiceAdmin lessonService, MemberService memberService, OrdersService orderService, BoardServiceAdmin boardService) {
		this.memberService = memberService;
		this.lessonService = lessonService;
		this.orderService = orderService;
		this.boardService = boardService;
	}

	@PostMapping
	public ResponseEntity<?> create() {
		return ResponseEntity.status(HttpStatus.CREATED).body("");
	}

	@GetMapping("/{id}")
	public ResponseEntity<?> readOne() {
		return ResponseEntity.status(HttpStatus.OK).body("");
	}

	@GetMapping
	public ResponseEntity<?> readAll() {
		return ResponseEntity.status(HttpStatus.OK).body("");
	}
	
	@GetMapping(value ="/{pageNum}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> boardList(@PathVariable Integer pageNum){
		BoardCriteriaAdmin cri = new BoardCriteriaAdmin(pageNum, 10);
		System.out.println("여기옴?"+ cri);
		List<BoardDTO> list = boardService.readAll(cri);
		System.out.println("그럼 여기는"+ list);
		return ResponseEntity.status(HttpStatus.OK).body(list);
	}

	@PutMapping("/{id}")
	public ResponseEntity<?> updateOne() {
		return ResponseEntity.status(HttpStatus.OK).body("");
	}

	@PutMapping(produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> stateChange(@RequestBody LessonStateDTO LessonDTO) {
		lessonService.stateChangebyId(LessonDTO);
		return ResponseEntity.status(HttpStatus.OK).body("ok");
	}

}
