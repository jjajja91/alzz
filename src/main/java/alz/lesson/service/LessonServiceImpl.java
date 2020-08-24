package alz.lesson.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import alz.file.domain.BoardFileDTO;
import alz.file.domain.LessonFileDTO;
import alz.file.mapper.LessonFileMapper;
import alz.lesson.domain.CategoryDTO;
import alz.lesson.domain.CurriculumDetailDTO;
import alz.lesson.domain.CurriculumSubjectDTO;
import alz.lesson.domain.LessonCriteria;
import alz.lesson.domain.LessonDTO;
import alz.lesson.domain.LessonDetailDTO;
import alz.lesson.domain.LessonLikeDTO;
import alz.lesson.domain.LessonReservDTO;
import alz.lesson.domain.QuickReviewDTO;
import alz.lesson.domain.ReviewDTO;
import alz.lesson.domain.ScheduleDTO;
import alz.lesson.domain.TeacherDTO;
import alz.lesson.domain.TimeTableDTO;
import alz.lesson.mapper.LessonMapper;
import alz.user.mapper.UserMapper;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class LessonServiceImpl implements LessonService {

	private LessonMapper lessonMapper;
	private UserMapper userMapper;
	private LessonFileMapper lessonFileMapper;
	
	@Autowired
	public LessonServiceImpl(LessonMapper lessonMapper, UserMapper userMapper, LessonFileMapper lessonFileMapper) {
		this.lessonMapper = lessonMapper;
		this.userMapper = userMapper;
		this.lessonFileMapper = lessonFileMapper;
		
	}
	
	// 강사등록
	public TeacherDTO createTeacher(TeacherDTO teacher) {
		int affectedRowCount = lessonMapper.insertTeacher(teacher);
		return teacher;
	}
	
	// 클래스 기본정보 등록
	public int createLesson(LessonDTO lesson) 	{
		int updateRowCount;
		int affectedRowCount;
		
		if(lesson.getState()==null) {
			affectedRowCount = lessonMapper.insertLesson(lesson);
		} else {
			// 원래 있던 클래스 지우고 새로만듬
			if(lesson.getState()==1) {
				updateRowCount = lessonMapper.updateLesson(lesson);
			} else {
				affectedRowCount = lessonMapper.insertLesson(lesson);
			}
		}
		
		// 새로운 아이디 넘겨줌
		int lessonId = lesson.getId().intValue();
		return lessonId;
	}
	
	// 클래스 스케줄 등록
	public int createSchedule(ScheduleDTO schedule) {
		int affectedRowCount = 0;
		
		// 원래 있던 스케줄 삭제하고 새로만듬
		int deleteRowCount = lessonMapper.deleteSchedule(schedule.getLessonId());
		
		for(int i=0; i<schedule.getTimeTable().size(); i++) {
			affectedRowCount += lessonMapper.insertSchedule(schedule.getTimeTable().get(i));
		}
		return affectedRowCount;
	}
	
	// 클래스 세부 등록
	public int createLessonDetail(LessonDetailDTO detail) {
		
		// 원래 있던 세부설명 삭제하고 새로만듬
		if(detail.getId()!=null) {
			lessonMapper.deleteLessonDetail(detail.getId());
		}
		
		// 만들어진 클래스 id 보내줌
		int affectedRowCount = lessonMapper.insertLessonDetail(detail);
		int detailId = detail.getId().intValue();
		return detailId;
	}
	
	// 클래스 세부 이미지파일 등록
	public void createLessonDetailFile(LessonDetailDTO detail) {
		
		// 원래 있던 세부설명 삭제하고 새로만듬
		if(detail.getId()!=null) {
			// 파일삭제 추가해야됨
			lessonFileMapper.deleteAll(detail.getLessonId());
		}
		
		if (detail.getFileList() == null || detail.getFileList().size() <= 0) {
			return;
		}
		
		System.out.println(detail.getFileList());
		detail.getFileList().forEach(file -> {
			file.setLessonId(detail.getLessonId());
			lessonFileMapper.insert(file);
		});
	}
	
	// 클래스 커리큘럼 등록
	public int createCurriculum(List<CurriculumSubjectDTO> curriculumList) {
		int affectedRowCount = 0;
		int deleteRowCount = 0;
		
		// 원래 있던 커리큘럼 삭제하고 새로만듬
		if(curriculumList.get(0).getLessonId()!=null) {
		 deleteRowCount += lessonMapper.deleteCurriculum(curriculumList.get(0).getLessonId());
		 deleteRowCount += lessonMapper.deleteCurriculumDetail(curriculumList.get(0).getLessonId());
		}
		
		for(int i=0; i<curriculumList.size(); i++) {
			List<CurriculumDetailDTO> detailList = curriculumList.get(i).getDetailList();
			curriculumList.get(i).setCurriculumOrder(i+1L);
			affectedRowCount += lessonMapper.insertCurriculumSubject(curriculumList.get(i));
			
			for(int j=0; j<detailList.size(); j++) {	
				detailList.get(j).setCurriculumId(curriculumList.get(i).getSubjectId()).setDetailOrder(j+1L);
				affectedRowCount += lessonMapper.insertCurriculumDetail(detailList.get(j));
			}
		}
		
		return affectedRowCount;
	}
	
	// 한줄평 등록
	public int createQuickReview(QuickReviewDTO quickReview) {
		int affectedRowCount = lessonMapper.insertQuickReview(quickReview);
		return affectedRowCount;
	}
		
	// 강사 등록할 때
	public TeacherDTO teacherByUserId(Long userId) {
		TeacherDTO teacher = lessonMapper.findTeacherByUserId(userId);
		return teacher;
	}

	// 클래스 히스토리 기본정보 가져오기
	public List<LessonDTO> lessonsByTeacherId(LessonDTO lesson) {
		List<LessonDTO> lessonList = lessonMapper.lessonsByTeacherId(lesson);
		return lessonList;
	}
	
	// 클래스 작성중 기본정보 가져오기
	public LessonDTO lessonByTeacherId(LessonDTO lesson) {
		LessonDTO searchedlesson = lessonMapper.lessonByTeacherId(lesson);
		return searchedlesson;
	}

	// 클래스 세부
	public LessonDTO readByLessonId(Long id) {
		LessonDTO searchedLessons = lessonMapper.findBasicByLessonId(id);
		return searchedLessons;
	}

	// 클래스 기본정보
	public LessonDTO basicByLessonId(Long id) {
		LessonDTO searchedLessons = lessonMapper.findBasicByLessonId(id);
		System.out.println(searchedLessons);
		return searchedLessons;
	}

	// 커리큘럼 
	public List<CurriculumSubjectDTO> curriculumByLessonId(Long id) {
		List<CurriculumSubjectDTO> curriculumSubject = lessonMapper.findCurriculumByLessonId(id);
		return curriculumSubject;
	}
	
	// 상세 페이지에서 보여지는 수업 스케줄
	@Override
	public List<TimeTableDTO> timeTableByLessonId(Long lessonId) {
		List<TimeTableDTO> timeTable = lessonMapper.findTimetableByLessonId(lessonId);
		return timeTable;
	}
	
	// 강사
	public TeacherDTO teacherByLessonId(Long id) {
		TeacherDTO teacher = lessonMapper.findTeacherByLessonId(id);
		return teacher;
	}
	
	// 한줄평
	public List<QuickReviewDTO> quickReviewByLessonId (Long id) {
		List<QuickReviewDTO> quickReview = lessonMapper.findQuickReviewByLessonId(id);
		return quickReview;
	}	
	
	// 메인 카테고리
	public List<CategoryDTO> mainCategory () {
		List<CategoryDTO> findMainCategory = lessonMapper.findMainCategory();
		return findMainCategory;
	}	
	
	// 서브 카테고리
	public List<CategoryDTO> subCategory () {
		List<CategoryDTO> findSubCategory = lessonMapper.findSubCategory();
		return findSubCategory;
	}
	
	// 난이도
	public List<CategoryDTO> lessonLevel () {
		List<CategoryDTO> findLessonLevel = lessonMapper.findLessonLevel();
		return findLessonLevel;
	}

	public List<LessonDTO> readAll() {
		List<LessonDTO> lessons = lessonMapper.findAll();
		return lessons;
	}
	
	// 카테고리별 페이징한 목록
	public List<LessonDTO> readAll(LessonCriteria cri) {
		List<LessonDTO> lessons = lessonMapper.findWithPaging(cri);
		List<ReviewDTO> reviewList = lessonMapper.findReview();
		List<ReviewDTO> quickReviewList = lessonMapper.findQuickReview();
		
		Long rate;
		for(int i=0; i<lessons.size(); i++) {
			for(int j=0; j<reviewList.size(); j++) {
				int lessonReview = reviewList.get(j).getLessonReviewRate().intValue(); 
				int teacherReview = reviewList.get(j).getTeacherReviewRate().intValue();
				rate = (lessonReview+teacherReview)/2L;
				
				if(lessons.get(i).getId()==reviewList.get(j).getLessonId()) {
					lessons.get(i).setRate(rate);		
				}
			}
			
			for(int k=0; k<quickReviewList.size(); k++) {
			}
		}
		System.out.println(lessons);
		return lessons;
	}
	
	// 스케줄
	public ScheduleDTO scheduleByLessonId(Long lessonId) {
		ScheduleDTO schedule = lessonMapper.findLessonSchedule(lessonId);
		LessonDTO searchedLesson = lessonMapper.findBasicByLessonId(lessonId);
		if(schedule==null) {
			schedule = new ScheduleDTO();
		}
		schedule.setOpenAt(searchedLesson.getOpenAt());
		schedule.setCloseAt(searchedLesson.getCloseAt());
		
		return schedule;
	}

	public LessonDetailDTO detailByLessonId(Long lessonId) {
		LessonDetailDTO detail = lessonMapper.findLessonDetail(lessonId);
		return detail;
	}
	
	public TeacherDTO updateTeacher(TeacherDTO teacher) {
		int affectedRowCount = lessonMapper.updateTeacher(teacher);
		return teacher;
	}
	
	public int updateLessonDetail(LessonDetailDTO detail) {
		int affectedRowCount = lessonMapper.updateLessonDetail(detail);
		return affectedRowCount;
	}
	
	@Transactional
	public int lessonSubmit(Long lessonId, Long userId) {
		LessonDTO lesson = new LessonDTO();
		lesson.setId(lessonId).setState(2L);
		int affectedRowCount = lessonMapper.updateState(lesson);
		userMapper.changeTeacher(userId);
		return affectedRowCount;
	}
	
	@Override
	public int getTotal(LessonCriteria cri) {
		int total = lessonMapper.getTotalCount(cri);
		return total;
	}

	@Override
	public List<LessonFileDTO> getFileList(Long lessonId) {
		log.info("get File list by lesson_id" + lessonId);
		return lessonFileMapper.findByLessonId(lessonId);
	}

	@Override
	public Long getLikeCnt(Long id) {
		return lessonMapper.getLikeCnt(id);
	}

	@Override
	public void addLike(LessonLikeDTO like) {
		lessonMapper.addLike(like);
	}

	@Override
	public boolean isLike(LessonLikeDTO likeDTO) {
		return lessonMapper.getLike(likeDTO) == null ? false : true;
	}

	@Override
	public boolean removeLike(LessonLikeDTO likeDTO) {
		return lessonMapper.removeLike(likeDTO) == 0 ? false : true;
	}

	@Override
	public List<LessonDTO> getNewList() {
		return lessonMapper.getNewList();
	}

	@Override
	public List<LessonDTO> getSoonList() {
		return lessonMapper.getSoonList();
	}

	@Override
	public Long getReservCnt(Long id) {
		return lessonMapper.getReservCnt(id);
	}

	@Override
	public void addReserv(LessonReservDTO reserv) {
		lessonMapper.addReserv(reserv);
	}

	@Override
	public boolean isReserv(LessonReservDTO reservDTO) {
		return lessonMapper.getReserv(reservDTO) == null ? false : true;
	}

	@Override
	public boolean removeReserv(LessonReservDTO reservDTO) {
		return lessonMapper.removeReserv(reservDTO) == 0 ? false : true;
	}
	


}
