package alz.order.domain;

import java.util.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.PositiveOrZero;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

@Getter
@Setter
@Builder
@Accessors(chain = true)
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MerchandiseLessonAll {

	private Long id;
	@NotBlank(message = "상품명을 입력해주세요")
	@Size(min=1, max=50, message="제목은 50자 이내로 입력해주세요")
	private String name;
	@NotBlank(message = "상품 타입을 선택해주세요")
	private String codeType;
	@NotBlank(message = "상품 내용을 입력해주세요")
	@Size(min=1, max=500, message="내용은 500자 이내로 입력해주세요")
	private String description;
	private Date registerAt;
	private Date updatedAt;
	@NotNull(message = "상품 마감일을 입력해주세요")
	private Date closedAt;
	@NotNull(message = "상품 가격을 입력해주세요")
	@PositiveOrZero(message = "양수만 입력 가능합니다")
	private Long originPrice;
	@NotNull(message = "할인 금액을 입력해주세요")
	private Long salePrice;
	@NotNull(message = "할인률을 입력해주세요")
	private Double discountRate;
	@NotNull(message = "상품 할인 마감일을 입력해주세요")
	private Date discountDeadline;
	@NotNull(message = "진열 여부를 입력해주세요")
	private Integer displayState;
	@NotNull(message = "FK 자동 입력 예정입니다.")
	private Long userId;
	@NotNull(message = "FK 자동 입력 예정입니다.")
	private Long refId;
	
	private Long originalId;
	private Long lessonId;
	private Long teacherId;
	private Long categoryMain;
	private Long categorySub; 
	private String categoryName;
	private String title;
	private Long lessonType;
	private String typeName;
	private Long lessonLevel;
	private String levelName;
	private Long minStudent;
	private Long maxStudent;
	private Long currentStudent;
	private Long state;
	private Date openAt;
	private Date closeAt;
	private String startAt;
	private String endAt;
	private String detail;
	private String thumbnail;
	
	private String location;

}
