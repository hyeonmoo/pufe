package com.putupiron.pufe.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.putupiron.pufe.dto.HealthMate_Join;
import com.putupiron.pufe.dto.HealthMate_Post;

@Repository
public class HealthMateDao_imp {
	@Autowired SqlSession session;
	String namespace="com.putupiron.healthmate.";
	
//	포스팅된 모든 항목 조회
	public List<HealthMate_Post> allPosts(){
		return session.selectList(namespace+"postList");
	}
//	날짜, 시간, 파트 선택 시 매칭
	public List<HealthMate_Post> match(HealthMate_Post hmp){
		return session.selectList(namespace+"match", hmp);
	}
//	매칭 등록
	public int post(HealthMate_Post hmp) {
		return session.insert(namespace+"post",hmp);
	}
//	매칭 요청
	public int request(HealthMate_Join hmj) {
		return session.insert(namespace+"request",hmj);
	}
//	매칭 요청 취소
	public int requestCancel(int join_no) {
		return session.delete(namespace+"requestCancel",join_no);
	}
//	매칭 요청시 포스트의 매칭 요청 수 갱신
	public int requests(HealthMate_Post hmp) {
		return session.update(namespace+"requests",hmp);
	}
//	매칭 요청 목록
	public List<HealthMate_Join> requestList(int post_no){
		return session.selectList(namespace+"requestList",post_no);
	}
}
