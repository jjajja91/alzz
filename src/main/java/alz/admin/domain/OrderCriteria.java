package alz.admin.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class OrderCriteria {

	private int pageNum;
	private int amount;

	private String type;
	private String keyword;
	private Long userId;
	private String state;

	public OrderCriteria() {
		this(1, 10);
	}

	public OrderCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	public String[] getTypeArr() {

		return type == null ? new String[] {} : type.split("");
	}
}
