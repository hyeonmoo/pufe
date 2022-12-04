package com.putupiron.pufe.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.putupiron.pufe.dto.HealthMate_Join;
import com.putupiron.pufe.dto.HealthMate_Post;
import com.putupiron.pufe.vo.MatchCondition;
import com.putupiron.pufe.vo.MyMatch;

@Repository
public class HealthMateDao_imp implements HealthMateDao {
	@Autowired SqlSession session;
	String namespace="com.putupiron.healthmate.";
	
//	포스팅된 모든 항목 조회
	@Override
	public List<HealthMate_Post> postList(){
		MatchCondition mc = new MatchCondition();
		mc.setPart("all");
		mc.setDatePeriod("all");
		mc.setTimePeriod("all");
		return postList(mc);
	}
//	날짜, 시간, 파트 선택 시 매칭
	@Override
	public List<HealthMate_Post> postList(MatchCondition mc){
		return session.selectList(namespace+"postList", mc);
	}
	//	매칭 요청시 포스트의 매칭 요청 수 갱신
	@Override
	public int requests(HealthMate_Post hmp) {
		return session.update(namespace+"requests",hmp);
	}
//	매칭 등록
	@Override
	public int post(HealthMate_Post hmp) {
		return session.insert(namespace+"post",hmp);
	}
//	매칭 요청
	@Override
	public int request(HealthMate_Join hmj) {
		return session.insert(namespace+"request",hmj);
	}
//	매칭 요청 취소
	@Override
	public int deletePost(int post_no) {
		return session.delete(namespace+"deletePost",post_no);
	}
	@Override
	public int requestCancel(int join_no) {
		return session.delete(namespace+"requestCancel",join_no);
	}
//	매칭 요청 목록
	@Override
	public List<HealthMate_Join> requestList(int post_no){
		return session.selectList(namespace+"requestList",post_no);
	}
//	내 포스팅 목록
	@Override
	public List<HealthMate_Post> myPosts(String poster) {
		return session.selectList(namespace+"myPost",poster);
	}
//	내 요청 목록
	@Override
	public List<HealthMate_Join> myRequests(String requester) {
		return session.selectList(namespace+"myRequest",requester);
	}
//	매칭 요청 확정 - 파트너 이메일 넣기
	@Override
	public int confirm(HealthMate_Join hmj) {
		return session.update(namespace+"confirm",hmj);
	}
//	매칭 요청 확정 - 요청상태 변경
	@Override
	public int joinStatus(int join_no) {
		return session.update(namespace+"joinStatus",join_no);
	}
//	매칭 요청 확정 - 해당 포스트의 다른 모든 요청사항 삭제
	@Override
	public int deleteAllRequestsOfConfirmedPost(int post_no) {
		return session.delete(namespace+"deleteAllRequestsOfConfirmedPost",post_no);
	}
//	해당 유저의 완료된 매칭 조회(시간순)
	@Override
	public List<MyMatch> confirmedPostOfUser(String email) {
		return session.selectList(namespace+"confirmedPostOfUser",email);
	}
//	날짜 만료된 매칭 삭제(시간은 고려X)
	@Override
	public int deleteExpiredMatching() {
		return session.delete(namespace+"deleteExpiredMatching");
	}
}
