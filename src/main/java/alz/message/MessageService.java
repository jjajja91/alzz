package alz.message;

import java.io.IOException;

import org.springframework.stereotype.Service;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;


@Service
public class MessageService {

	private FirebaseApp firebaseBuilder() throws IOException {
		FirebaseOptions options = new FirebaseOptions.Builder()
				.setCredentials(GoogleCredentials.getApplicationDefault())
				.setDatabaseUrl("https://a2-alz.firebaseio.com/").build();
		if (FirebaseApp.getApps().isEmpty()) {
			return FirebaseApp.initializeApp(options);
		} else {
			return FirebaseApp.getInstance();
		}
	}

	public void sendAlarm() {

		try {
			FirebaseMessaging messaging = FirebaseMessaging.getInstance(firebaseBuilder());

			Message message = Message.builder().setToken(
					"eNovE-vXKHkYF0RR3gQeHK:APA91bGPwLwkCz49OUQqWuD7KxO2nqr6Ig0By-TVJah4b-vQ8ddEdgXdR9PDsAiX2mpGviq6XZeo3lvr__VAvIJJ4mtc0tm4ZP_QuwYEWTsatfoSF8j_DicCAYE6NMBraZEDHFojEa1y")
					.setNotification(new Notification("ALZ", "안녕하세요 테스트입니다.")).build();

			messaging.send(message);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FirebaseMessagingException fe) {
			// TODO Auto-generated catch block
			fe.printStackTrace();
		}
	}

}
