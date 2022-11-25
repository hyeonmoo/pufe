package com.putupiron.pufe.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.putupiron.pufe.dto.BigThree;
import com.putupiron.pufe.dto.JoinData;
import com.putupiron.pufe.dto.Statistics;
import com.putupiron.pufe.dto.TrainerInfo;
import com.putupiron.pufe.dto.TrainerView;
import com.putupiron.pufe.dto.User;
import com.putupiron.pufe.dto.UserView;

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
	@Override
	public List<BigThree> bigThreeRank() throws Exception {
		return session.selectList(namespace+"bigThreeRank");
	}
	@Override
	public Integer userBig3Rank(String email) throws Exception {
		return session.selectOne(namespace+"userBig3Rank",email);
	}
	@Override
	public String findUserName(String email) throws Exception {
		return session.selectOne(namespace+"findUserName",email);
	}
	@Override
	public int modify(String email, String name, String phone) throws Exception {
		Map<String,String> map= new HashMap<>();
		map.put("user_email", email);
		map.put("user_name", name);
		map.put("user_tel", phone);
		return session.update(namespace+"modify",map);
	}
	@Override
	public int unregister(String email) throws Exception {
		return session.delete(namespace+"unregister",email);
	}
	@Override
	public List<UserView> allUserView() throws Exception {
		return session.selectList(namespace+"selectAllUserView");
	}
	@Override
	public UserView homeUserView(String email) throws Exception {
		return session.selectOne(namespace+"homeUserView",email);
	}
	@Override
	public int big3Edit(BigThree big3) throws Exception {
		return session.update(namespace+"big3Edit",big3);
	}
	@Override
	public List<TrainerView> allTrainerView() throws Exception {
		return session.selectList(namespace+"selectAllTrainer");
	}
	@Override
	public List<UserView> allAdminView() throws Exception {
		return session.selectList(namespace+"selectAllAdmin");
	}
	@Override
	public Statistics statistics() throws Exception {
		return session.selectOne(namespace+"statistics");
	}
	@Override
	public int changeUserType(String user_email, String user_type) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("user_email", user_email);
		map.put("user_type", user_type);
		return session.update(namespace+"changeUserType",map);
	}
	@Override
	public int changeTrainer(String user_email, String trainer) throws Exception {
		Map<String,String> map= new HashMap<>();
		map.put("user_email", user_email);
		map.put("trainer", trainer);
		return session.update(namespace+"changeTrainer",map);
	}
	@Override
	public List<TrainerInfo> TrainerUserView(String email) throws Exception {
		return session.selectList(namespace+"selectTrainerUsers", email);
	}
}
