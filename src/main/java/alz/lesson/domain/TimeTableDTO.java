package alz.lesson.domain;


import java.sql.Date;

import javax.validation.constraints.NotEmpty;

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
@Accessors(chain=true)
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class TimeTableDTO {

	private Long timeTableId;  // lesson id
	private Date openAt;
	private Date closeAt;
	private Date lessonDate;
	private String startAt;
	private String endAt;
	
}