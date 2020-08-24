package alz.admin.service;

import java.util.List;

import alz.admin.domain.BoardCriteriaAdmin;
import alz.admin.domain.LessonDTOAdmin;
import alz.admin.domain.LessonStateDTO;
import alz.lesson.domain.CurriculumSubjectDTO;
import alz.lesson.domain.LessonDTO;
import alz.lesson.domain.QuickReviewDTO;
import alz.lesson.domain.TeacherDTO;
import alz.lesson.domain.TimeTableDTO;

public interface LessonServiceAdmin {

	Object readAll(BoardCriteriaAdmin cri);

	int getTotal(BoardCriteriaAdmin cri);

	void stateChangebyId(LessonStateDTO lessonDTO);

	// 클래스 읽기
	LessonDTO readByLessonId(Long id);
	List<CurriculumSubjectDTO> curriculumByLessonId(Long lessonId); // 새로만든 클래스
	List<TimeTableDTO> timeTableByLessonId(Long lessonId); // 스케줄 불러오기(상세 페이지에서 사용)
	TeacherDTO teacherByLessonId(Long id); // 강사소개

}
