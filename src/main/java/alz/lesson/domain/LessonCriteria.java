package alz.lesson.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

@Getter
@Setter
@ToString
@Accessors(chain=true)
public class LessonCriteria {

	private int pageNum;
	private int amount;
	
	// 상태 추가
	private int state;
	// 카테고리 추가
	private int categoryMain;
	private int categorySub;
	
	private String keyword;
	
	public LessonCriteria() {
		this(1,8);
	}
	
	public LessonCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public LessonCriteria(int pageNum, int amount, int state) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.state = state;
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("state", this.getState())
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("categoryMain", this.getCategoryMain())
				.queryParam("categorySub", this.getCategorySub())
				.queryParam("keyword", this.getKeyword());

		return builder.toUriString();
	}
}
