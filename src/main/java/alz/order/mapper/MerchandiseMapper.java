package alz.order.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import alz.lesson.domain.TeacherDTO;
import alz.order.domain.CartDTO;
import alz.order.domain.MerchandiseCriteria;
import alz.order.domain.MerchandiseDTO;

public interface MerchandiseMapper {

	int insert(MerchandiseDTO merchandise);

	MerchandiseDTO selectById(Long id);

//	List<MerchandiseDTO> selectAll();

	int updateById(MerchandiseDTO merchandise);

	int deleteById(Long id);

	int update(MerchandiseDTO merchandise);

	//전체
	List<MerchandiseDTO> getListWithPaging(MerchandiseCriteria cri);
	int getTotalCount(MerchandiseCriteria cri);
	
	// 선생님 개별
	List<MerchandiseDTO> getMyListWithPaging(MerchandiseCriteria cri);
	int getCount(MerchandiseCriteria cri);
		
	Long selectLessonById(Long id);

	MerchandiseDTO readByrefId(Long lessonId);

	Long findMerchandiseId(long id);

	

}
