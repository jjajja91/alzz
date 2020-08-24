package alz.board.mapper;

import alz.board.domain.LikeDTO;

public interface LikeMapper {

	// 좋아요 추가
	void addLike(LikeDTO like);

	// 좋아요 삭제
	int removeLike(LikeDTO likeDTO);

	// 좋아요 얻기(좋아요 여부 확인 후 추가/삭제 이벤트 걸어주기 위함)
	LikeDTO getLike(LikeDTO likeDTO);
	
	

}
