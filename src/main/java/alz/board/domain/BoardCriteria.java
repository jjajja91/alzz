package alz.board.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

@Getter
@Setter
@ToString
@Accessors(chain=true)
public class BoardCriteria {

	private int pageNum;
	private int amount;
	
	// 게시판 타입 추가
	private int typeId;
	
	private String type;
	private String keyword;
	
	public BoardCriteria() {
		this(1,10);
	}
	
	public BoardCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public BoardCriteria(int pageNum, int amount, int typeId) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.typeId = typeId;
	}
	
	public String[] getTypeArr() {
		return type == null? new String[] {}: type.split("");
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("typeId", this.getTypeId())
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());

		return builder.toUriString();
	}
	
}
