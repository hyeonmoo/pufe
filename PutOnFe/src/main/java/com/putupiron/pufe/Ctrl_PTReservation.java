package com.putupiron.pufe;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.putupiron.pufe.dao.PTDao;
import com.putupiron.pufe.dao.UserDao;
import com.putupiron.pufe.dto.PTReserv;
import com.putupiron.pufe.dto.User;

@RestController
@RequestMapping("/pt")
public class Ctrl_PTReservation {
	@Autowired UserDao	userDao;
	@Autowired PTDao	ptDao;
	
//	네비게이션 바에 세션의 유저 정보 전송
	public User navBar(HttpSession session) throws Exception {
		String user_email = (String)session.getAttribute("email");
		User user = userDao.selectUser(user_email);
		return user;
	}
//	예약(확정)하려는 날짜, 시간에 이미 예약확정된 일정이 있는지 검사
	public boolean alreadyBooked(List<PTReserv> ptrList, PTReserv targetRez) {
		for(PTReserv ptr:ptrList) 
			if(ptr.getPt_date().equals(targetRez.getPt_date()) && ptr.getPt_time()==targetRez.getPt_time()) return true;
		return false;
	}
//	PT일정 조회
	@GetMapping()
	public ResponseEntity<Map<String,List<PTReserv>>> listup(HttpSession session){
		try {
			User user = navBar(session);
			Map<String,List<PTReserv>> listMap = new HashMap<>();
			switch(user.getUser_type()) {
			case "U":
				List<PTReserv> ptrList = ptDao.reservList(user.getTrainer(), user.getUser_type());
				List<PTReserv> userBookList = ptDao.userBookList(user.getUser_email());
				listMap.put("bookedList", ptrList);
				listMap.put("userList", userBookList);
				break;
			case "T":
				ptrList = ptDao.reservList(user.getUser_email(), user.getUser_type());
				List<PTReserv> bookedList = new ArrayList<>();
				List<PTReserv> reqedList = new ArrayList<>();
				for(PTReserv ptr : ptrList) {
					if(ptr.getRequest().equals("requested")) reqedList.add(ptr);
					else bookedList.add(ptr); 
				}
				listMap.put("bookedList", bookedList);
				listMap.put("reqedList", reqedList);
				break;
			}
			return new ResponseEntity<>(listMap,HttpStatus.OK);
		} catch(Exception e) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}
	
//	유저-PT예약신청
	@PostMapping(value="/reservation", produces="application/text;charset=utf-8")
	public ResponseEntity<String> reserve(@RequestBody PTReserv newPtr, HttpSession session){
		try{
			User user = navBar(session);
			newPtr.setTrainer_email(user.getTrainer());
			newPtr.setUser_email(user.getUser_email());
			if(ptDao.reserve(newPtr)!=1) throw new Exception("요청 등록 실패");
			return new ResponseEntity<>("신청되었습니다.",HttpStatus.OK);
		} catch(Exception e) {
			return new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
	}
//	트레이너-일정 비활성화
	@PostMapping(value="/disable", produces="application/text;charset=utf-8")
	public ResponseEntity<String> disable(@RequestBody PTReserv ptr, HttpSession session) {
		try {
			User user = navBar(session);
			ptr.setTrainer_email(user.getUser_email());
			if(ptDao.disable(ptr)!=1) throw new Exception("등록에 실패했습니다. 다시 시도해주세요.");
			return new ResponseEntity<>("휴무를 등록했습니다.", HttpStatus.OK);
		} catch(Exception e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
	}
//	트레이너-예약 확정
	@PatchMapping(value="/confirm", produces="application/text;charset=utf-8")
	public ResponseEntity<String> confirm(Integer pt_no, HttpSession session){
		try {
			User user = navBar(session);
			List<PTReserv> ptrList = ptDao.reservList(user.getUser_email(), "U");
			PTReserv targetRez = ptDao.getRezInfoByNo(pt_no); 
			if(alreadyBooked(ptrList,targetRez)) throw new Exception("이미 예약된 시간입니다.");
			if(ptDao.confirm(pt_no)!=1) throw new Exception("확정에 실패했습니다. 다시 시도해주세요.");
			return new ResponseEntity<>("예약을 확정했습니다.",HttpStatus.OK);
		} catch(Exception e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
	}
//	트레이너-예약시간 변경
	@PatchMapping(value="/modify", produces="application/text;charset=utf-8")
	public ResponseEntity<String> modify(@RequestBody PTReserv modData, HttpSession session) {
		try {
			User user = navBar(session);
			List<PTReserv> ptrList= ptDao.reservList(user.getUser_email(), "U");
			if(alreadyBooked(ptrList,modData)) throw new Exception("변경하려는 시간에 이미 예약된 일정이 있습니다.");
			if(ptDao.update(modData)!=1) throw new Exception("변경에 실패했습니다. 다시 시도해주세요.");
			return new ResponseEntity<>("예약을 변경했습니다.",HttpStatus.OK);
		} catch(Exception e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
	}
//	트레이너-예약 취소
	@DeleteMapping(value="/cancel", produces="application/text;charset=utf-8")
	public ResponseEntity<String> cancel(Integer pt_no){
		try {
			if(ptDao.cancel(pt_no)!=1) throw new Exception("예약 취소에 실패했습니다. 다시 시도해주세요.");
			return new ResponseEntity<>("예약을 취소했습니다.",HttpStatus.OK);
		} catch(Exception e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
	}
}
