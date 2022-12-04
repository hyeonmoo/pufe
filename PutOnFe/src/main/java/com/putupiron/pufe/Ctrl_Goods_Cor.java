package com.putupiron.pufe;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.putupiron.pufe.dao.GoodsDao;
import com.putupiron.pufe.dao.UserDao;
import com.putupiron.pufe.dto.Goods;
import com.putupiron.pufe.dto.User;
import com.putupiron.pufe.vo.SearchCondition;

@Controller
@RequestMapping("/correction")
public class Ctrl_Goods_Cor { 
	@Autowired GoodsDao goodsDao;
	@Autowired UserDao userDao;
	
	public User navBar(HttpSession session, Model m) throws Exception {
		String user_email = (String)session.getAttribute("email");
		User user = userDao.selectUser(user_email);
		m.addAttribute("user",user);
		return user;
	}
	
	@GetMapping()
	public String goods_cor(SearchCondition sc, HttpSession session, Model m) throws Exception {
		
		User user = navBar(session, m);
		
		if (user == null)
			return "redirect:/login";
		String user_type = user.getUser_type();
		if (!user_type.equals("A"))
			return "redirect:/login";
		
		m.addAttribute("goodsList", goodsDao.Goodscor());
		

		return "goods_read";
	}

//	게시물 등록 버튼
	@PostMapping("/write")
	public String save(Goods goods, Model m, HttpSession session, RedirectAttributes ras) {
		try {
			
			int rowCnt=goodsDao.write(goods);
			if(rowCnt!=1) throw new Exception("Write Error");
			ras.addFlashAttribute("msg","write_success");
			return "redirect:/correction";
		} catch(Exception e) {
			e.printStackTrace();
			
			m.addAttribute("msg", "write_error");
			return "goods_read";
		}
	}
	

	@ResponseBody
	@PostMapping("/modify")
	public String modify(SearchCondition sc, RedirectAttributes ras,  HttpSession session, Model m, Goods goods) throws Exception {
	
		if(goodsDao.modifygoods(goods)!=1) ras.addFlashAttribute("msg","알 수 없는 이유로 변경에 실패했습니다.");
		return "redirect:/correction";
	}
	
	@PostMapping("/remove")
	public String remove(Integer goods_no, SearchCondition sc, Model m, HttpSession session, RedirectAttributes ras) {
		try {
		
			
			int rowCnt=goodsDao.remove(goods_no);
			if(rowCnt==1) {
				ras.addFlashAttribute("msg","del");
				return "redirect:/correction";
			} else throw new Exception("board remove error");
		} catch(Exception e) {
			e.printStackTrace();
			ras.addFlashAttribute("msg","error");
		}
		return "redirect:/correction";
	}
	
}