package alz.order.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)

@WebAppConfiguration

@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@Log4j
public class MerchandisePageControllerTests {

	@Setter(onMethod_ = { @Autowired })
	private WebApplicationContext ctx;

	private MockMvc mockMvc;

	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}

	@Test
	public void testList() throws Exception {

		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/merchandise/list")).andReturn().getModelAndView()
				.getModelMap());

	}

	@Test
	public void testRegister() throws Exception {
		System.out.println("1");
		
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/merchandise/register")
				.param("codeType", "준비물")
				.param("name", "name1")
				.param("description", "description1")
				.param("closedAt", "2020/07/05")
				.param("originPrice", "12345")
				.param("salePrice", "12345")
				.param("discountRate", "5")
				.param("discountDeadline", "2020/07/12")
				.param("displayState", "0")
				.param("refId", "111")
				.param("merchandiseId", "123")
				).andReturn().getModelAndView().getViewName();
		
		System.out.println("2");
		
		log.info(resultPage);
		System.out.println("3");
						
	}
	
	@Test
	public void testGet() throws Exception {
		
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/merchandise/get")
				.param("id", "11"))
				.andReturn().getModelAndView().getModelMap());
	}

	@Test
	public void testModify() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/merchandise/modify")
				.param("id", "20")
				.param("codeType", "준비물")
				.param("name", "name1")
				.param("description", "description1")
				.param("closedAt", "2020/07/05")
				.param("originPrice", "12345")
				.param("salePrice", "12345")
				.param("discountRate", "5")
				.param("discountDeadline", "2020/07/12")
				.param("displayState", "0")
				.param("refId", "111")
				.param("merchandiseId", "123")
				).andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	
	@Test
	public void testRemove() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/merchandise/remove")
				.param("id", "13"))
				.andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
		
	}
	
	@Test
	public void testPaging() throws Exception {
		
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/merchandise/list")
				.param("pageNum", "1")
				.param("amount", "10"))
				.andReturn().getModelAndView().getModelMap());
	}
	
	
	
}
