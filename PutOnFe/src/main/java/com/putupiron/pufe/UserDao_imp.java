package com.putupiron.pufe;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao_imp implements UserDao {
	@Autowired
	SqlSession session;
	String namespace="com.putupiron.pufe.";
	
	@Override
	public User selectUser(String user_email) throws Exception{
		return session.selectOne(namespace+"selectUser",user_email);
	}
	@Override
	public int join(JoinData joinData) throws Exception {
		return session.insert(namespace+"join",joinData);
	}
	@Override
	public String findEmail(String name, String phone) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("name", name);
		map.put("phone", phone);
		map.put("type", "E");
		return session.selectOne(namespace+"findEmail",map);
	}
	@Override
	public String findEmail(String email, String name, String phone) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("email", email);
		map.put("name", name);
		map.put("phone", phone);
		map.put("type","R");
		return session.selectOne(namespace+"findEmail", map);
	}
	@Override
	public int resetPw(String email, String pwd) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("user_email", email);
		map.put("user_pw",pwd);
		return session.update(namespace+"resetPw",map);
	}
}
