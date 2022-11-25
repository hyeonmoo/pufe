package com.putupiron.pufe.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.putupiron.pufe.dto.PTReserv;

@Repository
public class PTDao_imp implements PTDao {
	@Autowired
	SqlSession session;
	String namespace="com.putupiron.pt.";
	
	@Override
	public List<PTReserv> reservList(String email, String user_type) throws Exception{
		Map<String,String> map = new HashMap<>();
		map.put("email", email);
		map.put("user_type", user_type);
		return session.selectList(namespace+"reservList",map);
	}
	@Override
	public List<PTReserv> userBookList(String email) throws Exception {
		return session.selectList(namespace+"userBookList",email);
	}
	@Override
	public Map<String, Object> ptDateTime(Integer pt_no) throws Exception {
		String dateTime = session.selectOne(namespace+"ptDateTime",pt_no);
		Map<String, Object> map = new HashMap<>();
		map.put("pt_date", dateTime.split("_")[0]);
		map.put("pt_time", dateTime.split("_")[1]);
		return map;
	}
	@Override
	public int reserve(PTReserv ptr) throws Exception{
		return session.insert(namespace+"reserve",ptr);
	}
	@Override
	public int disable(PTReserv ptr) throws Exception{
		return session.insert(namespace+"disable",ptr);
	}
	@Override
	public int cancel(Integer pt_no) throws Exception{
		return session.delete(namespace+"cancel",pt_no);
	}
	@Override
	public int update(PTReserv ptr) throws Exception{
		return session.update(namespace+"update",ptr);
	}
	@Override
	public int confirm(Integer pt_no) throws Exception {
		return session.update(namespace+"confirm",pt_no);
	}
}
