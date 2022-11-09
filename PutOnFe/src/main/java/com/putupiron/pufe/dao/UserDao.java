package com.putupiron.pufe.dao;

import java.util.List;

import com.putupiron.pufe.dto.BigThree;
import com.putupiron.pufe.dto.JoinData;
import com.putupiron.pufe.dto.User;

public interface UserDao {
	User	selectUser(String user_email) throws Exception;
	int		join(JoinData joinData) throws Exception;
	String	findEmail(String name, String phone) throws Exception;
	String	findEmail(String email, String name, String phone) throws Exception;
	int		resetPw(String email, String pwd) throws Exception;
	List<BigThree>	bigThreeRank() throws Exception;
	Integer userBig3Rank(String email) throws Exception;
}