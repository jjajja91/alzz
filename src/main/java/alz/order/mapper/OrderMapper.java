package alz.order.mapper;

import java.util.List;

import alz.order.domain.LessonStudentDTO;
import alz.order.domain.OrderDTO;
import alz.order.domain.OrderDetailDTO;

public interface OrderMapper {

	public void removeCart(Long userId);

	public void insertOrder(OrderDTO order);

	public void insertOrderDetail(OrderDetailDTO order);
	
	public List<OrderDetailDTO> orderResult(String orderId);

	public void orderDetailInsert(OrderDetailDTO orderDetail);

	public OrderDTO findOrderer(String orderId);

	public int linkStudentForLesson(LessonStudentDTO lessonStudent);
}
