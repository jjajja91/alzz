package alz.lesson.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import alz.file.domain.LessonFileDTO;
import alz.lesson.domain.CategoryDTO;
import alz.lesson.domain.CurriculumSubjectDTO;
import alz.lesson.domain.LessonDTO;
import alz.lesson.domain.LessonDetailDTO;
import alz.lesson.domain.LessonLikeDTO;
import alz.lesson.domain.LessonReservDTO;
import alz.lesson.domain.QuickReviewDTO;
import alz.lesson.domain.ScheduleDTO;
import alz.lesson.service.LessonServiceImpl;
import alz.user.domain.UserDTO;

@RestController
@RequestMapping("/lessons")
public class LessonApiController {

	private LessonServiceImpl lessonService;
	
	@Autowired
	public LessonApiController(LessonServiceImpl lessonService) {
		this.lessonService = lessonService;
	}
	
	public UserDTO getLoginUserInfo() {
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication auth = context.getAuthentication();
		UserDTO userInfo = (UserDTO)auth.getPrincipal();
		return userInfo;
	}
   
	@PostMapping
	public ResponseEntity<?> create(@RequestBody LessonDetailDTO detail){
		System.out.println(detail);
		lessonService.createLessonDetailFile(detail);
		return ResponseEntity.status(HttpStatus.CREATED).body(detail);
	}
	
	// 파일 리스트 얻어오기
	@GetMapping(value = "/getFileList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<LessonFileDTO>> getFileList(Long lessonId) {
		List<LessonFileDTO> lessonFiles = lessonService.getFileList(lessonId);
		return ResponseEntity.status(HttpStatus.OK).body(lessonFiles);
	}
	
	// 자동완성 클래스 선택
	@GetMapping("/{id}")
	public ResponseEntity<?> readOne(@PathVariable Long id){
		LessonDTO searchedLessons = lessonService.basicByLessonId(id);
		return ResponseEntity.status(HttpStatus.OK).body(searchedLessons);
	}
	
	// 메인 카테고리
	@GetMapping("/mainCategory")
	public ResponseEntity<?> getMainCategory(){
		List<CategoryDTO> list = lessonService.mainCategory();
		return ResponseEntity.status(HttpStatus.OK).body(list);
	}
	
	// 서브 카테고리
	@GetMapping("/subCategory")
	public ResponseEntity<?> getSubCategory(){
		List<CategoryDTO> list = lessonService.subCategory();
		return ResponseEntity.status(HttpStatus.OK).body(list);
	}
	
	// 난이도
	@GetMapping("/lessonLevel")
	public ResponseEntity<?> getLessonLevel(){
		List<CategoryDTO> list = lessonService.lessonLevel();
		return ResponseEntity.status(HttpStatus.OK).body(list);
	}
	
	@PostMapping("/schedule")
	public ResponseEntity<?> createSchedule(@RequestBody ScheduleDTO schedule){
		int affectedRowCount = lessonService.createSchedule(schedule);
		return ResponseEntity.status(HttpStatus.CREATED).body(affectedRowCount);
	}
	
	@PostMapping("/curriculum/{location}")
	public ResponseEntity<?> createCurriculum(@PathVariable String location, @RequestBody List<CurriculumSubjectDTO> curriculumList){
		int affectedRowCount = lessonService.createCurriculum(curriculumList);
		return ResponseEntity.status(HttpStatus.CREATED).body(location);
	}
	
	// 한줄평 목록
	@GetMapping("/quickReview/{lessonId}")
	public ResponseEntity<?> getLessonQuickReview(@PathVariable Long lessonId){
		List<QuickReviewDTO> list = lessonService.quickReviewByLessonId(lessonId);
		return ResponseEntity.status(HttpStatus.OK).body(list);
	}
	
	// 한줄평 등록
	@PostMapping("/quickReview")
	public ResponseEntity<?> createQuickReview(@RequestBody QuickReviewDTO quickReview){
		UserDTO user = getLoginUserInfo();
		quickReview.setUserId(user.getId());
		int affectedRowCount = lessonService.createQuickReview(quickReview);
		return ResponseEntity.status(HttpStatus.CREATED).body(affectedRowCount);
	}
	
	@PutMapping("/{id}")
	public ResponseEntity<?> updateOne(@PathVariable Long id, @RequestBody LessonDTO classes) {
//		LessonDTO updatedClass = lessonService.updateById(id, classes);
		return ResponseEntity.status(HttpStatus.OK).body("");
	}
	
	@DeleteMapping("/{id}")
	public ResponseEntity<?> deleteOne(@PathVariable Long id) {
//		int affectedRowCount = lessonService.deleteById(id);
		return ResponseEntity.status(HttpStatus.OK).body("ok");
	}
	
	// 좋아요 수
	@GetMapping(value = "/like/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> countLike(@PathVariable Long id) {
		Long likeCnt = lessonService.getLikeCnt(id);
		return ResponseEntity.status(HttpStatus.OK).body(likeCnt);
	}

	// 좋아요 생성
	@PostMapping("/like")
	public ResponseEntity<?> addLike(@RequestBody LessonLikeDTO like) {
		lessonService.addLike(like);
		return ResponseEntity.status(HttpStatus.OK).body("좋아요");
	}

	// 좋아요 해제
	@DeleteMapping(value = "/like/{userId}/{lessonId}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> removeLike(@PathVariable Long userId, @PathVariable Long lessonId) {
		LessonLikeDTO likeDTO = new LessonLikeDTO();
		likeDTO.setUserId(userId).setLessonId(lessonId);
		boolean isRemoved = lessonService.removeLike(likeDTO);
		return ResponseEntity.status(HttpStatus.OK).body(isRemoved);
	}

	// 좋아요 여부 확인
	@GetMapping(value = "/like/{userId}/{lessonId}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> isLike(@PathVariable Long userId, @PathVariable Long lessonId) {
		LessonLikeDTO likeDTO = new LessonLikeDTO();
		likeDTO.setUserId(userId).setLessonId(lessonId);
		boolean isLike = lessonService.isLike(likeDTO);
		return ResponseEntity.status(HttpStatus.OK).body(isLike);
	}
	
	// --------------------------- 찜 ---------------------------------
	
	// 찜 수
	@GetMapping(value = "/reserv/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> countReserv(@PathVariable Long id) {
		Long reservCnt = lessonService.getReservCnt(id);
		return ResponseEntity.status(HttpStatus.OK).body(reservCnt);
	}

	// 찜 생성
	@PostMapping("/reserv")
	public ResponseEntity<?> addReserv(@RequestBody LessonReservDTO reserv) {
		lessonService.addReserv(reserv);
		return ResponseEntity.status(HttpStatus.OK).body("좋아요");
	}

	// 찜 해제
	@DeleteMapping(value = "/reserv/{userId}/{lessonId}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> removeReserv(@PathVariable Long userId, @PathVariable Long lessonId) {
		LessonReservDTO reservDTO = new LessonReservDTO();
		reservDTO.setUserId(userId).setLessonId(lessonId);
		boolean isRemoved = lessonService.removeReserv(reservDTO);
		return ResponseEntity.status(HttpStatus.OK).body(isRemoved);
	}

	// 찜 여부 확인
	@GetMapping(value = "/reserv/{userId}/{lessonId}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> isReserv(@PathVariable Long userId, @PathVariable Long lessonId) {
		LessonReservDTO reservDTO = new LessonReservDTO();
		reservDTO.setUserId(userId).setLessonId(lessonId);
		boolean isLike = lessonService.isReserv(reservDTO);
		return ResponseEntity.status(HttpStatus.OK).body(isLike);
	}
	
}
