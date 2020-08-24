package alz.lesson.service;

import java.util.List;

import alz.file.domain.LessonFileDTO;
import alz.lesson.domain.CategoryDTO;
import alz.lesson.domain.CurriculumSubjectDTO;
import alz.lesson.domain.LessonCriteria;
import alz.lesson.domain.LessonDTO;
import alz.lesson.domain.LessonDetailDTO;
import alz.lesson.domain.LessonLikeDTO;
import alz.lesson.domain.LessonReservDTO;
import alz.lesson.domain.QuickReviewDTO;
import alz.lesson.domain.ScheduleDTO;
import alz.lesson.domain.TeacherDTO;
import alz.lesson.domain.TimeTableDTO;

public interface LessonService {

	TeacherDTO createTeacher(TeacherDTO teacher);
	int createLesson(LessonDTO lesson);
	int createSchedule(ScheduleDTO schedule);
	int createLessonDetail(LessonDetailDTO detail);
	void createLessonDetailFile(LessonDetailDTO detail);
	int createCurriculum(List<CurriculumSubjectDTO> curriculumList);
	int createQuickReview(QuickReviewDTO quickReview);

	TeacherDTO teacherByUserId(Long userId);
	List<LessonDTO> lessonsByTeacherId(LessonDTO lesson);
	LessonDTO lessonByTeacherId(LessonDTO lesson);
	
	LessonDTO readByLessonId(Long id); 
	
	LessonDTO basicByLessonId(Long id); // 기본정보만
	List<CurriculumSubjectDTO> curriculumByLessonId(Long lessonId); // 새로만든 클래스
	List<TimeTableDTO> timeTableByLessonId(Long lessonId); // 스케줄 불러오기(상세 페이지에서 사용)
	TeacherDTO teacherByLessonId(Long id);
	List<QuickReviewDTO> quickReviewByLessonId(Long id);
	
	LessonDetailDTO detailByLessonId(Long lessonId); // 세부설명
	ScheduleDTO scheduleByLessonId(Long lessonId); // 스케줄 불러오기(등록페이지에서 사용)
	
	// 파일 리스트 얻기
	public List<LessonFileDTO> getFileList(Long lessonId);
	
	List<CategoryDTO> mainCategory();
	List<CategoryDTO> subCategory();
	List<CategoryDTO> lessonLevel();
	
	List<LessonDTO> readAll();
	List<LessonDTO> readAll(LessonCriteria cri);
	
	// 페이징 된 리스트의 게시글 수
	int getTotal(LessonCriteria cri);

	TeacherDTO updateTeacher(TeacherDTO teacher);
	int updateLessonDetail(LessonDetailDTO detail);
	int lessonSubmit(Long lessonId, Long userId); // 상태변경 제출
	
	// 좋아요 수(트리거가 올려줌)
	Long getLikeCnt(Long id);
	// 좋아요 추가
	void addLike(LessonLikeDTO like);
	// 좋아요 여부 확인
	boolean isLike(LessonLikeDTO likeDTO);
	// 좋아요 삭제
	boolean removeLike(LessonLikeDTO likeDTO);
	List<LessonDTO> getNewList();
	List<LessonDTO> getSoonList();
	
	
	// 찜 수(트리거가 올려줌)
	Long getReservCnt(Long id);
	// 찜 추가
	void addReserv(LessonReservDTO reserv);
	// 찜 여부 확인
	boolean isReserv(LessonReservDTO reservDTO);
	// 찜 삭제
	boolean removeReserv(LessonReservDTO reservDTO);

	
}