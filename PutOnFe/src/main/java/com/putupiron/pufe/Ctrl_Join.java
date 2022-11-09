package com.putupiron.pufe;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.putupiron.pufe.dao.UserDao;
import com.putupiron.pufe.dto.JoinData;
import com.putupiron.pufe.dto.User;
import com.putupiron.pufe.validator.Validator_join;

@Controller
public class Ctrl_Join {
	@Autowired UserDao userDao;
	
	@GetMapping("/join")
	public String join_get() {
		return "join";
	}
	@PostMapping("/join")
	public String join(Model m, @Valid JoinData joinData, BindingResult br, RedirectAttributes ras) throws Exception{
		User user = userDao.selectUser(joinData.getUser_email());
		if(user!=null) br.rejectValue("user_email", "DuplicateEmail");
		if(br.hasErrors()) {
			m.addAttribute("msg",br.getFieldError().getCode());
			return "join";
		}
		int joinResult=userDao.join(joinData);
		if(joinResult!=1) {
			m.addAttribute("msg","JoinFailed");
			return "join";
		}
		ras.addFlashAttribute("msg","JoinSuccess");
		return "redirect:login";
	}

	@InitBinder
	public void initbinder(WebDataBinder binder) {
		binder.setValidator(new Validator_join());
	}
}
