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
		if(userDao.selectUser(joinData.getUser_email())!=null)
			br.rejectValue("user_email", "해당 이메일로 가입한 계정이 이미 존재합니다.");
		if(userDao.selectByTel(joinData.getUser_tel())!=null)
			br.rejectValue("user_email", "해당 전화번호로 가입한 계정이 이미 존재합니다.");
		if(br.hasErrors()) {
			ras.addFlashAttribute("msg",br.getFieldError().getCode());
			ras.addFlashAttribute("join",joinData); //회원가입 실패 시 기존 데이터 유지(비밀번호 제외)
			return "redirect:/join";
		}
		if(userDao.join(joinData)!=1) {
			ras.addFlashAttribute("msg","알 수 없는 이유로 회원가입에 실패했습니다.");
			ras.addFlashAttribute("join",joinData);
			return "redirect:/join";
		}
		ras.addFlashAttribute("msg","회원가입이 성공적으로 완료됐습니다.");
		return "redirect:login";
	}

	@InitBinder
	public void initbinder(WebDataBinder binder) {
		binder.setValidator(new Validator_join());
	}
}
