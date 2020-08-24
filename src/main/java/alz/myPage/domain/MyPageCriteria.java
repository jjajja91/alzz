package alz.myPage.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

@Getter
@Setter
@ToString
@Accessors(chain=true)
public class MyPageCriteria {

	private long pageNum;
	private long amount;
	private long id;
	
	public MyPageCriteria() {
		this(1,10);
	}
	
	public MyPageCriteria(long pageNum, long amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public MyPageCriteria(long pageNum, long amount, long id) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.id = id;
	}
	
	/*
	 * public String[] getTypeArr() { return type == null? new String[] {}:
	 * type.split(""); }
	 */
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("id", this.getId())
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount());
				
		return builder.toUriString();
	}
	
}
