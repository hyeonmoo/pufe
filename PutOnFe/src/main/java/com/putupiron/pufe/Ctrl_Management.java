package com.putupiron.pufe;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.putupiron.pufe.dao.UserDao;
import com.putupiron.pufe.dto.BigThree;
import com.putupiron.pufe.dto.User;

@Controller
@RequestMapping("/manage")
public class Ctrl_Management {
	@Autowired UserDao userDao;
	
//	네비게이션 바에 세션의 유저 정보 전송
	public User navBar(HttpSession session, Model m) throws Exception {
		String user_email = (String)session.getAttribute("email");
		User user = userDao.selectUser(user_email);
		m.addAttribute("user",user);
		return user;
	}
	
//	관리자-회원3대기록변경
	@PostMapping("/editBig3")
	public String admin_editBig3(BigThree big3, String viewType, HttpSession session, Model m, RedirectAttributes ras) throws Exception{
		navBar(session,m);
		if(big3.getSquat()==null) big3.setSquat(0);
		if(big3.getBenchpress()==null) big3.setBenchpress(0);
		if(big3.getDeadlift()==null) big3.setDeadlift(0);
		if(userDao.big3Edit(big3)!=1) ras.addFlashAttribute("msg","알 수 없는 이유로 변경에 실패했습니다.");
		if(viewType==null) viewType="user";
		return "redirect:/menu1?viewType="+viewType;
	}
//	관리자-회원유형변경
	@PostMapping("/editType")
	public String admin_editType(String userType, String user_email, String viewType, HttpSession session, Model m, RedirectAttributes ras) throws Exception{
		navBar(session,m);
		if(userDao.changeUserType(user_email, userType)!=1) ras.addFlashAttribute("msg","알 수 없는 이유로 변경에 실패했습니다.");
		if(viewType==null) viewType="user";
		return "redirect:/menu1?viewType="+viewType;
	}
//	관리자-전담PT변경
	@PostMapping("/editTrainer")
	public String admin_editPT(String user_email, String changeTrainer, HttpSession session, Model m, RedirectAttributes ras) throws Exception{
		navBar(session,m);
		if(userDao.changeTrainer(user_email, changeTrainer)!=1) ras.addFlashAttribute("msg","알 수 없는 이유로 변경에 실패했습니다.");
		return "redirect:/menu1?viewType=user";
	}
}
