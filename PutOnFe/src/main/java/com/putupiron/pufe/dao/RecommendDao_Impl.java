package com.putupiron.pufe.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.putupiron.pufe.dto.Recommend;
import com.putupiron.pufe.vo.SearchCondition;

@Repository
public class RecommendDao_Impl implements RecommendDao  {
	@Autowired SqlSession session;
	String namespace="com.putupiron.recommend.";
	
	@Override
	public Recommend read(Integer rec_num) throws Exception{
		session.update(namespace+"viewCnt",rec_num);
		return session.selectOne(namespace+"read",rec_num);
	}
	@Override
	public int write(Recommend recommend) throws Exception{
		return session.insert(namespace+"write",recommend);
	}
	@Override
	public int modify(Recommend recommend) throws Exception{
		return session.update(namespace+"modify",recommend);
	}
	@Override
	public int remove(Integer rec_num, String user_email) throws Exception{
		Map<String,Object> map = new HashMap<>();
		map.put("rec_num", rec_num);
		map.put("user_email", user_email);
		return session.delete(namespace+"remove",map);
	}
	@Override
	public List<Recommend> indexrec() throws Exception{
		return session.selectList(namespace+"indexrec") ;
	}
	@Override
	public List<Recommend> search(SearchCondition sc) throws Exception{
		return session.selectList(namespace+"search",sc);
	}
	@Override
	public int searchCnt(SearchCondition sc) throws Exception{
		return session.selectOne(namespace+"searchCnt",sc);
	}
	@Override
	public int updateCommentCnt(Integer rec_num, Integer comment_cnt)throws Exception {
		// TODO Auto-generated method stub
		System.out.println("@@@@@@@@@@@@@@@"+rec_num+"/"+comment_cnt);
		Map map = new HashMap();
    	map.put("comment_cnt", comment_cnt); 
    	map.put("rec_num", rec_num);
    	return session.update(namespace+"updateCommentCnt", map);
	}
}
