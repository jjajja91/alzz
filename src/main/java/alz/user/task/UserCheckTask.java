package alz.user.task;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import alz.user.mapper.UserMapper;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class UserCheckTask {
	
	private UserMapper userMapper;
	
	public UserCheckTask(UserMapper userMapper) {
		this.userMapper = userMapper;
	}
	
	// 지정된 시간에 탈퇴한지 15일이 된 유저 삭제
	@Scheduled(cron="0 58 15 * * *")
	public void checkUsers() {
		SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -15);
		String date = sdf.format(cal.getTime());

		List<Long> userId = userMapper.findWithdrawUser(date);	
		
		log.info("탈퇴 대상 회원: " + userId);
		System.out.println("탈퇴 대상 회원: " + userId);
		
		int result = 0;
		for(int i = 0; i<userId.size(); i++) {
			Long id = userId.get(i);
			result += userMapper.deleteById(id);
		}
		log.info("삭제 수: " + result);
		System.out.println("삭제 수: " + result);
	}

}
