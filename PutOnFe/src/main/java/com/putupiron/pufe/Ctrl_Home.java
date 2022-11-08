package com.putupiron.pufe;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Ctrl_Home {
	@Autowired UserDao userDao;
	
	@GetMapping("/")
	public String home(HttpSession session, Model m) throws Exception{
		String user_email = (String)session.getAttribute("email");
		User user = userDao.selectUser(user_email);
		m.addAttribute("user", user);
		return "index";
	}
}
