package alz.order.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

@Setter
@Getter
@Builder
@Accessors(chain = true)
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class OrderDetailDTO {

	private Long id;
	private String orderId;
	private Long refId;
	private Long merchandiseId;
	private Long amount;
	private Long userId;
	private String name;
	private Long originPrice;
	private Long salePrice;
	
	private String thumbnail;
	private Long teacherId;
	private Date openAt;
	private Long lessonId;
}
