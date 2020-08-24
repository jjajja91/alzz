package alz.lesson.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import alz.lesson.domain.CategoryDTO;
import alz.lesson.domain.CurriculumDetailDTO;
import alz.lesson.domain.CurriculumSubjectDTO;
import alz.lesson.domain.LessonCriteria;
import alz.lesson.domain.LessonDTO;
import alz.lesson.domain.LessonDetailDTO;
import alz.lesson.domain.LessonLikeDTO;
import alz.lesson.domain.LessonReservDTO;
import alz.lesson.domain.LessonScheduleDTO;
import alz.lesson.domain.QuickReviewDTO;
import alz.lesson.domain.ReviewDTO;
import alz.lesson.domain.ScheduleDTO;
import alz.lesson.domain.TeacherDTO;
import alz.lesson.domain.TimeTableDTO;

public interface LessonMapper {

	int insertTeacher(TeacherDTO teacher);
	int insertLesson(LessonDTO lesson);
	int insertSchedule(TimeTableDTO timeTable);
	int insertLessonDetail(LessonDetailDTO detail);
	int insertCurriculumSubject(CurriculumSubjectDTO curriculumSubject);
	int insertCurriculumDetail(CurriculumDetailDTO curriculumDetail);
	int insertQuickReview(QuickReviewDTO quickReview);
	
	TeacherDTO findTeacherByUserId(Long userId);
	
	List<LessonDTO> lessonsByTeacherId(LessonDTO lesson); // 유저별 개설 클래스
	LessonDTO lessonByTeacherId(LessonDTO lesson);

	LessonDTO findByLessonId(Long id);
	LessonDTO findBasicByLessonId(Long id); // 기본정보
	List<CurriculumSubjectDTO> findCurriculumByLessonId(Long id);  // 커리큘럼
	List<TimeTableDTO> findTimetableByLessonId(Long lessonId); // 스케줄 불러오기(읽기용)
	TeacherDTO findTeacherByLessonId(Long id); // 강사
	List<QuickReviewDTO> findQuickReviewByLessonId(Long id);  // 한줄평
	ScheduleDTO findLessonSchedule(Long lessonId); // 스케줄 불러오기(등록용)
	List<ReviewDTO> findReview(); // 보드리뷰
	List<ReviewDTO> findQuickReview(); // 한줄평

	List<LessonDTO> findAll();
	// 카테고리별 페이징한 게시글 불러오기
	List<LessonDTO> findWithPaging(LessonCriteria cri);
	
	// 페이징을 위한 count(카테고리)
	int getTotalCount(LessonCriteria cri);
	
	List<CategoryDTO> findMainCategory();
	List<CategoryDTO> findSubCategory();
	List<CategoryDTO> findLessonLevel();
	
	LessonDetailDTO findLessonDetail(Long lessonId);

	int updateLesson(LessonDTO lesson);
	int updateTeacher(TeacherDTO teacher);
	int updateLessonDetail(LessonDetailDTO detail);
	int updateState(LessonDTO lesson);

	int deleteLesson(Long id);
	int deleteSchedule(Long lessonId);
	int deleteLessonDetail(Long detailId);
	int deleteCurriculum(Long lessonId);
	int deleteCurriculumDetail(Long lessonId);
	Long getLikeCnt(Long id);
	void addLike(LessonLikeDTO like);
	int removeLike(LessonLikeDTO likeDTO);
	LessonLikeDTO getLike(LessonLikeDTO likeDTO);
	List<LessonDTO> getNewList();
	List<LessonDTO> getSoonList();

	Long getReservCnt(Long id);
	void addReserv(LessonReservDTO reserv);
	LessonReservDTO getReserv(LessonReservDTO reservDTO);
	int removeReserv(LessonReservDTO reservDTO);


}
