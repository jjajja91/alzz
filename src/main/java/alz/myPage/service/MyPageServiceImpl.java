package alz.myPage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import alz.board.domain.BoardDTO;
import alz.board.domain.CommentDTO;
import alz.lesson.domain.LessonDTO;
import alz.myPage.domain.MyPageCriteria;
import alz.myPage.mapper.MyPageMapper;
import alz.user.domain.UserDTO;
import alz.user.domain.UserStateDTO;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MyPageServiceImpl implements MyPageService {

	private MyPageMapper myPageMapper;
	private PasswordEncoder passwordEncoder;

	@Autowired
	public MyPageServiceImpl(MyPageMapper myPageMapper, PasswordEncoder passwordEncoder) {
		this.myPageMapper = myPageMapper;
		this.passwordEncoder = passwordEncoder;
	}


	@Override
	public BoardDTO readById(Long id) {
		BoardDTO searchBoardWriter = myPageMapper.selectById(id);
		return searchBoardWriter;
	}

	@Override
	public List<BoardDTO> readAll() {
		List<BoardDTO> myPageList = myPageMapper.selectAll();
		return myPageList;
	}

	//내가 쓴 글 불러오기
	@Override
	public List<BoardDTO> readAll(MyPageCriteria cri) {
		List<BoardDTO> list = myPageMapper.selectWithPaging(cri);
		return list;
	}
	
	//내 댓글 불러오기
	@Override
	public List<CommentDTO> commentReadAll(MyPageCriteria cri) {
		List<CommentDTO> list = myPageMapper.commentSelectWithPaging(cri);
		return list;
	}
	
	//like 불러오기
	@Override
	public List<BoardDTO> likeReadAll(MyPageCriteria cri) {
		List<BoardDTO> list = myPageMapper.likeSelectAll(cri);
		return list;
	}


	@Override
	public int getTotal(MyPageCriteria cri) {
		int total = myPageMapper.getTotalCount(cri);
		return total;
	}

    //탈퇴 전 비밀번호 확인 
	@Override
	public boolean selectById(UserDTO user) {
		UserDTO pwdChk = myPageMapper.selectByUserId(user);
				
		return passwordEncoder.matches(user.getPassword(),pwdChk.getPassword());
	}

	//탈퇴
	@Transactional
	@Override
	public int deleteAcc(UserDTO user) {
		int deleteAcc = 0;
		UserStateDTO userState = new UserStateDTO();
		userState.setUserId(user.getId()).setDescription(user.getDescription());
		deleteAcc += myPageMapper.deleteAcc(userState);
		deleteAcc += myPageMapper.updateEnable(user.getId());
		return deleteAcc;
	}

	//내 강의 목록
	@Override
	public List<LessonDTO> myLessonList(MyPageCriteria cri) {
		List<LessonDTO> list = myPageMapper.myLessonList(cri);
		
		return list;
	}


	@Override
	public List<LessonDTO> finishedLessonList(MyPageCriteria cri) {
		List<LessonDTO> list = myPageMapper.finishedLessonList(cri);
		return list;
	}


	@Override
	public List<LessonDTO> refundedLesson(MyPageCriteria cri) {
		List<LessonDTO> list = myPageMapper.refundedLesson(cri);
	
		return list;
	}


	@Override
	public List<CommentDTO> getMyCommentList(MyPageCriteria cri) {
		return myPageMapper.commentSelectWithPaging(cri);
	}


	@Override
	public List<BoardDTO> getMyLikeList(MyPageCriteria cri) {
		return myPageMapper.likeSelectWithPaging(cri);
	}


	@Override
	public Long getMyBoardTotal(MyPageCriteria cri) {
		return myPageMapper.myBoardCnt(cri);
	}


	@Override
	public Long getMyCommentTotal(MyPageCriteria cri) {
		return myPageMapper.myCommentCnt(cri);
	}


	@Override
	public Long getMyLikeTotal(MyPageCriteria cri) {
		return myPageMapper.myLikeCnt(cri);
	}


	@Override
	public int getActiveLessonTotal(MyPageCriteria cri) {
		return myPageMapper.getActiveLessonTotal(cri);
	}


	@Override
	public int getFinishedLessonTotal(MyPageCriteria cri) {
		return myPageMapper.getFinishedLessonTotal(cri);
	}


	@Override
	public int getRefundedLessonTotal(MyPageCriteria cri) {
		return myPageMapper.getRefundedLessonTotal(cri);
	}


	@Override
	public List<LessonDTO> getMyReservLessonList(MyPageCriteria cri) {
		return myPageMapper.reservLessonSelectWithPaging(cri);
	}


	@Override
	public List<LessonDTO> getMyLikeLessonList(MyPageCriteria cri) {
		return myPageMapper.likeLessonSelectWithPaging(cri);
	}


	@Override
	public Long getMyLikeLessonTotal(MyPageCriteria cri) {
		return myPageMapper.getMyLikeLessonTotal(cri);
	}


	@Override
	public Long getMyReservLessonTotal(MyPageCriteria cri) {
		return myPageMapper.getMyReservLessonTotal(cri);
	}

	



}
