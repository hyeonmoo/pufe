package com.putupiron.pufe.dao;

import java.util.List;

import com.putupiron.pufe.dto.PTReserv;

public interface PTDao {
	// 유저 타입(일반,트레이너)에 따른 조건으로 트레이너의 예약 리스트 조회
	List<PTReserv> reservList(String email,String user_type) throws Exception;
	// 세션 유저의 예약 리스트 조회
	List<PTReserv> userBookList(String email) throws Exception;
	// 해당 예약번호의 예약정보 조회
	PTReserv getRezInfoByNo(Integer pt_no) throws Exception;
	// PT예약신청
	int reserve(PTReserv ptr) throws Exception;
	// 트레이너의 휴무 등록
	int disable(PTReserv ptr) throws Exception;
	// PT예약일정 취소
	int cancel(Integer pt_no) throws Exception;
	// PT예약일정 변경
	int update(PTReserv ptr) throws Exception;
	// 요청 상태의 예약 확정
	int confirm(Integer pt_no) throws Exception;
	// 확정된 예약시간이 지나면 해당 유저의 PT가능횟수를 1회 차감
	int decBookableNum();
	// 요청 상태로 만료된 일정 삭제
	int deleteExpiredRequest();
}