package alz.order.mapper;

import java.util.List;

import alz.order.domain.PaymentDTO;

public interface PaymentMapper {

	int insert(PaymentDTO payment);
	
	PaymentDTO selectById(Long id);
	
	List<PaymentDTO> selectAll();
	
	int updateById(PaymentDTO payment);
	
	int deleteById(Long id);
	
}
