package com.putupiron.pufe;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.putupiron.pufe.dao.UserDao;
import com.putupiron.pufe.dto.BoardDto;
import com.putupiron.pufe.dto.User;
import com.putupiron.pufe.service.BoardService;

@Controller
@RequestMapping("/board")
public class Ctrl_Board {
	@Autowired
	BoardService boardService;
	@Autowired UserDao userDao;

	@GetMapping("/list")
	public String list(SearchCondition sc, HttpServletRequest request, Model m,HttpSession session) {
		
		
		if (!loginCheck(request))

			return "redirect:/login?toURL=" + request.getRequestURL();
		try {
			int totalCnt = boardService.getSearchResultCnt(sc);
			PageHandler pageHandler = new PageHandler(totalCnt, sc);
			
			
			List<BoardDto> list = boardService.getSearchResultPage(sc);
			Date now = new Date();
			m.addAttribute("now", now);
			m.addAttribute("list", list);
			
			m.addAttribute("ph", pageHandler);
			String user_email = (String)session.getAttribute("email");
			User user = userDao.selectUser(user_email);
			m.addAttribute("user",user);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "boardList";

	}

	@GetMapping("/read")
	public String read(Integer bno,SearchCondition sc, Model m) {
		try {
			BoardDto boardDto = boardService.read(bno);
			m.addAttribute("boardDto", boardDto);
			m.addAttribute("mode", "read");
		
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/board/list"+sc.getQueryString();
		}
		return "board";

	}

	@PostMapping("/remove")
	public String remove(Integer bno, SearchCondition sc, Model m, HttpSession session,
			RedirectAttributes redatt) {
		
		try {
			String writer = (String) session.getAttribute("email");
			int rowCnt = boardService.remove(bno, writer);
			if (rowCnt == 1) {
				redatt.addFlashAttribute("msg", "del");
				return "redirect:/board/list"+sc.getQueryString();
			} else {
				throw new Exception("board remove error");
			}
		} catch (Exception e) {
			e.printStackTrace();
			redatt.addFlashAttribute("msg", "error");
		}
		return "redirect:/board/list"+sc.getQueryString();
	}

	@GetMapping("/write")
	public String write(Model m) {
		m.addAttribute("mode", "write");
		return "board";
	}

	@PostMapping("/write")
	public String save(BoardDto boardDto, Model m, HttpSession session, RedirectAttributes reatt)  {
		String writer = (String)session.getAttribute("email");
		
		boardDto.setWriter(writer);
		try {
			int rowCnt = boardService.write(boardDto);
			if (rowCnt != 1)
				throw new Exception("Write Error");
			reatt.addFlashAttribute("msg", "write_ok");
			return "redirect:/board/list";

		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute("boardDto", boardDto);
			m.addAttribute("msg", "write_error");
			return "board";
		}

	}
	
	@PostMapping("/modify")
	public String modify(SearchCondition sc,BoardDto boardDto, Model m, HttpSession session, RedirectAttributes reatt) {
		String writer = (String) session.getAttribute("email");
		boardDto.setWriter(writer);
		
		try {
			int rowCnt = boardService.modify(boardDto);
			if (rowCnt != 1)
				throw new Exception("modify Error");
			reatt.addFlashAttribute("msg", "modify_ok");
			
			return "redirect:/board/list"+sc.getQueryString();

		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute("boardDto", boardDto);
			m.addAttribute("msg", "modify_error");
			m.addAttribute("m","renew");
			return "board";
		}

	}
	

	private boolean loginCheck(HttpServletRequest request) {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		
		if (session.getAttribute("email") != null) {
			return true;
		} else {
			return false;
		}
	}
}
