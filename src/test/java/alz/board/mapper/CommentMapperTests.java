package alz.board.mapper;

import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import alz.board.domain.CommentDTO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CommentMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private CommentMapper commentMapper;
	
	@Test
	public void testRead() {
		
		CommentDTO comment = commentMapper.selectById(12L);
		
		log.info(comment);
	}
	
	@Test
	public void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i -> {
			
			CommentDTO comment = new CommentDTO();
			//alz_comment_seq.nextval, 3, '댓글1-1-1-1', 1, 00101010101, 12, 1
			comment.setContent("댓글 1-2-1");
			comment.setCommentCnt(1L);
			comment.setCommentCode("001010201");
			comment.setBoardId(12L);
			
			commentMapper.insert(comment);
		});
	}
	
	@Test
	public void testMapper() {
		log.info(commentMapper);
	}
}
