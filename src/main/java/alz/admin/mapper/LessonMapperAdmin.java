package alz.admin.mapper;

import java.util.List;

import alz.admin.domain.BoardCriteriaAdmin;
import alz.admin.domain.LessonDTOAdmin;
import alz.admin.domain.LessonStateDTO;
import alz.lesson.domain.LessonDTO;

public interface LessonMapperAdmin {

	List<LessonDTO> LessonReqList(BoardCriteriaAdmin cri);

	int getTotalCount(BoardCriteriaAdmin cri);

	void stateChangebyId(LessonStateDTO lessonDTO);


}
