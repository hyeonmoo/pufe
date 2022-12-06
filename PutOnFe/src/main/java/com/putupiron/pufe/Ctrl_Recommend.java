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
		m.addAttribute("lastPage",hsReq.getServletPath());
		return user;
	}
	
//	게시물 읽기
	@GetMapping("/read")
	public String read(Integer rec_num, SearchCondition sc, HttpSession session, Model m, HttpServletRequest hsReq) {
		try {
			User user = navBar(session,m,hsReq);
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
	public String write(HttpSession session, SearchCondition sc, Model m, HttpServletRequest hsReq, RedirectAttributes ras) throws Exception {
		User user= navBar(session,m,hsReq);
		if(user==null) return "redirect:/login";
		if(user.getUser_type().equals("U")) {
			ras.addFlashAttribute("msg","관리자와 트레이너만 작성할 수 있습니다.");
			return "redirect:/recommend"+sc.getQueryString();
		}
		m.addAttribute("mode","write");
		return "board_recommend";
	}
	
//	게시물 등록 버튼
	@PostMapping("/write")
	public String save(Recommend recommend, Model m, HttpSession session, RedirectAttributes ras, HttpServletRequest hsReq) {
		try {
			User user = navBar(session,m,hsReq);
			recommend.setUser_email(user.getUser_email());
			if(user.getUser_type().equals("U")) {
				ras.addFlashAttribute("msg","관리자와 트레이너만 작성할 수 있습니다.");
				return "redirect:/read";
			}
			int rowCnt=recDao.write(recommend);
			if(rowCnt!=1) throw new Exception("게시글 등록에 실패했습니다. 다시 시도해주세요.");
			ras.addFlashAttribute("msg","게시글 등록을 완료했습니다.");
			return "redirect:/recommend";
		} catch(Exception e) {
			ras.addFlashAttribute("recommend", recommend);
			ras.addFlashAttribute("msg", e.getMessage());
			return "redirect:/recommend/write";
		}
	}
	
//	게시물 수정 버튼
	@PostMapping("/modify")
	public String modify(SearchCondition sc, RedirectAttributes ras, Recommend recommend, HttpSession session, Model m, HttpServletRequest hsReq) {
		try {
			User user = navBar(session,m,hsReq);
			recommend.setUser_email(user.getUser_email());
			if(user.getUser_type().equals("U")) {
				ras.addFlashAttribute("msg","관리자와 트레이너만 수정할 수 있습니다.");
				return "redirect:/read";
			}
			int rowCnt = recDao.modify(recommend);
			if(rowCnt!=1) throw new Exception("게시물 수정에 실패했습니다. 다시 시도해주세요.");
			ras.addFlashAttribute("msg","게시물 수정을 완료했습니다.");
			return "redirect:/recommend"+sc.getQueryString();
		} catch(Exception e) {
			ras.addFlashAttribute("recommend", recommend);
			ras.addFlashAttribute("msg", e.getMessage());
			return "redirect:/recommend/write";
		}
	}
	
//	게시물 삭제 버튼
	@PostMapping("/remove")
	public String remove(Integer rec_num, SearchCondition sc, Model m, HttpSession session, RedirectAttributes ras, HttpServletRequest hsReq) {
		try {
			User user = navBar(session,m,hsReq);
			if(user.getUser_type().equals("U"))
				throw new Exception("관리자와 트레이너만 삭제할 수 있습니다.");
			int rowCnt=recDao.remove(rec_num, user.getUser_email());
			if(rowCnt!=1) throw new Exception("게시물 삭제에 실패했습니다.");
			ras.addFlashAttribute("msg","게시물 삭제 완료");
			return "redirect:/recommend"+sc.getQueryString();
		} catch(Exception e) {
			ras.addFlashAttribute("msg",e.getMessage());
			return "redirect:/recommend/read";
		}
	}
}
