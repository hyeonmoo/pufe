package com.putupiron.pufe;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	//파일을 취급할 경로 설정
	public static final String PATH ="C:\\SpringProjects\\resources\\pufe\\imgs";
	
	//세션정보와 이전 페이지 정보 저장
	public User navBar(HttpSession session, Model m) throws Exception {
		String user_email = (String)session.getAttribute("email");
		User user = userDao.selectUser(user_email);
		if(user==null || !user.getUser_type().equals("A")) throw new Exception("관리자 전용 페이지입니다.");
		m.addAttribute("user",user);
		return user;
	}
	//관리자-시설관리 게시물 조회
	@GetMapping("/read")
	public String read(Integer mch_num, SearchCondition sc, HttpSession session, Model m, RedirectAttributes ras) {
		try {
			navBar(session,m);
			Machine machine=machineDao.read(mch_num);
			m.addAttribute("machine",machine);
			m.addAttribute("mode","read");
		} catch (Exception e) {
			ras.addFlashAttribute("msg",e.getMessage());
			return "redirect:/menu2"+sc.getQueryString();
		}
		return "machineRead";
	}
	
	@GetMapping("/write")
	public String write(Integer mch_num, String mode, HttpSession session, Model m) throws Exception {
		navBar(session,m);
		if(mch_num!=null) {
			Machine machine=machineDao.read(mch_num);
			m.addAttribute("machine",machine);
		}
		m.addAttribute("mode",mode);
		return "machineRegist";
	}
	
	@PostMapping("/write")
	public String save(Machine machine,String fileName, MultipartFile uploadFile, Model m, HttpSession session, RedirectAttributes ras) {
		try {
			navBar(session,m);
			String uploadFileName = uploadFile.getOriginalFilename();
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1); // 경로가 있다면 원래 이름만 가져올 수 있도록
			if(uploadFileName!="") {
				UUID uuid = UUID.randomUUID();
				uploadFileName = uuid.toString()+"_"+uploadFileName;
				File saveFile = new File(PATH, uploadFileName);
				uploadFile.transferTo(saveFile); // 스프링에서 제공하는 파일 객체를 자바 파일 객체로 변환
				machine.setMch_img(uploadFileName);
			}
			int rowCnt=machineDao.write(machine);
			if(rowCnt!=1) throw new Exception("작성에 실패했습니다. 다시 시도해주세요.");
			ras.addFlashAttribute("msg","기구가 등록되었습니다.");
			return "redirect:/menu2";
		} catch(Exception e) {
			ras.addAttribute("machine", machine);
			ras.addFlashAttribute("msg",e.getMessage());
			return "redirect:/facility/write";
		}
	}
	@PostMapping("/modify")
	public String modify(Machine machine, SearchCondition sc, String fileName, String imgMode, MultipartFile uploadFile, RedirectAttributes ras, Model m, HttpSession session) throws Exception {
		if(imgMode.equals("original")) {
			Machine mch=machineDao.read(machine.getMch_num());
			machine.setMch_img(mch.getMch_img());
		} else if(imgMode.equals("empty")) {
			machine.setMch_img(null);
		} else {
			// 변경 전 기존 이미지파일 삭제
			String originalFilePath = PATH+"\\"+machineDao.mch_img(machine.getMch_num());
		    File deleteFile = new File(originalFilePath);
		    deleteFile.delete();
		    
		    // 새로운 이미지파일 생성
			String uploadFileName = uploadFile.getOriginalFilename();
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1); // 경로가 있다면 원래 이름만 가져올 수 있도록
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString()+"_"+uploadFileName;
			File saveFile = new File(PATH, uploadFileName);
			try {
				uploadFile.transferTo(saveFile);
				machine.setMch_img(uploadFileName);
			} catch (IllegalStateException | IOException e) {
				throw new Exception("이미지파일 등록 실패");
			}
		}
		try {
			navBar(session,m);
			int rowCnt = machineDao.modify(machine);
			if(rowCnt!=1) throw new Exception("기구정보 수정 실패");
			ras.addFlashAttribute("msg","기구정보 수정 완료");
			return "redirect:/menu2"+sc.getQueryString();
		} catch(Exception e) {
			ras.addFlashAttribute("msg",e.getMessage());
			return "redirect:/facility/write";
		}
	}
	@PostMapping("/remove")
	public String remove(Integer mch_num, SearchCondition sc, Model m, HttpSession session, RedirectAttributes ras,String fileName, MultipartFile uploadFile) {
		try {
			navBar(session,m);
			String uploadFileName ="\\"+machineDao.mch_img(mch_num);
			String filePath = PATH+uploadFileName;
		    File deleteFile = new File(filePath);
		    deleteFile.delete();
			int rowCnt=machineDao.remove(mch_num);
			if(rowCnt!=1) throw new Exception("기구정보 삭제 실패");
			ras.addFlashAttribute("msg","기구정보가 삭제되었습니다.");
			return "redirect:/menu2"+sc.getQueryString();
		} catch(Exception e) {
			ras.addFlashAttribute("msg",e.getMessage());
			return "redirect:/facility/write";
		}
	}
}
