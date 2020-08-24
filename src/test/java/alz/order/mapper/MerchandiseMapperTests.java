package alz.order.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import alz.order.domain.MerchandiseCriteria;
import alz.order.domain.MerchandiseDTO;
import alz.order.service.MerchandiseService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MerchandiseMapperTests {

	@Setter(onMethod_ = @Autowired)
	private MerchandiseMapper merchandiseMapper;
	
	@Setter(onMethod_ = @Autowired)
	private MerchandiseService merchandiseService;

	@Test
	public void testPaging() {

		MerchandiseCriteria cri = new MerchandiseCriteria();

		cri.setPageNum(1);
		cri.setAmount(10);
		List<MerchandiseDTO> list = merchandiseMapper.getListWithPaging(cri);

		list.forEach(merchandise -> log.info(merchandise.getId()));
	}

	@Test
	public void testGetList() {
		merchandiseService.readAll(new MerchandiseCriteria(1, 10)).forEach(merchandise -> log.info(merchandise));
	}
	
	@Test
	public void testSearch() {
		MerchandiseCriteria cri = new MerchandiseCriteria();
		cri.setKeyword("수업1");
		cri.setType("TC");

		List<MerchandiseDTO> list = merchandiseMapper.getListWithPaging(cri);
		
		list.forEach(merchandise -> log.info(merchandise));
	}

}
