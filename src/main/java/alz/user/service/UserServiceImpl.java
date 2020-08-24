package alz.user.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import alz.user.domain.UserDTO;
import alz.user.domain.UserStateDTO;
import alz.user.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService, UserDetailsService {

	// mapper 가져와서 사용
	private UserMapper userMapper;

	private PasswordEncoder passwordEncoder;

	@Autowired
	public UserServiceImpl(UserMapper userMapper, PasswordEncoder passwordEncoder) {
		this.userMapper = userMapper;
		this.passwordEncoder = passwordEncoder;
	}

	@Transactional
	@Override
	public UserDTO create(UserDTO user) {
		user.encodePassword(passwordEncoder);
		int affectedRowCount = userMapper.insert(user);
		UserStateDTO userState = new UserStateDTO();
		userState.setUserId(user.getId()).setState("가입");
		userMapper.insertState(userState);
		userMapper.insertDetail(user);
		UserDTO openUser = userMapper.selectById(user);

		if (openUser == null) {
			System.out.println("Create Fail!!");
		} else {
			System.out.println("Create Success!!");
		}

		return openUser;
	}

	@Override
	public UserDTO readById(UserDTO user) {
		UserDTO searchedUser = userMapper.selectById(user);
		System.out.println("나옴?" + searchedUser);
		if (searchedUser == null) {
			System.out.println("Login Fail!!");
		} else {
			System.out.println("Login Success!!");
		}

		return searchedUser;
	}

	@Override
	public UserDTO readByEmail(String email) {
		System.out.println(email);
		UserDTO searchedUser = userMapper.selectByEmail(email);

		return searchedUser;
	}

	@Override
	public UserDTO readByNickname(String nickname) {
		UserDTO searchedUser = userMapper.selectByNickname(nickname);
		return searchedUser;
	}

	@Override
	public UserDTO readByPhoneNumber(String phoneNumber) {
		UserDTO searchedUser = userMapper.selectByPhoneNumber(phoneNumber);

		return searchedUser;
	}

	@Override
	public boolean emailChk(String email) {
		return userMapper.emailChk(email) == 1;
	}

	@Override
	public boolean nicknameChk(String nickname) {
		return userMapper.nicknameChk(nickname) == 1;
	}

	@Override
	public int phoneNumberChk(String phoneNumber) {
		return phoneNumberChk(phoneNumber);
	}

	@Override
	public List<UserDTO> readAll() {
		List<UserDTO> user = userMapper.selectAll();
		return user;
	}

	@Transactional
	@Override
	public UserDTO updateById(UserDTO user) {
		UserDTO searchedUser = userMapper.selectedByUser(user);
		searchedUser.setNickname(user.getNickname()).setPassword(user.getPassword())
				.setCertificationState(user.getCertificationState()).setPhoneNumber(user.getPhoneNumber())
				.setState(user.getState()).setEndAt(user.getEndAt());
		System.out.println(searchedUser);

		searchedUser.encodePassword(passwordEncoder); // security 수정에 적용

		int affectedRowCount = userMapper.updateById(searchedUser);
		UserStateDTO userState = new UserStateDTO();
		userState.setUserId(user.getId()).setState("수정").setDescription(user.getDescription());
		userMapper.insertState(userState);

		if (affectedRowCount == 0) {
			System.out.println("Modify Fail!!");
		} else {
			System.out.println("Modify Success!!");
		}

		return searchedUser;
	}

	@Override
	public UserDTO userInfo(long id) {
		return userMapper.userInfo(id);
	}

	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		UserDTO user = userMapper.selectByEmail(email);
		if (user == null) {
			throw new UsernameNotFoundException(email);
		}
		System.out.println("loadUserbyUsername");
		System.out.println(user);
		return user;
	}

	@Override
	public String searchId(String email) {
		return userMapper.searchId(email);
	}

	@Override
	public String find_id(String nickname, String phoneNumber, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String email = userMapper.find_id(nickname, phoneNumber, response);

		if (email == null) {
			out.println("<script>");
			out.println("alert('가입된 아이디가 없습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return null;
		} else if(userMapper.checkUser(email)==1) {
			out.println("<script>");
			out.println("alert('소셜유저입니다 소셜로그인 해주세요.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return null;
		} else {
			return email;
		}
	}

	// 비밀번호 찾기
	@Override
	public String find_password_email(UserDTO dto) {
		String pass = userMapper.find_password_email(dto);
		return pass;
	}

	@Override
	public boolean modifyPwd(UserDTO user) {
		user.encodePassword(passwordEncoder);
		return userMapper.modifyPwd(user) == 1;
	}

	public String getKakaoAccessToken(String authorizeCode) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=bbee380452a4341a2b39cba2ef0bdefe");
			sb.append("&redirect_uri=http://localhost:8080/kakao/oauth");
			sb.append("&code=" + authorizeCode);
			bw.write(sb.toString());
			bw.flush();

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);

			br.close();
			bw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return access_Token;
	}

	public HashMap<String, Object> getKakaoUserInfo(String accessToken) {

		HashMap<String, Object> userInfo = new HashMap<>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");

			conn.setRequestProperty("Authorization", "Bearer " + accessToken);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

			String id = element.getAsJsonObject().get("id").getAsString();
			String email = kakao_account.getAsJsonObject().get("email").getAsString();

			userInfo.put("id", id);
			userInfo.put("email", email);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return userInfo;
	}

	@Override
	public String getNaverAccessToken(String code, String state) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://nid.naver.com/oauth2.0/token";

		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=ukX6QVXRUc7_8u8KKks7");
			sb.append("&client_secret=NZCoKfRwfm");
			sb.append("&code=" + code);
			sb.append("&state=" + state);

			bw.write(sb.toString());
			bw.flush();

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);

			br.close();
			bw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return access_Token;
	}

	public HashMap<String, Object> getNaverUserInfo(String accessToken) {

		HashMap<String, Object> userInfo = new HashMap<>();
		String reqURL = "https://openapi.naver.com/v1/nid/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");

			conn.setRequestProperty("Authorization", "Bearer " + accessToken);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			JsonObject response = element.getAsJsonObject().get("response").getAsJsonObject();

			String id = response.getAsJsonObject().get("id").getAsString();
			String email = response.getAsJsonObject().get("email").getAsString();

			userInfo.put("id", id);
			userInfo.put("email", email);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return userInfo;
	}

	@Override
	public String getGoogleAccessToken(String code) {
		String access_Token = "";
		String reqURL = "https://oauth2.googleapis.com/token";

		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=316214908433-1li7s1krvf7l2m5t5c832b1uol43p6pc.apps.googleusercontent.com");
			sb.append("&client_secret=2oy4Y2EhS4Wz9YoiptdI8WIU");
			sb.append("&code=" + code);
			sb.append("&redirect_uri=http://localhost:8080/google/oauth");

			bw.write(sb.toString());
			bw.flush();

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			access_Token = element.getAsJsonObject().get("id_token").getAsString();

			System.out.println("access_token : " + access_Token);

			br.close();
			bw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return access_Token;
	}

	@Override
	public HashMap<String, Object> getGoogleUserInfo(String accessToken) {

		HashMap<String, Object> userInfo = new HashMap<>();

		String reqURL = "https://oauth2.googleapis.com/tokeninfo";

		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("id_token=" + accessToken);

			bw.write(sb.toString());
			bw.flush();

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			String id = element.getAsJsonObject().get("kid").getAsString();
			String email = element.getAsJsonObject().get("email").getAsString();

			userInfo.put("id", id);
			userInfo.put("email", email);

			br.close();
			bw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return userInfo;

	}

	@Override
	public boolean duplicateCheck(String email) {
		return userMapper.emailChk(email) == 1;
	}

	@Override
	public boolean findUserByEmailNickname(UserDTO user) {
		return userMapper.findUserByEmailNickname(user) == 1;
	}

//	@Async
//	@Override
//	public void asyncService() {
//		System.out.println("Async service is called");
//	}
}
