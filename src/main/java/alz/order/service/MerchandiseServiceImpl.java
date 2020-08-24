package alz.order.service;

import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import alz.lesson.domain.LessonDTO;
import alz.lesson.domain.TeacherDTO;
import alz.lesson.mapper.LessonMapper;
import alz.order.domain.MerchandiseCriteria;
import alz.order.domain.MerchandiseDTO;
import alz.order.mapper.MerchandiseMapper;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MerchandiseServiceImpl implements MerchandiseService {

	private MerchandiseMapper merchandiseMapper;
	private LessonMapper lessonMapper;

	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

	@Autowired
	public MerchandiseServiceImpl(MerchandiseMapper merchandiseMapper, LessonMapper lessonMapper) {
		this.merchandiseMapper = merchandiseMapper;
		this.lessonMapper = lessonMapper;
	}

	@Transactional
	@Override
	public MerchandiseDTO create(MerchandiseDTO merchandise) {
		int affectedRowCount = merchandiseMapper.insert(merchandise);
		System.out.println(merchandise);
		LessonDTO lesson = new LessonDTO();
		lesson.setId(merchandise.getRefId()).setState(7L);
		System.out.println(lesson);
		lessonMapper.updateState(lesson);
		MerchandiseDTO openMerchandise = merchandiseMapper.selectById(merchandise.getId());
		return openMerchandise;
	}

	@Override
	public MerchandiseDTO readById(Long id) {
		MerchandiseDTO searchedMerchandise = merchandiseMapper.selectById(id);
		return searchedMerchandise;
	}

//	@Override
//	public List<MerchandiseDTO> readAll() {
//		List<MerchandiseDTO> merchandises = merchandiseMapper.selectAll();
//		return merchandises;
//	}

	@Override
	public List<MerchandiseDTO> readAll(MerchandiseCriteria cri) {
		List<MerchandiseDTO> merchandises = merchandiseMapper.getListWithPaging(cri);
		return merchandises;
	}

	@Override
	public MerchandiseDTO updateById(Long id, MerchandiseDTO merchandise) {
		MerchandiseDTO searchedMerchandise = merchandiseMapper.selectById(id);
		searchedMerchandise.setCodeType(merchandise.getCodeType()).setName(merchandise.getName())
				.setDescription(merchandise.getDescription()).setUpdatedAt(merchandise.getUpdatedAt())
				.setClosedAt(merchandise.getClosedAt()).setOriginPrice(merchandise.getOriginPrice())
				.setSalePrice(merchandise.getSalePrice()).setDiscountRate(merchandise.getDiscountRate())
				.setDiscountDeadline(merchandise.getDiscountDeadline()).setDisplayState(merchandise.getDisplayState());
		int affectedRowCount = merchandiseMapper.updateById(searchedMerchandise);
		return searchedMerchandise;
	}

	@Override
	public int deleteById(Long id) {
		MerchandiseDTO searchedMerchandise = merchandiseMapper.selectById(id);
		int affectedRowCount = merchandiseMapper.deleteById(id);
		return affectedRowCount;
	}

	@Override
	public MerchandiseDTO update(MerchandiseDTO merchandise) {
		MerchandiseDTO searchedMerchandise = merchandiseMapper.selectById(merchandise.getId());
		searchedMerchandise.setCodeType(merchandise.getCodeType()).setName(merchandise.getName())
				.setDescription(merchandise.getDescription()).setUpdatedAt(merchandise.getUpdatedAt())
				.setClosedAt(merchandise.getClosedAt()).setOriginPrice(merchandise.getOriginPrice())
				.setSalePrice(merchandise.getSalePrice()).setDiscountRate(merchandise.getDiscountRate())
				.setDiscountDeadline(merchandise.getDiscountDeadline()).setDisplayState(merchandise.getDisplayState());
		int affectedRowCount = merchandiseMapper.updateById(searchedMerchandise);
		return searchedMerchandise;
	}

	@Override
	public int getTotal(MerchandiseCriteria cri) {
		log.info("get total count");

		return merchandiseMapper.getTotalCount(cri);
	}

	@Override
	public MerchandiseDTO readByrefId(Long lessonId) {
		return merchandiseMapper.readByrefId(lessonId);
	}

	@Override
	public Long findMerchandiseId(long id) {
		return merchandiseMapper.findMerchandiseId(id);
	}

	@Override
	public List<MerchandiseDTO> readMyLesson(MerchandiseCriteria cri) {
		List<MerchandiseDTO> merchandises = merchandiseMapper.getMyListWithPaging(cri);
		return merchandises;
	}

	@Override
	public int getCount(MerchandiseCriteria cri) {
		log.info("get total count");

		return merchandiseMapper.getCount(cri);
	}

}
