package alz.order.service;

import java.util.List;

import alz.lesson.domain.TeacherDTO;
import alz.order.domain.CartDTO;
import alz.order.domain.MerchandiseCriteria;
import alz.order.domain.MerchandiseDTO;

public interface MerchandiseService {

	MerchandiseDTO create(MerchandiseDTO merchandise);

	MerchandiseDTO readById(Long id);

//	List<MerchandiseDTO> readAll();

	// 전체
	List<MerchandiseDTO> readAll(MerchandiseCriteria cri);
	int getTotal(MerchandiseCriteria cri);

	MerchandiseDTO updateById(Long id, MerchandiseDTO merchandise);

	int deleteById(Long id);

	MerchandiseDTO update(MerchandiseDTO merchandise);


	MerchandiseDTO readByrefId(Long lessonId);

	Long findMerchandiseId(long id);

	// 선생님 개별
	List<MerchandiseDTO> readMyLesson(MerchandiseCriteria cri);
	int getCount(MerchandiseCriteria cri);

}
