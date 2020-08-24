package alz.order.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import alz.order.domain.PaymentDTO;
import alz.order.service.PaymentService;

@RestController
@RequestMapping("/payments")
public class PaymentApiController {

	private PaymentService paymentService;
	
	@Autowired
	public PaymentApiController(PaymentService paymentService) {
		this.paymentService = paymentService;
	}
	
	@PostMapping
	public ResponseEntity<?> create(@RequestBody PaymentDTO payment) {
		PaymentDTO registeredPayment = paymentService.create(payment);
		return ResponseEntity.status(HttpStatus.CREATED).body(registeredPayment);
	}
	
	@GetMapping("/{id}")
	public ResponseEntity<?> readOne(@PathVariable Long id) {
		PaymentDTO searchedPayment = paymentService.readById(id);
		return ResponseEntity.status(HttpStatus.OK).body(searchedPayment);
	}
	
	@GetMapping
	public ResponseEntity<?> readAll() {
		List<PaymentDTO> payments = paymentService.readAll();
		return ResponseEntity.status(HttpStatus.OK).body(payments);
	}
	
	@PutMapping("/{id}")
	public ResponseEntity<?> updateOne(@PathVariable Long id, @RequestBody PaymentDTO payment) {
		PaymentDTO updatedPayment = paymentService.updateById(id, payment);
		return ResponseEntity.status(HttpStatus.OK).body(updatedPayment);
	}
	
	@DeleteMapping("/{id}")
	public ResponseEntity<?> deleteOne(@PathVariable Long id) {
		int affectedRowCount = paymentService.deleteById(id);
		return ResponseEntity.status(HttpStatus.OK).body(affectedRowCount);
	}
	
}
