package alz.admin.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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

import alz.admin.service.LessonServiceAdmin;
import alz.admin.service.MemberService;
import alz.admin.service.OrdersService;
import alz.board.domain.BoardCriteria;
import alz.board.domain.BoardDTO;
import alz.board.domain.LikeDTO;
import alz.board.exceptions.TemporaryServerException;
import alz.board.exceptions.UnsatisfiedContentException;
import alz.board.service.BoardService;
import alz.file.domain.BoardFileDTO;
import alz.order.domain.PaymentDTO;
import alz.order.service.PaymentService;

@RestController
@RequestMapping("/admins")
public class AdminApiController {

	private LessonServiceAdmin classService;
	private MemberService memberService;
	private OrdersService orderService;

	@Autowired
	public AdminApiController(LessonServiceAdmin classService, MemberService memberService, OrdersService orderService) {
		this.memberService = memberService;
		this.classService = classService;
		this.orderService = orderService;
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

	@PutMapping("/{id}")
	public ResponseEntity<?> updateOne() {
		return ResponseEntity.status(HttpStatus.OK).body("");
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<?> deleteOne() {
		return ResponseEntity.status(HttpStatus.OK).body("");
	}

}
