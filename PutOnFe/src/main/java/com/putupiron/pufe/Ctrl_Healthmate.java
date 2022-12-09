package com.putupiron.pufe;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.putupiron.pufe.dao.HealthMateDao;
import com.putupiron.pufe.dao.UserDao;
import com.putupiron.pufe.dto.HealthMate_Join;
import com.putupiron.pufe.dto.HealthMate_Post;
import com.putupiron.pufe.dto.User;
import com.putupiron.pufe.vo.MatchCondition;

@RestController
@RequestMapping("/healthmate")
public class Ctrl_Healthmate {
	@Autowired UserDao userDao;
	@Autowired HealthMateDao hMateDao;
	
//	네비게이션 바에 세션의 유저 정보 전송
	public User navBar(HttpSession session) throws Exception {
		String user_email = (String) session.getAttribute("email");
		User user = userDao.selectUser(user_email);
		return user;
	}
	
//	매칭포스트의 요청 수 갱신
	public boolean refreshRequests() {
		try {
			List<HealthMate_Post> posts = hMateDao.postList();
			List<HealthMate_Join> joins = null;
			for(HealthMate_Post post:posts) {
				joins = hMateDao.requestList(post.getPost_no());
				post.setRequests(joins.size());
				if(hMateDao.requests(post)!=1) throw new Exception("요청 수 갱신 에러");
			}
			return true;
		} catch(Exception e) {
			return false;
		}
	}
//	조회 조건 설정
	@GetMapping("/list")
	public ResponseEntity<List<HealthMate_Post>> getList(MatchCondition mc){
		try {
			mc.setDatePeriod(mc.getDateOption()); //생성된 MatchCondition 객체로 날짜, 시간범위 설정
			mc.setTimePeriod(mc.getTimeOption());
			refreshRequests();
			return new ResponseEntity<>(hMateDao.postList(mc),HttpStatus.OK); // 해당 옵션으로 검색된 모든 포스트 전달
		} catch(Exception e) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}
//	자기 포스팅의 요청자 목록
	@GetMapping("/requestlist")
	public ResponseEntity<List<HealthMate_Join>> getRequestList(Integer post_no){
		try {
			refreshRequests();
			return new ResponseEntity<>(hMateDao.requestList(post_no),HttpStatus.OK);
		} catch(Exception e) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}
//	매칭 포스팅
	@PostMapping(value="/post", produces="application/text;charset=utf-8")
	public ResponseEntity<String> post(@RequestBody HealthMate_Post hmp, HttpSession session) {
		try {
			User user = navBar(session);
			hmp.setPoster(user.getUser_email());
			hmp.setPoster_name(user.getUser_name());
			hmp.setPoster_gender(user.getGender());
			hmp.setPoster_big3(user.getSquat()+user.getBenchpress()+user.getDeadlift()); //날짜, 시간, 파트만 선언되어있는 Post객체에 세션유저정보 저장
			if(hMateDao.post(hmp)!=1) throw new Exception("post 에러");
			refreshRequests();
			return new ResponseEntity<>("매칭을 등록했습니다.",HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
	}
//	포스팅 or 요청 삭제
	@DeleteMapping(value= "/delete", produces="application/text;charset=utf-8")
	public ResponseEntity<String> delete(Integer post_no, Integer join_no){
		try {
			if(post_no!=null) if(hMateDao.deletePost(post_no)!=1) throw new Exception("에러가 발생했습니다.");
			if(join_no!=null) if(hMateDao.requestCancel(join_no)!=1) throw new Exception("에러가 발생했습니다.");
			refreshRequests();
			return new ResponseEntity<>("삭제했습니다.",HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
	}
//	매칭 요청
	@PostMapping(value= "/request", produces="application/text;charset=utf-8")
	public ResponseEntity<String> request(@RequestBody HealthMate_Join hmj, HttpSession session){
		try {
			User user = navBar(session);
			for(HealthMate_Join r : hMateDao.requestList(hmj.getPost_no()))
				if(r.getRequester().equals(user.getUser_email())) throw new Exception("이미 요청한 포스트입니다.");
			hmj.setRequester(user.getUser_email());
			hmj.setReq_name(user.getUser_name());
			hmj.setReq_gender(user.getGender());
			hmj.setReq_big3(user.getSquat()+user.getBenchpress()+user.getDeadlift()); //포스트 번호만 들어있는 Join객체에 세션유저 정보 저장
			if(hMateDao.request(hmj)!=1) throw new Exception("요청에 실패했습니다.");
			refreshRequests();
			return new ResponseEntity<>("요청을 등록했습니다.",HttpStatus.OK);
		} catch(Exception e) {
			return new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
	}
//	매칭 확정
	@PatchMapping(value="/confirm", produces="application/text;charset=utf-8")
	public ResponseEntity<String> confirm(@RequestBody HealthMate_Join hmj){
		try {
			if(hMateDao.confirm(hmj)!=1) throw new Exception("confirm 에러");
			if(hMateDao.joinStatus(hmj.getJoin_no())!=1) throw new Exception("status 갱신 에러");
			hMateDao.deleteAllRequestsOfConfirmedPost(hmj.getPost_no());
			refreshRequests();
			return new ResponseEntity<>("매칭이 성사됐습니다. 이외의 요청들은 전부 삭제됩니다.",HttpStatus.OK);
		} catch(Exception e) {
			return new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
	}
}
