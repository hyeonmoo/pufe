package com.putupiron.pufe;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.putupiron.pufe.dao.MachineDao;
import com.putupiron.pufe.dao.UserDao;
import com.putupiron.pufe.dto.Machine;
import com.putupiron.pufe.dto.User;
import com.putupiron.pufe.vo.SearchCondition;



@Controller
@RequestMapping("/facility")
public class Ctrl_Machine {
	@Autowired UserDao userDao;
	@Autowired MachineDao machineDao;
	
	
	public User navBar(HttpSession session, Model m, HttpServletRequest hsReq) throws Exception {
		String user_email = (String)session.getAttribute("email");
		User user = userDao.selectUser(user_email);
		m.addAttribute("user",user);
		m.addAttribute("lastPage","?toURL="+hsReq.getServletPath());
		return user;
	}
	
	@GetMapping("/read")
	public String read(Integer mch_num, SearchCondition sc, HttpSession session, Model m, HttpServletRequest hsReq) {
		try {
			navBar(session,m,hsReq);
			Machine machine=machineDao.read(mch_num);
			m.addAttribute("machine",machine);
			m.addAttribute("mode","read");
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/facility"+sc.getQueryString();
		}
		return "board_machines_read";
	}
	
	@GetMapping("/write")
	public String write( HttpSession session, Model m, Integer mch_num,HttpServletRequest hsReq) throws Exception {
		User user= navBar(session,m,hsReq);
		if (user == null)
			return "redirect:/login";
		String user_type = user.getUser_type();
		if (!user_type.equals("A"))
			return "redirect:/login";
		if(mch_num!=null) {
		Machine machine=machineDao.read(mch_num);
		m.addAttribute("machine",machine);}
		m.addAttribute("mode","write");
		return "board_machines_regist";
	}
	@PostMapping("/write")
	public String save( Machine machine,String FileName, MultipartFile uploadFile, Model m, HttpSession session, RedirectAttributes ras) {
		String uploadFolder ="C:\\Users\\gkdlk\\git\\pufe\\pufe\\PutOnFe\\src\\main\\webapp\\resources\\img";
			String uploadFileName = uploadFile.getOriginalFilename(); 
			System.out.println("uplodaFileName : "+uploadFileName);
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1); // 경로가 있다면 원래 이름만 가져올 수 있도록
			System.out.println("last file name : " + uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString()+"_"+uploadFileName;
			System.out.println("변환 후 파일이름 "+uploadFileName);
			
			File saveFile = new File(uploadFolder, uploadFileName); 
			try {
				uploadFile.transferTo(saveFile); // 스프링에서 제공하는 파일 객체를 자바 파일 객체로 변환
				machine.setMch_img(uploadFileName);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			} 
		try {
			
			int rowCnt=machineDao.write(machine);
			if(rowCnt!=1) throw new Exception("Write Error");
			ras.addFlashAttribute("msg","write_success");
			return "redirect:/facility";
		} catch(Exception e) {
			e.printStackTrace();
			m.addAttribute("machine", machine);
			m.addAttribute("msg", "write_error");
			return "board_machines_regist";
		}
	}
	@PostMapping("/modify")
	public String modify(SearchCondition sc,String fileName,Integer del, MultipartFile uploadFile, RedirectAttributes ras, Machine machine, Model m, HttpSession session) throws Exception {
		System.out.println("수정 모드 : "+del);
		
		String uploadFolder = "C:\\Users\\gkdlk\\git\\pufe\\pufe\\PutOnFe\\src\\main\\webapp\\resources\\img";

		String str="";

		if(del==1) {
			Machine mch=machineDao.read(machine.getMch_num());
			machine.setMch_img(mch.getMch_img());
		}
		//삭제
		else if(del==3) {
			machine.setMch_img(null);
		}
		else {	
			 // 여러개의 파일일 경우 향상된 for문 이용
				String uploadFileName = uploadFile.getOriginalFilename(); 
				System.out.println("uplodaFileName : "+uploadFileName);
				uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1); // 경로가 있다면 원래 이름만 가져올 수 있도록
				System.out.println("last file name : " + uploadFileName);
				
				UUID uuid = UUID.randomUUID();
				uploadFileName = uuid.toString()+"_"+uploadFileName;
				System.out.println("변환 후 파일이름 "+uploadFileName);
				
				File saveFile = new File(uploadFolder, uploadFileName); //uploadFolder 위치에 uploadFileName으로 생성
				try {
					uploadFile.transferTo(saveFile); // 스프링에서 제공하는 파일 객체를 자바 파일 객체로 변환
					machine.setMch_img(uploadFileName);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				} 
			}
		
		
		
		try {
			
			int rowCnt = machineDao.modify(machine);
			if(rowCnt!=1) throw new Exception("modify Error");
			ras.addFlashAttribute("msg","modify_success");
			return "redirect:/facility"+sc.getQueryString();
		} catch(Exception e) {
			e.printStackTrace();
			m.addAttribute("machine",machine);
			m.addAttribute("msg","modify_error");
			m.addAttribute("m", "renew");
			return "board_machines_regist";
		}
	}
	@PostMapping("/remove")
	public String remove(Integer mch_num, SearchCondition sc, Model m, HttpSession session, RedirectAttributes ras,HttpServletRequest hsReq) {
		try {
			User user= navBar(session,m,hsReq);
			if (user == null)
				return "redirect:/login";
			String user_type = user.getUser_type();
			if (!user_type.equals("A"))
				return "redirect:/login";
			int rowCnt=machineDao.remove(mch_num);
			if(rowCnt==1) {
				ras.addFlashAttribute("msg","del");
				return "redirect:/facility"+sc.getQueryString();
			} else throw new Exception("board remove error");
		} catch(Exception e) {
			e.printStackTrace();
			ras.addFlashAttribute("msg","error");
		}
		return "redirect:/facility"+sc.getQueryString();
	}
}
