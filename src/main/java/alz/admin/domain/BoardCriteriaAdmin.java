package alz.admin.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

@Getter
@Setter
@ToString
@Accessors(chain=true)
public class BoardCriteriaAdmin {

	private int pageNum;
	private int amount;
	

	public BoardCriteriaAdmin() {
		this(1,10);
	}
	
	public BoardCriteriaAdmin(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	/*
	 * public BoardCriteria(int pageNum, int amount, int typeId) { this.pageNum =
	 * pageNum; this.amount = amount; this.typeId = typeId; }
	 */
	
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")				
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount());

		return builder.toUriString();
	}
	
}
