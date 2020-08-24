package alz.classroom.mapper;

import java.util.List;

public interface ClassroomMapper {

	List<Long> findStudentByLesson(Long lessonId);

}
