package com.putupiron.pufe;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.putupiron.pufe.dao.Rec_CommentService;
import com.putupiron.pufe.dao.UserDao;
import com.putupiron.pufe.dto.Rec_Comment;
import com.putupiron.pufe.dto.User;

@Controller
public class Ctrl_Rec_Comment {

	@Autowired Rec_CommentService service;
	@Autowired UserDao userDao;
	
	// 세션의 유저정보 로드
	public User navBar(HttpSession session) throws Exception {
		String user_email = (String)session.getAttribute("email");
		User user = userDao.selectUser(user_email);
		return user;
	}
	// 지정된 게시물의 모든 댓글을 가져오는 메서드
	@ResponseBody
	@GetMapping("/comments")
	public ResponseEntity<List<Rec_Comment>> list(Integer rec_num) {
		List<Rec_Comment> list = null;
		try {
			list = service.getList(rec_num);
			return new ResponseEntity<List<Rec_Comment>>(list, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<List<Rec_Comment>>(list, HttpStatus.BAD_REQUEST);
		}
	}
	// 댓글을 등록하는 메서드
	@ResponseBody
	@PostMapping(value="/comments", produces="application/text;charset=utf-8")
	public ResponseEntity<String> write(@RequestBody Rec_Comment dto, Integer rec_num, HttpSession session) {
		try {
			User user = navBar(session);
			dto.setUser_email(user.getUser_email());
			dto.setRec_num(rec_num);
			int cnt = service.write(dto);
			if (cnt != 1) throw new Exception("댓글 등록에 실패했습니다.");
			return new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
	}

	// 지정된 댓글을 삭제하는 메서드
	@ResponseBody
	@DeleteMapping(value="/comments/{rec_com_num}", produces="application/text;charset=utf-8")
	public ResponseEntity<String> remove(@PathVariable Integer rec_com_num, Integer rec_num, HttpSession session) {
		try {
			User user = navBar(session);
			int rowCnt = service.remove(rec_com_num, rec_num, user.getUser_email());
			if (rowCnt != 1) {
				throw new Exception("댓글 삭제 실패");
			}
			return new ResponseEntity<>("댓글을 삭제했습니다.", HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

	}
}
