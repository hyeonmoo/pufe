package com.putupiron.pufe;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.putupiron.pufe.dao.GoodsDao;
import com.putupiron.pufe.dao.UserDao;
import com.putupiron.pufe.dto.User;

@Controller
@RequestMapping("/goods")
public class Ctrl_Goods {
	@Autowired UserDao userDao;
	@Autowired GoodsDao goodsDao;
	
//	네비게이션 바에 세션의 유저 정보 전송
	public User navBar(HttpSession session, Model m) throws Exception {
		String user_email = (String)session.getAttribute("email");
		User user = userDao.selectUser(user_email);
		m.addAttribute("user",user);
		return user;
	}
	@GetMapping()
	public String ptOption(String option, HttpSession session, Model m) throws Exception{
		navBar(session, m);
		m.addAttribute(goodsDao.allGoods(option));
		return "menu_user1";
	}
	@PostMapping("/purchase")
	public String purchase(String goods_name,HttpSession session, Model m, RedirectAttributes ras) throws Exception{
		User user= navBar(session,m);
		if(user.getProd_name()!=null) {
			ras.addFlashAttribute("msg","이미 구입한 상품이 존재합니다.");
		} else {
			if(goodsDao.purchase(user.getUser_email(), goods_name)!=1)
				ras.addFlashAttribute("msg","상품 구입에 실패했습니다.");
			else ras.addFlashAttribute("msg","상품 구입이 완료됐습니다.");
		}
		return "redirect:/";
	}
}
