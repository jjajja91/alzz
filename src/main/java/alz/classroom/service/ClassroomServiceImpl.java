package alz.classroom.service;

import java.util.List;

import org.springframework.stereotype.Service;

import alz.classroom.mapper.ClassroomMapper;

@Service
public class ClassroomServiceImpl implements ClassroomService {

	private ClassroomMapper classroomMapper;
	
	public ClassroomServiceImpl(ClassroomMapper classroomMapper) {
		this.classroomMapper = classroomMapper;
	}

	@Override
	public boolean checkStudent(Long lessonId, Long userId) {
		List<Long> students = classroomMapper.findStudentByLesson(lessonId);
		
		for(int i = 0; i<students.size(); i++) {
			if(students.get(i)==userId) {
			return true;
			}
		}
		return false;
	}
	
	
	
}
