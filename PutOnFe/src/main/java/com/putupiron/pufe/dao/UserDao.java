package com.putupiron.pufe.dao;

import java.util.List;

import com.putupiron.pufe.dto.BigThree;
import com.putupiron.pufe.dto.JoinData;
import com.putupiron.pufe.dto.Statistics;
import com.putupiron.pufe.dto.TrainerInfo;
import com.putupiron.pufe.dto.TrainerView;
import com.putupiron.pufe.dto.User;
import com.putupiron.pufe.dto.UserView;

public interface UserDao {
	User	selectUser(String user_email) throws Exception;
	int		join(JoinData joinData) throws Exception;
	String	findEmail(String name, String phone) throws Exception;
	String	findEmail(String email, String name, String phone) throws Exception;
	int		resetPw(String email, String pwd) throws Exception;
	List<BigThree>	bigThreeRank() throws Exception;
	Integer userBig3Rank(String email) throws Exception;
	String	findUserName(String email) throws Exception;
	int		modify(String email, String name, String phone) throws Exception;
	int		unregister(String email) throws Exception;
	List<UserView> allUserView() throws Exception;
	UserView	homeUserView(String email) throws Exception;
	int		big3Edit(BigThree big3) throws Exception;
	List<TrainerView> allTrainerView() throws Exception;
	List<UserView> allAdminView() throws Exception;
	Statistics statistics() throws Exception;
	int		changeUserType(String user_email, String user_type) throws Exception;
	int		changeTrainer(String user_email, String trainer) throws Exception;
	List<TrainerInfo> TrainerUserView(String email) throws Exception;
}