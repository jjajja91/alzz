package alz.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import alz.order.domain.LessonStudentDTO;
import alz.order.domain.OrderDTO;
import alz.order.domain.OrderDetailDTO;
import alz.order.domain.OrderRequestDTO;
import alz.order.mapper.MerchandiseMapper;
import alz.order.mapper.OrderMapper;

@Service
public class OrderServiceImpl implements OrderService {

	// mapper 가져올 것
	private OrderMapper orderMapper;
	private MerchandiseMapper merchandiseMapper;

	@Autowired
	public OrderServiceImpl(OrderMapper orderMapper, MerchandiseMapper merchandiseMapper) {
		this.orderMapper = orderMapper;
		this.merchandiseMapper = merchandiseMapper;
	}

	@Transactional
	@Override
	public void insertOrder(OrderRequestDTO orderRequest) {
		OrderDTO order = new OrderDTO();
		order.setId(orderRequest.getId()).setMethod(orderRequest.getMethod()).setName(orderRequest.getName())
		.setPhone(orderRequest.getPhone()).setUserId(orderRequest.getUserId()).setState(orderRequest.getState())
		.setTotalPrice(orderRequest.getTotalPrice());
		orderMapper.insertOrder(order);
		
		System.out.println("order: " +order);
		System.out.println("orderRequest: " +orderRequest);
		System.out.println("insertOrder Ok");
		
		OrderDetailDTO orderDetail = new OrderDetailDTO();
		orderDetail.setOrderId(orderRequest.getId()).setAmount(orderRequest.getAmount())
		.setUserId(orderRequest.getUserId());
		
		LessonStudentDTO lessonStudent = new LessonStudentDTO();
		lessonStudent.setStudentId(orderRequest.getUserId());
		
		for(int i = 0; i<orderRequest.getMerchandiseId().size(); i++) {
			System.out.println(i + "회차");
			Long merchandiseId = orderRequest.getMerchandiseId().get(i);
			System.out.println("상품식별자: " + merchandiseId);
			orderDetail.setMerchandiseId(merchandiseId);
			System.out.println(orderDetail);
			orderMapper.insertOrderDetail(orderDetail);
			Long lessonId = merchandiseMapper.selectLessonById(merchandiseId);
			lessonStudent.setLessonId(lessonId);
			System.out.println(lessonStudent);
			orderMapper.linkStudentForLesson(lessonStudent);
		}
	}

	@Override
	public void removeCart(Long userId) throws Exception {
		orderMapper.removeCart(userId);
	}


	@Override
	public List<OrderDetailDTO> orderResult(String orderId) {
		return orderMapper.orderResult(orderId);
	}


	@Override
	public void orderDetailInsert(OrderDetailDTO orderDetail) throws Exception {
		orderMapper.orderDetailInsert(orderDetail);
		
	}

	@Override
	public OrderDTO findOrderer(String orderId) {
		return orderMapper.findOrderer(orderId);
	}



}
