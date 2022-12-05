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
	// 해당 이메일의 유저정보 조회
	User selectUser(String user_email) throws Exception;
	// 해당 양식으로 회원가입
	int	join(JoinData joinData) throws Exception;
	// 해당 이름과 전화번호로 등록된 이메일 조회
	String findEmail(String name, String phone) throws Exception;
	// 해당 정보와 일치하는 계정정보 조회(왜 유저를 리턴 안했지?)
	String findEmail(String email, String name, String phone) throws Exception;
	// 비밀번호 변경
	int	resetPw(String email, String pwd) throws Exception;
	// 모든 유저의 3대중량 정보 조회(높은 순으로 정렬)
	List<BigThree> bigThreeRank() throws Exception;
	// 해당 유저의 3대중량 랭킹을 리턴
	Integer userBig3Rank(String email) throws Exception;
	// 해당 계정 이용자의 이름 조회(getName으로 해도 되잖어)
	String findUserName(String email) throws Exception;
	// 회원정보 수정(이름, 전화번호)
	int	modify(String email, String name, String phone) throws Exception;
	// 회원 탈퇴
	int	unregister(String email) throws Exception;
	// 일반회원정보 조회-관리페이지
	List<UserView> allUserView() throws Exception;
	// 홈 화면에 보여줄 유저정보 리턴
	UserView homeUserView(String email) throws Exception;
	// 유저의 3대중량정보 변경-관리자,트레이너
	int big3Edit(BigThree big3) throws Exception;
	// 트레이너정보 조회-관리페이지
	List<TrainerView> allTrainerView() throws Exception;
	// 관리자정보 조회-관리페이지
	List<UserView> allAdminView() throws Exception;
	// 회원 통계-관리자
	Statistics statistics() throws Exception;
	// 회원의 유형 변경(일반-트레이너-관리자)
	int	changeUserType(String user_email, String user_type) throws Exception;
	// 회원의 전담 트레이너 변경
	int	changeTrainer(String user_email, String trainer) throws Exception;
	// 트레이너에 할당된 회원 조회
	List<TrainerInfo> TrainerUserView(String email) throws Exception;
	// 회원이 구매한 상품의 이용기간 만료시 구매정보 제거
	int	deleteExpiredGoods();
}