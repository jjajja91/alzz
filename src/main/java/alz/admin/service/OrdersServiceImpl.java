package alz.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import alz.admin.domain.OrderCriteria;
import alz.admin.mapper.OrdersMapper;
import alz.order.domain.OrderAllDTO;
import alz.order.domain.OrderDTO;

@Service
public class OrdersServiceImpl implements OrdersService {
	
	//mapper 가져와서 사용
	private OrdersMapper ordersMapper;
	
	@Autowired
	public OrdersServiceImpl(OrdersMapper ordersMapper) {
		this.ordersMapper = ordersMapper;
	}

	@Override
	public List<OrderAllDTO> orderList() {
		return ordersMapper.orderList();
	}

	@Override
	public List<OrderAllDTO> orderListPaging(OrderCriteria cri) {
		return ordersMapper.orderListPaging(cri);
	}

	@Override
	public int getTotal(OrderCriteria cri) {
		return ordersMapper.getTotalCount(cri);
	}

	@Override
	public void stateChange(OrderDTO order) {
		ordersMapper.stateChange(order);
	}

	@Override
	public List<OrderAllDTO> myOrderListPaging(OrderCriteria cri) {
		return ordersMapper.myOrderListPaging(cri);
	}

	@Override
	public int getMyTotal(OrderCriteria cri) {
		return ordersMapper.getMyTotalCount(cri);
	}

	@Override
	public List<OrderAllDTO> cancelListPaging(OrderCriteria cri) {
		return ordersMapper.cancelListPaging(cri);
	}

	@Override
	public int getMyCancelTotal(OrderCriteria cri) {
		return ordersMapper.cancelTotalCount(cri);
	}
	

}
