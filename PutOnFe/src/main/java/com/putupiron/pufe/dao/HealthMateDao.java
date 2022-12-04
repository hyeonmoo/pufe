package com.putupiron.pufe.dao;

import java.util.List;

import com.putupiron.pufe.dto.HealthMate_Join;
import com.putupiron.pufe.dto.HealthMate_Post;
import com.putupiron.pufe.vo.MatchCondition;
import com.putupiron.pufe.vo.MyMatch;

public interface HealthMateDao {

//	포스팅된 모든 항목 조회
	List<HealthMate_Post> postList();
//	날짜, 시간, 파트 선택 시 매칭
	List<HealthMate_Post> postList(MatchCondition mc);
//	포스트의 매칭 요청 수 갱신
	int requests(HealthMate_Post hmp);
//	매칭 등록
	int post(HealthMate_Post hmp);
//	매칭 요청
	int request(HealthMate_Join hmj);
//	매칭 취소
	int deletePost(int post_no);
	int requestCancel(int join_no);
//	매칭 요청 목록
	List<HealthMate_Join> requestList(int post_no);	
//	내 포스팅 목록
	List<HealthMate_Post> myPosts(String poster);	
//	내 요청 목록
	List<HealthMate_Join> myRequests(String requester);
//	매칭 요청 확정
	int confirm(HealthMate_Join hmj);
	int joinStatus(int join_no);
	int deleteAllRequestsOfConfirmedPost(int post_no);
//	해당 유저의 완료된 매칭 조회(시간순)
	List<MyMatch> confirmedPostOfUser(String email);
//	날짜 지난 매칭 삭제
	int deleteExpiredMatching();
}