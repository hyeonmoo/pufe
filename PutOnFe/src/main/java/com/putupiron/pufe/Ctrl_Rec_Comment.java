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
import com.putupiron.pufe.dto.Rec_Comment;

// @ResponseBody : 이 클래스에 있는 모든 메서드에 적용
// @Controller + @ResponseBody = @RestController
@Controller
public class Ctrl_Rec_Comment {

	@Autowired
	Rec_CommentService service;

	@GetMapping("/rec")
	public String test() {
		return "rec_comment";
	}

	// 댓글을 등록하는 메서드
	@ResponseBody
	@PostMapping(value="/comments")
	public ResponseEntity<String> write(@RequestBody Rec_Comment dto, Integer rec_num, HttpSession session) {
		String user_email = (String) session.getAttribute("email");
		dto.setUser_email(user_email);
		dto.setRec_num(rec_num);
		
		try {
			int cnt = service.write(dto);
			if (cnt != 1)
				throw new Exception("Write Error");
			return new ResponseEntity<>("good", HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>("WRITE_ERR", HttpStatus.BAD_REQUEST);
		}
	}

	// 지정된 댓글을 삭제하는 메서드
	@DeleteMapping("/comments/{rec_com_num}") // comments/1?bno=1085 <- 삭제할 댓글 번호
	@ResponseBody
	public ResponseEntity<String> remove(@PathVariable Integer rec_com_num, Integer rec_num, HttpSession session) {
		String user_email = (String) session.getAttribute("email");
		System.out.println(rec_com_num + "," + rec_num);
		try {
			int rowCnt = service.remove(rec_com_num, rec_num, user_email);
			if (rowCnt != 1) {
				throw new Exception("delete failed");
			}
			return new ResponseEntity<>("good", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("DEL_ERR", HttpStatus.BAD_REQUEST);
		}

	}

	// 지정된 게시물의 모든 댓글을 가져오는 메서드
	@GetMapping("/comments")
	@ResponseBody
	public ResponseEntity<List<Rec_Comment>> list(Integer rec_num) {
		List<Rec_Comment> list = null;
		try {
			list = service.getList(rec_num);
			// 예외가 발생되어도 상태코드가 200번대
			return new ResponseEntity<List<Rec_Comment>>(list, HttpStatus.OK);
		} catch (Exception e) {

			e.printStackTrace();
			return new ResponseEntity<List<Rec_Comment>>(list, HttpStatus.BAD_REQUEST);
		}

	}

}
