package com.putupiron.pufe;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.putupiron.pufe.dao.UserDao;
import com.putupiron.pufe.dto.User;

@Controller
@RequestMapping("/login")
public class Ctrl_Login {
	@Autowired
	UserDao userDao;
	
//	로그인 화면
	@GetMapping()
	public String login_get() {
		return "login";
	}
//	로그인 버튼
	@PostMapping()
	public String login(String email, String pwd, String toURL, boolean remEmail, HttpServletRequest req, HttpServletResponse resp, RedirectAttributes ras) throws Exception{
		if(!loginCheck(email,pwd)) {
			ras.addFlashAttribute("loginCheck","false");
			return "redirect:/login"; // 이메일-비밀번호 확인
		}
		HttpSession session = req.getSession();
		session.setAttribute("email", email); //세션객체에 이메일 저장
		if(remEmail) resp.addCookie(new Cookie("email",email)); //이메일 저장버튼 활성화 시 쿠키에 이메일 저장
		else {
			Cookie cookie = new Cookie("email",email);
			cookie.setMaxAge(0);
			resp.addCookie(cookie);
		}
		if(toURL==null || toURL.equals("")) toURL="/";
		return "redirect:"+toURL;
	}
//	로그인 유효성 체크
	public boolean loginCheck(String email, String pwd) throws Exception{
		User user = userDao.selectUser(email);
		if(user==null) return false;
		return user.getUser_pw().equals(pwd);
	}
//	로그아웃 버튼
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
//	이메일 찾기
	@GetMapping("/findEmail")
	public String findEmail_get() {
		return "findEmail";
	}
//	이메일 찾기 버튼
	@PostMapping("/findEmail")
	public String findEmail(String name, String phone, RedirectAttributes ras) throws Exception{
		String email = userDao.findEmail(name, phone);
		if(email==null) ras.addFlashAttribute("email","해당 정보로 가입된 계정이 없습니다.");
		else ras.addFlashAttribute("email",email);
		return "redirect:/login/findEmail";
	}
//	비밀번호 재설정
	@GetMapping("/resetPw/find")
	public String resetPw_get() {
		return "resetPw_find";
	}
//	비밀번호 재설정-이메일찾기
	@PostMapping("/resetPw/reset")
	public String resetPw_findEmail(String email, String name, String phone, Model m, RedirectAttributes ras) throws Exception {
		String user_email = userDao.findEmail(email, name, phone);
		if(user_email==null) {
			ras.addFlashAttribute("msg","EmailNotExist");
			return "redirect:/login/resetPw/find";
		}
		m.addAttribute("email",user_email);
		return "resetPw_reset";
	}
//	비밀번호 재설정-재설정 화면
	@GetMapping("/resetPw/reset")
	public String resetPw_reset_get() {
		return "resetPw_reset";
	}
//	비밀번호 재설정-재설정 버튼
	@PostMapping("/resetPw/resetComplete")
	public String resetPw_reset(String email, String pwd, String pwd_confirm, RedirectAttributes ras) throws Exception {
		if(!pwd.equals(pwd_confirm)) {
			ras.addFlashAttribute("msg","PwDiscord");
			return "redirect:/login/resetPw/reset";
		}
		int reset=userDao.resetPw(email,pwd);
		if(reset!=1) {
			ras.addFlashAttribute("msg","ResetError");
			return "redirect:/login/resetPw/reset";
		}
		ras.addFlashAttribute("msg","ResetSuccess");
		return "redirect:/login";
	}
}
