package alz.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import alz.order.domain.MerchandiseDTO;
import alz.order.domain.OrderDTO;
import alz.order.domain.PaymentDTO;
import alz.order.mapper.PaymentMapper;

@Service
public class PaymentServiceImpl implements PaymentService {

	//mapper 가져오기
	private PaymentMapper paymentMapper;
	
	@Autowired
	public PaymentServiceImpl(PaymentMapper paymentMapper) {
		this.paymentMapper = paymentMapper;
	}
	
	@Override
	public PaymentDTO create(PaymentDTO payment) {
		int affectedRowCount = paymentMapper.insert(payment);
		PaymentDTO openPayment = paymentMapper.selectById(payment.getId());
		return openPayment;
	}

	@Override
	public PaymentDTO readById(Long id) {
		PaymentDTO searchedPayment = paymentMapper.selectById(id);
		return searchedPayment;
	}

	@Override
	public List<PaymentDTO> readAll() {
		List<PaymentDTO> Payments = paymentMapper.selectAll();
		return Payments;
	}

	@Override
	public PaymentDTO updateById(Long id, PaymentDTO payment) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int deleteById(Long id) {
		PaymentDTO searchedPayment = paymentMapper.selectById(id);
		int affectedRowCount = paymentMapper.deleteById(id);
		return affectedRowCount;
	}

}
