package alz.order.service;

import java.util.List;

import alz.order.domain.PaymentDTO;

public interface PaymentService {

	PaymentDTO create(PaymentDTO payment);

	PaymentDTO readById(Long id);

	List<PaymentDTO> readAll();

	PaymentDTO updateById(Long id, PaymentDTO payment);

	int deleteById(Long id);

}
