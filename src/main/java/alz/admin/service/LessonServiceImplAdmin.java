package alz.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import alz.admin.domain.BoardCriteriaAdmin;
import alz.admin.domain.LessonStateDTO;
import alz.admin.mapper.LessonMapperAdmin;
import alz.lesson.domain.CurriculumSubjectDTO;
import alz.lesson.domain.LessonDTO;
import alz.lesson.domain.TeacherDTO;
import alz.lesson.domain.TimeTableDTO;
import alz.lesson.mapper.LessonMapper;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class LessonServiceImplAdmin implements LessonServiceAdmin {
	
	//mapper 가져와서 사용
	private LessonMapperAdmin lessonMapperAdmin;
	// 읽기용
	private LessonMapper lessonMapper;
	
	@Autowired
	public LessonServiceImplAdmin(LessonMapperAdmin lessonMapperAdmin, LessonMapper lessonMapper) {
		this.lessonMapperAdmin = lessonMapperAdmin;
		this.lessonMapper = lessonMapper;
	}

	@Override
	public Object readAll(BoardCriteriaAdmin cri) {
		List<LessonDTO> list = lessonMapperAdmin.LessonReqList(cri);
		return list;
	}

	@Override
	public int getTotal(BoardCriteriaAdmin cri) {
		int total = lessonMapperAdmin.getTotalCount(cri);
		return total;
	}

	@Override
	public void stateChangebyId(LessonStateDTO lessonDTO) {
		if(lessonDTO.getLessonId()!=null) {
			for(int i=0; i<lessonDTO.getLessonId().size();i++) {
				lessonDTO.setId(lessonDTO.getLessonId().get(i));
				lessonMapperAdmin.stateChangebyId(lessonDTO);
			}
		} else {
			lessonMapperAdmin.stateChangebyId(lessonDTO);
		}
	}

	// 클래스 읽기
	@Override
	public LessonDTO readByLessonId(Long id) {
		LessonDTO searchedLessons = lessonMapper.findBasicByLessonId(id);
		return searchedLessons;
	}

	// 커리큘럼 읽기
	@Override
	public List<CurriculumSubjectDTO> curriculumByLessonId(Long lessonId) {
		List<CurriculumSubjectDTO> curriculumSubject = lessonMapper.findCurriculumByLessonId(lessonId);
		return curriculumSubject;
	}

	// 스케줄 읽기
	@Override
	public List<TimeTableDTO> timeTableByLessonId(Long lessonId) {
		List<TimeTableDTO> timeTable = lessonMapper.findTimetableByLessonId(lessonId);
		return timeTable;
	}

	// 강사소개
	@Override
	public TeacherDTO teacherByLessonId(Long id) {
		TeacherDTO teacher = lessonMapper.findTeacherByLessonId(id);
		return teacher;
	}
}
