package alz.file.mapper;

import java.util.List;

import alz.file.domain.LessonFileDTO;

public interface LessonFileMapper {
	
	public int insert(LessonFileDTO file);
	
	public void delete(Long lessonId);
	
	public List<LessonFileDTO> findByLessonId(Long lessonId);
	
	public void deleteAll(Long lessonId);
	
	public List<LessonFileDTO> getOldFiles();

}
