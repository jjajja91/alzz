package alz.board.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import alz.board.domain.BoardCriteria;
import alz.board.domain.BoardDTO;
import alz.board.domain.BoardPageDTO;
import alz.board.service.BoardService;
import alz.file.domain.BoardFileDTO;
import alz.user.domain.UserDTO;
import alz.user.exceptions.UnauthorizedException;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
public class BoardPageController {
 
	private BoardService boardService;
	
	@Autowired
	public BoardPageController(BoardService boardService) {
		this.boardService = boardService;
	}
	public UserDTO getLoginUserInfo() {
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication auth = context.getAuthentication();
		UserDTO userInfo = (UserDTO)auth.getPrincipal();
		return userInfo;
	}
  
	//@GetMapping("/list")
	//public void list(Model model) {
	//	model.addAttribute("list", boardService.readAll());
	//}
	
	
	
	// 게시글 삭제
	@PostMapping("/delete")
	public String delete(@RequestParam("id") Long id, @ModelAttribute("cri") BoardCriteria cri, RedirectAttributes rttr) {
		// 파라미터로 받아온 식별자와 로그인한 유저의 식별자 비교
		if(id!=getLoginUserInfo().getId()) { // 다르면
			throw new UnauthorizedException();
		} else {
		// 같으면
			List<BoardFileDTO> fileList = boardService.getFileList(id); // 파일 리스트 불러오고
			// 보드리스트 불러옴
			BoardDTO board =boardService.readById(id);
			// 삭제한 결과가 1이면
			if(boardService.deleteById(id)==1) {
				// 파일 삭제
				deleteFiles(fileList);
				rttr.addFlashAttribute("result", "success");
			}
		
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			
			// 타입아이디(게시판 타입)
			return "redirect:/board/list?typeId=" + board.getTypeId();
		}
	}
	
	
	// 수정
	@PostMapping("/update")
	public String update(@Valid BoardDTO board, @ModelAttribute("cri") BoardCriteria cri, RedirectAttributes rttr,  BindingResult result) {
		
//		// 글쓴 사람 식별자와 로그인한 유저의 식별자가 다를 경우
		if(board.getWriterId()!=getLoginUserInfo().getId()) {
			throw new UnauthorizedException();
		} else {
		// 맞으면 게시글 업데이트
		boardService.update(board.getId(), board);
			
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		// 보드리스트로 돌려보냄
		return "redirect:/board/list";
		}
	}
	
	// 읽기와 수정 동시처리
	@GetMapping( {"/read", "/update" })
	public void read(@RequestParam("id") Long id, @ModelAttribute("cri") BoardCriteria cri, Integer typeId, Model model) {
		cri.setTypeId(typeId);
		model.addAttribute("boardName", boardService.getBoardName(typeId));

		BoardDTO board = boardService.readById(id);
			if(board.getTypeId()==4) {		
		board = boardService.readReview(board);
		}
		model.addAttribute("board", board);
		}
	
	// 리스트
	@GetMapping("/list")
	public void list(Integer typeId, BoardCriteria cri, Model model) {
		
		cri.setTypeId(typeId);
		model.addAttribute("boardName", boardService.getBoardName(typeId));
        model.addAttribute("list", boardService.readAll(cri));

		int total = boardService.getTotal(cri);
		
		// 페이징
		model.addAttribute("pageMaker", new BoardPageDTO(cri, total));
	}
	
	// 작성
	@GetMapping("/write")
	public void write(@RequestParam("typeId") Integer typeId, Model model) {
		if(getLoginUserInfo()==null) {
			throw new UnauthorizedException();
		}
		switch(typeId) {
		case 1:
			if(!(getLoginUserInfo().getRole().equals("ROLE_ADMIN"))) {
				throw new UnauthorizedException();
			}
			break;
		case 2:
			if(!(getLoginUserInfo().getRole().equals("ROLE_ADMIN"))) {
				throw new UnauthorizedException();
			}
			break;
		case 3:
		case 4:
			model.addAttribute("reviewOpt", boardService.reviewOption(getLoginUserInfo().getId())); break;
		case 5:
		}
		model.addAttribute("typeId", typeId);
	}
	
	// 파일 삭제 (아직은 상남자식 방법)
	private void deleteFiles(List<BoardFileDTO> fileList) {
		
		if(fileList == null || fileList.size()==0) {
			return;
		}
		log.info("delete board files.................");
		log.info(fileList);
		
		fileList.forEach(file -> {
			try {
				Path files = Paths.get("C:\\upload\\"+file.getUploadPath()+"\\"+file.getUuid()+"_"+file.getFileName());
				Files.deleteIfExists(files);
				if(Files.probeContentType(files).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\"+file.getUploadPath()+"\\s_"+file.getUuid()+"_"+file.getFileName());
					Files.delete(thumbNail);
				}
			} catch(Exception e) {
				log.error("delete file error" + e.getMessage());
			}
		});
	}
}
