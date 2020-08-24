package alz.order.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import alz.board.exceptions.TemporaryServerException;
import alz.board.exceptions.UnsatisfiedContentException;
import alz.order.domain.MerchandiseCriteria;
import alz.order.domain.MerchandiseDTO;
import alz.order.service.MerchandiseService;

@RestController
@RequestMapping("/merchandises")
public class MerchandiseApiController {

	private MerchandiseService merchandiseService;
	
	@Autowired
	public MerchandiseApiController(MerchandiseService merchandiseService) {
		this.merchandiseService = merchandiseService;
	}
	
	
	// 상품 등록
	@PostMapping(produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> create(@RequestBody @Valid MerchandiseDTO merchandise, BindingResult result){
		
		System.out.println("merchandise " + merchandise);
		
		// 유효성 체크 에러메세지 분기
		if (result.hasErrors()) {
			FieldError error = result.getFieldError();
			if (result.getFieldError().getCode().indexOf("NotNull") != -1)
				throw new TemporaryServerException(error);
			else
				throw new UnsatisfiedContentException(error);
		} else {
			merchandiseService.create(merchandise);
		}
		
		return ResponseEntity.status(HttpStatus.CREATED).body(merchandise);
	}
	
	@GetMapping("/{id}")
	public ResponseEntity<?> readOne(@PathVariable Long id){
		MerchandiseDTO searchedMerchandise = merchandiseService.readById(id);
		return ResponseEntity.status(HttpStatus.OK).body(searchedMerchandise);
	}
	
//	@GetMapping()
//	public ResponseEntity<?> readAll() {
//		List<MerchandiseDTO> merchandises = merchandiseService.readAll();
//		return ResponseEntity.status(HttpStatus.OK).body(merchandises);
//	}
	
	@PutMapping("/{id}")
	public ResponseEntity<?> updateOne(@PathVariable Long id, @RequestBody MerchandiseDTO merchandise) {
		MerchandiseDTO updatedMerchandise = merchandiseService.updateById(id, merchandise);
		return ResponseEntity.status(HttpStatus.OK).body(updatedMerchandise);
	}
	
	@DeleteMapping("/{id}")
	public ResponseEntity<?> deleteOne(@PathVariable Long id) {
		int affectedRowCount = merchandiseService.deleteById(id);
		return ResponseEntity.status(HttpStatus.OK).body("ok");
	}
	
	
}
