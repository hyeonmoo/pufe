package com.putupiron.pufe;

import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.putupiron.pufe.dao.UserDao;
import com.putupiron.pufe.dto.JoinData;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class UserDaoTest {
	@Autowired UserDao userDao;
	@Test
	public void test() throws Exception {
		JoinData user = new JoinData("email","0000","0000","name","M","01011112222","T","T");
		assertTrue(userDao.join(user)==1); // 회원가입
		assertTrue(userDao.modify("email", "name2", "01022221111")==1); // 회원정보 수정
		assertTrue(userDao.unregister("email")==1); //회원탈퇴
	}
}
