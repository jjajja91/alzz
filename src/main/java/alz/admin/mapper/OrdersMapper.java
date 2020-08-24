package alz.admin.mapper;

import java.util.List;

import alz.admin.domain.OrderCriteria;
import alz.order.domain.OrderAllDTO;
import alz.order.domain.OrderDTO;

public interface OrdersMapper {

	public List<OrderAllDTO> orderList();
	public List<OrderAllDTO> orderListPaging(OrderCriteria cri);
	public int getTotalCount(OrderCriteria cri);
	public void stateChange(OrderDTO order);
	public List<OrderAllDTO> myOrderListPaging(OrderCriteria cri);
	public int getMyTotalCount(OrderCriteria cri);
	public List<OrderAllDTO> cancelListPaging(OrderCriteria cri);
	public int cancelTotalCount(OrderCriteria cri);
}
