package alz.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import alz.admin.domain.BoardCriteriaAdmin;
import alz.admin.domain.BoardPageDTOAdmin;
import alz.admin.service.BoardServiceAdmin;
import alz.board.domain.BoardCriteria;
import alz.board.domain.BoardDTO;
import alz.board.service.BoardService;
import lombok.extern.log4j.Log4j;

	@Controller
	@Log4j
	@RequestMapping("/admin/board/*")
	public class BoardAdminController {
	

		private BoardServiceAdmin boardServiceAdmin;
		private BoardService boardService;
		

		@Autowired
		public BoardAdminController(BoardServiceAdmin boardServiceAdmin, BoardService boardService) {
					this.boardServiceAdmin = boardServiceAdmin;
					this.boardService = boardService;
		}

		@GetMapping("/boardAdminList")
		public void boardAdminList(BoardCriteriaAdmin cri, Model model) {
			
			   model.addAttribute("list", boardServiceAdmin.readAll(cri));
				int total = boardServiceAdmin.getTotal(cri);
					// 페이징
				model.addAttribute("pageMaker", new BoardPageDTOAdmin(cri, total));
		}
		

		@GetMapping("/boardDeletedListAdmin")
		public void boardDeletedList(BoardCriteriaAdmin cri, Model model) {
			
			   model.addAttribute("list", boardServiceAdmin.readDeletedAll(cri));
				int total = boardServiceAdmin.getTotal(cri);
					// 페이징
				model.addAttribute("pageMaker", new BoardPageDTOAdmin(cri, total));
		}
		
		@GetMapping("/boardReadAdmin")
		public void read(@RequestParam("id") Long id, @ModelAttribute("cri") BoardCriteria cri, Model model) {
				BoardDTO board = boardService.readById(id);
				if(board.getTypeId()==4) {		
			board = boardService.readReview(board);
			}
			model.addAttribute("board", board);
			}
		
		
		
		
	}


