package com.putupiron.pufe;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.putupiron.pufe.dao.UserDao;
import com.putupiron.pufe.dto.HealthMate_Post;
import com.putupiron.pufe.dto.User;

@Controller
@RequestMapping("/healthmate")
public class Ctrl_Healthmate {
	@Autowired UserDao userDao;
	
//	네비게이션 바에 세션의 유저 정보 전송
	public User navBar(HttpSession session, Model m) throws Exception {
		String user_email = (String) session.getAttribute("email");
		User user = userDao.selectUser(user_email);
		m.addAttribute("user", user);
		return user;
	}
	

}
