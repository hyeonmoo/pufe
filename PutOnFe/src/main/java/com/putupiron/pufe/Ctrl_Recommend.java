package com.putupiron.pufe;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.putupiron.pufe.dao.RecommendDao;
import com.putupiron.pufe.dao.UserDao;
import com.putupiron.pufe.dto.Recommend;
import com.putupiron.pufe.dto.User;
import com.putupiron.pufe.vo.SearchCondition;

@Controller
@RequestMapping("/recommend")
public class Ctrl_Recommend {
	@Autowired UserDao userDao;
	@Autowired RecommendDao recDao;
	
//	네비게이션 바에 세션의 유저 정보 전송
	public User navBar(HttpSession session, Model m, HttpServletRequest hsReq) throws Exception {
		String user_email = (String)session.getAttribute("email");
		User user = userDao.selectUser(user_email);
		m.addAttribute("user",user);
		m.addAttribute("lastPage","?toURL="+hsReq.getServletPath());
		return user;
	}
	
//	게시물 읽기
	@GetMapping("/read")
	public String read(Integer rec_num, SearchCondition sc, HttpSession session, Model m, HttpServletRequest hsReq) {
		try {
			navBar(session,m,hsReq);
			Recommend recommend=recDao.read(rec_num);
			m.addAttribute("recommend",recommend);
			m.addAttribute("mode","read");
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/recommend"+sc.getQueryString();
		}
		return "board_recommend";
	}
	
//	게시물 쓰기 페이지 이동
	@GetMapping("/write")
	public String write(HttpSession session, Model m, HttpServletRequest hsReq) throws Exception {
		User user= navBar(session,m,hsReq);
		if(user==null) return "redirect:/login";
		m.addAttribute("mode","write");
		return "board_recommend";
	}
	
//	게시물 등록 버튼
	@PostMapping("/write")
	public String save(Recommend recommend, Model m, HttpSession session, RedirectAttributes ras) {
		try {
			String user_email = (String)session.getAttribute("email");
			recommend.setUser_email(user_email);
			int rowCnt=recDao.write(recommend);
			if(rowCnt!=1) throw new Exception("Write Error");
			ras.addFlashAttribute("msg","write_success");
			return "redirect:/recommend";
		} catch(Exception e) {
			e.printStackTrace();
			m.addAttribute("recommend", recommend);
			m.addAttribute("msg", "write_error");
			return "board_recommend";
		}
	}
	
//	게시물 수정 버튼
	@PostMapping("/modify")
	public String modify(SearchCondition sc, RedirectAttributes ras, Recommend recommend, HttpSession session, Model m) {
		try {
			String user_email = (String)session.getAttribute("email");
			recommend.setUser_email(user_email);
			int rowCnt = recDao.modify(recommend);
			if(rowCnt!=1) throw new Exception("modify Error");
			ras.addFlashAttribute("msg","modify_success");
			return "redirect:/recommend"+sc.getQueryString();
		} catch(Exception e) {
			e.printStackTrace();
			m.addAttribute("recommend",recommend);
			m.addAttribute("msg","modify_error");
			return "board_recommend";
		}
	}
	
//	게시물 삭제 버튼
	@PostMapping("/remove")
	public String remove(Integer rec_num, SearchCondition sc, Model m, HttpSession session, RedirectAttributes ras) {
		try {
			String user_email = (String)session.getAttribute("email");
			
			int rowCnt=recDao.remove(rec_num, user_email);
			if(rowCnt==1) {
				ras.addFlashAttribute("msg","del");
				return "redirect:/recommend"+sc.getQueryString();
			} else throw new Exception("board remove error");
		} catch(Exception e) {
			e.printStackTrace();
			ras.addFlashAttribute("msg","error");
		}
		return "redirect:/recommend"+sc.getQueryString();
	}
}
