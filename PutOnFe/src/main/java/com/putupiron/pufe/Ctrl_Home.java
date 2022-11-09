package com.putupiron.pufe;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.putupiron.pufe.dao.UserDao;
import com.putupiron.pufe.dto.BigThree;
import com.putupiron.pufe.dto.BoardDto;
import com.putupiron.pufe.dto.MachineDto;
import com.putupiron.pufe.dto.User;
import com.putupiron.pufe.service.BoardService;
import com.putupiron.pufe.service.MachineService;

@Controller
public class Ctrl_Home {
	@Autowired UserDao userDao;
	@Autowired BoardService boardService;
	@Autowired MachineService machineService;

//	홈 화면
	@GetMapping("/")
	public String home(HttpSession session, Model m) throws Exception{
		String user_email = (String)session.getAttribute("email");
		User user = userDao.selectUser(user_email);
		Integer user_rank = userDao.userBig3Rank(user_email);
		m.addAttribute("user", user);
		m.addAttribute("rank",user_rank);
		return "index";
	}

//	네비게이션 바에 세션의 유저 정보 전송
	public User navBar(HttpSession session, Model m, HttpServletRequest hsReq) throws Exception {
		String user_email = (String)session.getAttribute("email");
		User user = userDao.selectUser(user_email);
		m.addAttribute("user",user);
		m.addAttribute("lastPage","?toURL="+hsReq.getServletPath());
		return user;
	}
	
//	메뉴버튼1
	@GetMapping("/menu1")
	public String menu1(HttpSession session, Model m, HttpServletRequest hsReq) throws Exception {
		User user = navBar(session,m,hsReq);
		if(user==null) return "login";
		switch(user.getUser_type()) {
		case "U":
			return "menu_user1";
		case "T":
			return "menu_trainer1";
		case "A":
			return "menu_admin1";
		default:
			return "redirect:/login";
		}
	}
//	메뉴버튼2
	@GetMapping("/menu2")
	public String menu2(HttpSession session, Model m, HttpServletRequest hsReq) throws Exception {
		User user = navBar(session,m,hsReq);
		if(user==null) return "login";
		switch(user.getUser_type()) {
		case "U":
			return "menu_user2";
		case "T":
			return "menu_trainer2";
		case "A":
			return "menu_admin2";
		default:
			return "redirect:/login";
		}
	}
//	추천운동정보
	@GetMapping("/recommend")
	public String recommend(SearchCondition sc, HttpSession session, Model m, HttpServletRequest hsReq) throws Exception{
		User user = navBar(session,m,hsReq);
		int totalCnt = boardService.getSearchResultCnt(sc);
		PageHandler pageHandler = new PageHandler(totalCnt, sc);
		
		
		List<BoardDto> list = boardService.getSearchResultPage(sc);
		Date now = new Date();
		m.addAttribute("now", now);
		m.addAttribute("list", list);
		m.addAttribute("ph", pageHandler);
		return "board_recommend";
	}
	
	
	
	
	
	
//	헬스메이트 매칭
	@GetMapping("/matching")
	public String matching(HttpSession session, Model m, HttpServletRequest hsReq) throws Exception{
		User user = navBar(session,m,hsReq);
		return "board_matching";
	}
//	클럽 시설 정보
	@GetMapping("/machines")
	public String machines(HttpSession session, Model m, HttpServletRequest hsReq) throws Exception{
		User user = navBar(session,m,hsReq);
		List<MachineDto> machineList =machineService.getList();
		m.addAttribute("machineList",machineList);
		return "board_machines";
	}
//	Big3 랭킹
	@GetMapping("/bigThree")
	public String big3Rank(HttpSession session, Model m, HttpServletRequest hsReq) throws Exception{
		User user = navBar(session,m,hsReq);
		if(user==null) return "redirect:/login";
		List<BigThree> list = userDao.bigThreeRank();
		m.addAttribute("list",list);
		return "bigThree";
	}
//	오시는 길
	@GetMapping("/road")
	public String road(HttpSession session, Model m, HttpServletRequest hsReq) throws Exception{
		User user = navBar(session,m,hsReq);
		return "road";
	}
//	마이페이지
	@GetMapping("/myPage")
	public String myPage(HttpSession session, Model m, HttpServletRequest hsReq) throws Exception{
		User user = navBar(session,m,hsReq);
		if(user==null) return "redirect:/login";
		return "myPage";
	}
	
	@GetMapping("/test")
	public String test(HttpSession session, Model m, HttpServletRequest hsReq) throws Exception{
		User user = navBar(session,m,hsReq);
		
		return "test";
	}
	

	
}
  